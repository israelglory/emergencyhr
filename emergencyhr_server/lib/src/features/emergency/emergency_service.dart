import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/geo.dart';
import '../../generated/protocol.dart';
import '../auth/otp_codes.dart';
import '../auth/otp_service.dart';
import '../status/logic/freshness_rules.dart';
import 'logic/ranking.dart';
import 'routing_service.dart';

/// The emergency flow: ranked results, live updates and session tracking.
class EmergencyService {
  const EmergencyService({this.routing = const HaversineRoutingService()});

  final RoutingService routing;

  static const radiusKm = 10.0;
  static const widenedRadiusKm = 25.0;
  static const maxResults = 25;
  static final _random = Random.secure();

  static String _newToken() => base64Url
      .encode(List<int>.generate(24, (_) => _random.nextInt(256)))
      .replaceAll('=', '');

  static String _hash(Session session, String token) =>
      OtpCodes.hash(token, 'emergency', OtpService.pepper(session));

  /// Ranks facilities near a point. Widens to 25 km when Tier 1 is empty.
  Future<({List<EmergencyResult> results, double radiusKm})> rankNear(
    Session session, {
    required double lat,
    required double lng,
    required EmergencyType type,
  }) async {
    var radius = radiusKm;
    var results = await _rankWithin(session, lat, lng, type, radius);
    if (!results.any((r) => r.rankTier == 1)) {
      radius = widenedRadiusKm;
      results = await _rankWithin(session, lat, lng, type, radius);
    }
    return (results: results.take(maxResults).toList(), radiusKm: radius);
  }

  Future<List<EmergencyResult>> _rankWithin(
    Session session,
    double lat,
    double lng,
    EmergencyType type,
    double radius,
  ) async {
    final box = boundingBox(lat, lng, radius);
    final facilities = await Facility.db.find(
      session,
      where: (t) =>
          t.lat.between(box.minLat, box.maxLat) &
          t.lng.between(box.minLng, box.maxLng) &
          t.suspendedAt.equals(null) &
          t.onboardingStage.notEquals(OnboardingStage.declined),
    );
    final inRange = <Facility, double>{};
    for (final f in facilities) {
      final km = haversineKm(lat, lng, f.lat, f.lng);
      if (km <= radius) inRange[f] = km;
    }
    if (inRange.isEmpty) return [];
    final ids = {for (final f in inRange.keys) f.id!};
    // Two batched queries instead of one per facility.
    final statuses = await FacilityStatus.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids),
    );
    final capabilityRows = await FacilityCapability.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids),
    );
    final statusById = {for (final s in statuses) s.facilityId: s};
    final capsById = <int, Set<Capability>>{};
    for (final c in capabilityRows) {
      capsById.putIfAbsent(c.facilityId, () => {}).add(c.capability);
    }
    return Ranking.rank(
      candidates: [
        for (final MapEntry(key: f, value: km) in inRange.entries)
          RankingCandidate(
            facility: f,
            capabilities: capsById[f.id] ?? const {},
            status: statusById[f.id],
            distanceKm: km,
            etaMinutes: routing.etaMinutes(km),
          ),
      ],
      type: type,
      now: clock.now(),
    );
  }

  Future<EmergencySearch> start(
    Session session, {
    required AppUser? user,
    required double lat,
    required double lng,
    required EmergencyType type,
    String? area,
    DateTime? tappedAt,
  }) async {
    final now = clock.now();
    // The client sends when Emergency was tapped; accept it only if recent.
    final startedAt =
        tappedAt != null &&
            tappedAt.isBefore(now) &&
            now.difference(tappedAt) < const Duration(minutes: 15)
        ? tappedAt.toUtc()
        : now;
    final ranked = await rankNear(session, lat: lat, lng: lng, type: type);
    final token = _newToken();
    final emergencySession = await EmergencySession.db.insertRow(
      session,
      EmergencySession(
        userId: user?.id,
        accessTokenHash: _hash(session, token),
        lat: lat,
        lng: lng,
        area: area,
        emergencyType: type,
        resultsShown: [for (final r in ranked.results) r.facilityId],
        emptyResult: Ranking.noAccepting(ranked.results),
        action: EmergencyAction.none,
        startedAt: startedAt,
      ),
    );
    return EmergencySearch(
      sessionId: emergencySession.id!,
      accessToken: token,
      emergencyType: type,
      radiusKm: ranked.radiusKm,
      results: ranked.results,
      showCall112: Ranking.noAccepting(ranked.results),
      computedAt: now,
    );
  }

  /// Checks the guest token or the signed-in owner.
  Future<EmergencySession> requireSession(
    Session session, {
    required int sessionId,
    required String accessToken,
  }) async {
    final row = await EmergencySession.db.findById(session, sessionId);
    if (row == null) throw Errors.notFound('Emergency session');
    final expected = row.accessTokenHash ?? '';
    if (!OtpCodes.matches(expected, _hash(session, accessToken))) {
      throw Errors.notAuthorized();
    }
    return row;
  }

  Future<EmergencySearch> refresh(
    Session session,
    EmergencySession row,
    String accessToken,
  ) async {
    final ranked = await rankNear(
      session,
      lat: row.lat,
      lng: row.lng,
      type: row.emergencyType,
    );
    return EmergencySearch(
      sessionId: row.id!,
      accessToken: accessToken,
      emergencyType: row.emergencyType,
      radiusKm: ranked.radiusKm,
      results: ranked.results,
      showCall112: Ranking.noAccepting(ranked.results),
      computedAt: clock.now(),
    );
  }

  /// Changes the type filter, the place, or both, for an open session and
  /// re-ranks. Hospitals shown earlier stay on the session so actions and
  /// reports on them remain valid.
  Future<EmergencySearch> updateSearch(
    Session session,
    EmergencySession row,
    String accessToken, {
    required EmergencyType type,
    ({double lat, double lng, String? area})? place,
  }) async {
    final lat = place?.lat ?? row.lat;
    final lng = place?.lng ?? row.lng;
    final ranked = await rankNear(session, lat: lat, lng: lng, type: type);
    final shown = {
      ...row.resultsShown,
      for (final r in ranked.results) r.facilityId,
    };
    await EmergencySession.db.updateRow(
      session,
      row.copyWith(
        emergencyType: type,
        lat: lat,
        lng: lng,
        area: place == null ? row.area : place.area,
        resultsShown: shown.toList(),
        emptyResult: Ranking.noAccepting(ranked.results),
      ),
    );
    return EmergencySearch(
      sessionId: row.id!,
      accessToken: accessToken,
      emergencyType: type,
      radiusKm: ranked.radiusKm,
      results: ranked.results,
      showCall112: Ranking.noAccepting(ranked.results),
      computedAt: clock.now(),
    );
  }

  /// Records the first action; later actions update the action only, so
  /// time-to-action stays the time to the first call or directions.
  Future<void> recordAction(
    Session session,
    EmergencySession row, {
    required EmergencyAction action,
    int? facilityId,
  }) async {
    if (facilityId != null && !row.resultsShown.contains(facilityId)) {
      throw Errors.validation('That hospital was not in your results.');
    }
    await EmergencySession.db.updateRow(
      session,
      row.copyWith(
        action: action,
        facilityId: facilityId ?? row.facilityId,
        actedAt: row.actedAt ?? clock.now(),
      ),
    );
  }

  /// Public view of one facility, for the hospital detail page.
  Future<PublicFacility> publicFacility(Session session, int facilityId) async {
    final f = await Facility.db.findById(session, facilityId);
    if (f == null || f.suspendedAt != null) throw Errors.notFound('Hospital');
    final status = await FacilityStatus.db.findFirstRow(
      session,
      where: (t) => t.facilityId.equals(facilityId),
    );
    final caps = await FacilityCapability.db.find(
      session,
      where: (t) => t.facilityId.equals(facilityId),
    );
    final live =
        f.onboardingStage == OnboardingStage.live &&
        f.verificationStatus == VerificationStatus.verified;
    return PublicFacility(
      id: f.id!,
      name: f.name,
      type: f.type,
      address: f.address,
      area: f.area,
      lat: f.lat,
      lng: f.lng,
      deskPhone: f.deskPhone,
      openingHours: f.openingHours,
      capabilities: [for (final c in caps) c.capability],
      freshness: FreshnessRules.classify(
        status: status,
        live: live,
        flagged: f.flaggedAt != null,
        now: clock.now(),
      ),
      status: live ? status : null,
      live: live,
      dataSource: f.source == FacilitySource.imported
          ? importCredit(f.sourceRef)
          : null,
    );
  }

  /// The attribution an open-data licence asks for, from the source id.
  static String? importCredit(String? sourceRef) =>
      sourceRef != null && sourceRef.startsWith('grid3-')
      ? 'Location from GRID3 (CC BY 4.0)'
      : null;
}
