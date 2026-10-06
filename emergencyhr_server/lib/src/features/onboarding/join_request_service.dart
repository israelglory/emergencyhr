import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import 'onboarding_service.dart';

/// The light "we are interested" form for hospitals not ready to sign up.
class JoinRequestService {
  JoinRequestService({this.onboarding = const OnboardingService()});

  final OnboardingService onboarding;

  final _perIp = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'join',
      source: 'ip',
      maxAttempts: 10,
      timeframe: const Duration(hours: 1),
    ),
  );

  Future<JoinRequest> submit(
    Session session, {
    required String hospitalName,
    required String contactName,
    required String phone,
    required String area,
    String? message,
  }) async {
    final ip = session.request?.connectionInfo.remote.address.toString();
    if (ip != null && !await _perIp.tryRecordAttempt(session, key: ip)) {
      throw Errors.rateLimited(retryAfterSeconds: 3600);
    }
    final now = clock.now();
    return JoinRequest.db.insertRow(
      session,
      JoinRequest(
        hospitalName: Validate.text(
          hospitalName,
          field: 'hospitalName',
          min: 3,
          max: 120,
        ),
        contactName: Validate.text(contactName, field: 'contactName', max: 120),
        phone: Validate.phone(phone),
        area: Validate.text(area, field: 'area', max: 80),
        message: Validate.optionalText(message, field: 'message', max: 1000),
        status: JoinRequestStatus.received,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<List<JoinRequest>> list(
    Session session, {
    JoinRequestStatus? status,
    required int limit,
    required int offset,
  }) {
    final page = Validate.page(limit, offset);
    return JoinRequest.db.find(
      session,
      where: status == null ? null : (t) => t.status.equals(status),
      orderBy: (t) => t.createdAt.desc(),
      limit: page.limit,
      offset: page.offset,
    );
  }

  Future<JoinRequest> setStatus(
    Session session, {
    required JoinRequest request,
    required JoinRequestStatus status,
    required AppUser admin,
  }) async {
    await AuditLog.record(
      session,
      actorUserId: admin.id!,
      action: 'join:${status.name}',
      targetType: 'joinRequest',
      targetId: request.id!,
    );
    return JoinRequest.db.updateRow(
      session,
      request.copyWith(status: status, updatedAt: clock.now()),
    );
  }

  /// Turns the request into a seeded listing assigned to a field agent.
  Future<JoinRequest> convert(
    Session session, {
    required JoinRequest request,
    required AppUser admin,
    required int agentUserId,
    required double lat,
    required double lng,
    required String address,
  }) async {
    if (request.status == JoinRequestStatus.converted) {
      throw Errors.invalidState('This request was already converted.');
    }
    Validate.coordinates(lat, lng);
    final isAgent = await RoleAssignment.db.count(
      session,
      where: (t) =>
          t.userId.equals(agentUserId) & t.role.equals(UserRole.fieldAgent),
    );
    if (isAgent == 0) throw Errors.validation('Choose a field agent.');
    return session.db.transaction((tx) async {
      final now = clock.now();
      final facility = await Facility.db.insertRow(
        session,
        Facility(
          name: request.hospitalName,
          type: FacilityType.private,
          address: Validate.text(address, field: 'address', max: 300),
          area: request.area,
          lat: lat,
          lng: lng,
          contactName: request.contactName,
          contactPhone: request.phone,
          verificationStatus: VerificationStatus.seeded,
          onboardingStage: OnboardingStage.contacted,
          source: FacilitySource.fieldAgent,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: tx,
      );
      await OnboardingRecord.db.insertRow(
        session,
        OnboardingRecord(
          facilityId: facility.id!,
          stage: OnboardingStage.contacted,
          assignedAgentUserId: agentUserId,
          notes: request.message,
          updatedAt: now,
        ),
        transaction: tx,
      );
      await OnboardingEvent.db.insertRow(
        session,
        OnboardingEvent(
          facilityId: facility.id!,
          toStage: OnboardingStage.contacted,
          byUserId: admin.id,
          note: 'Converted from join request',
          at: now,
        ),
        transaction: tx,
      );
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'join:convert',
        targetType: 'joinRequest',
        targetId: request.id!,
        transaction: tx,
      );
      return JoinRequest.db.updateRow(
        session,
        request.copyWith(
          status: JoinRequestStatus.converted,
          facilityId: facility.id,
          updatedAt: now,
        ),
        transaction: tx,
      );
    });
  }
}
