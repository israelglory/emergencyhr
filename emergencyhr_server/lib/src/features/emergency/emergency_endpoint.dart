import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../profile/family_alert_service.dart';
import '../status/status_service.dart';
import 'emergency_service.dart';
import 'report_service.dart';

/// The emergency flow. Who may call: anyone, signed in or not. Session
/// updates need the session's private access token.
class EmergencyEndpoint extends Endpoint {
  static const _emergency = EmergencyService();
  static final _reports = ReportService();
  static final _family = FamilyAlertService();

  /// Starts a session and returns ranked results.
  Future<EmergencySearch> start(
    Session session,
    double lat,
    double lng,
    EmergencyType type, {
    String? area,
    DateTime? tappedAt,
  }) async {
    Validate.coordinates(lat, lng);
    final user = await AuthGuard.currentUser(session);
    return _emergency.start(
      session,
      user: user,
      lat: lat,
      lng: lng,
      type: type,
      area: Validate.optionalText(area, field: 'area', max: 80),
      tappedAt: tappedAt,
    );
  }

  /// Fresh ranking for an existing session (pull to refresh).
  Future<EmergencySearch> refresh(
    Session session,
    int sessionId,
    String accessToken,
  ) async {
    final row = await _emergency.requireSession(
      session,
      sessionId: sessionId,
      accessToken: accessToken,
    );
    return _emergency.refresh(session, row, accessToken);
  }

  /// Changes "What happened" or the area for an open session and returns
  /// the new ranking. Who may call: the holder of the session token. Pass
  /// [lat] and [lng] together, or neither to keep the place.
  Future<EmergencySearch> updateSearch(
    Session session,
    int sessionId,
    String accessToken,
    EmergencyType type, {
    double? lat,
    double? lng,
    String? area,
  }) async {
    if ((lat == null) != (lng == null)) {
      throw Errors.validation('Send both lat and lng, or neither.');
    }
    if (lat != null) Validate.coordinates(lat, lng!);
    final row = await _emergency.requireSession(
      session,
      sessionId: sessionId,
      accessToken: accessToken,
    );
    return _emergency.updateSearch(
      session,
      row,
      accessToken,
      type: type,
      place: lat == null
          ? null
          : (
              lat: lat,
              lng: lng!,
              area: Validate.optionalText(area, field: 'area', max: 80),
            ),
    );
  }

  /// Re-ranks and emits whenever a listed facility changes status, so an
  /// open results list updates within seconds.
  Stream<EmergencySearch> watch(
    Session session,
    int sessionId,
    String accessToken,
  ) async* {
    final row = await _emergency.requireSession(
      session,
      sessionId: sessionId,
      accessToken: accessToken,
    );
    final watched = row.resultsShown.toSet();
    final updates = session.messages.createStream<FacilityStatusChanged>(
      StatusService.channel,
    );
    await for (final change in updates) {
      if (!watched.contains(change.facilityId)) continue;
      // Re-read: the type or place may have changed since the stream began.
      final current =
          await EmergencySession.db.findById(session, sessionId) ?? row;
      final next = await _emergency.refresh(session, current, accessToken);
      watched.addAll(next.results.map((r) => r.facilityId));
      yield next;
    }
  }

  Future<void> recordAction(
    Session session,
    int sessionId,
    String accessToken,
    EmergencyAction action, {
    int? facilityId,
  }) async {
    final row = await _emergency.requireSession(
      session,
      sessionId: sessionId,
      accessToken: accessToken,
    );
    await _emergency.recordAction(
      session,
      row,
      action: action,
      facilityId: facilityId,
    );
  }

  /// Report a wrong status. Who may call: signed-in users, for 24 hours
  /// after acting on that hospital.
  Future<void> reportWrongStatus(
    Session session,
    int sessionId,
    String accessToken,
    int facilityId,
    String reason,
  ) async {
    final user = await AuthGuard.requireUser(session);
    final row = await _emergency.requireSession(
      session,
      sessionId: sessionId,
      accessToken: accessToken,
    );
    await _reports.report(
      session,
      emergencySession: row,
      user: user,
      facilityId: facilityId,
      reason: reason,
    );
  }

  /// Texts the user's emergency contacts. Who may call: signed-in users,
  /// for their own session.
  Future<FamilyAlertResult> notifyFamily(
    Session session,
    int sessionId,
    String accessToken,
  ) async {
    final user = await AuthGuard.requireUser(session);
    final row = await _emergency.requireSession(
      session,
      sessionId: sessionId,
      accessToken: accessToken,
    );
    return _family.notify(session, user: user, emergencySession: row);
  }

  /// Hospital detail page. Who may call: anyone.
  Future<PublicFacility> facility(Session session, int facilityId) {
    return _emergency.publicFacility(session, facilityId);
  }
}
