import 'package:serverpod/serverpod.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/geo.dart';
import '../../generated/protocol.dart';
import '../notifications/notifier.dart';
import 'logic/checklist_rules.dart';
import 'logic/stage_rules.dart';

/// Onboarding stages, the go-live checklist and verification.
class OnboardingService {
  const OnboardingService();

  static bool isPubliclyLive(Facility f) =>
      f.onboardingStage == OnboardingStage.live &&
      f.verificationStatus == VerificationStatus.verified &&
      f.suspendedAt == null;

  Future<OnboardingRecord> recordFor(
    Session session,
    Facility facility, {
    Transaction? transaction,
  }) async {
    final existing = await OnboardingRecord.db.findFirstRow(
      session,
      where: (t) => t.facilityId.equals(facility.id!),
      transaction: transaction,
    );
    if (existing != null) return existing;
    return OnboardingRecord.db.insertRow(
      session,
      OnboardingRecord(
        facilityId: facility.id!,
        stage: facility.onboardingStage,
        updatedAt: clock.now(),
      ),
      transaction: transaction,
    );
  }

  Future<GoLiveChecklist> checklist(
    Session session,
    Facility facility, {
    Transaction? transaction,
  }) async {
    final all = await checklists(
      session,
      [facility],
      transaction: transaction,
    );
    return all[facility.id!]!;
  }

  /// The go-live checklist for many facilities at once, in four queries
  /// whatever the number of facilities (the admin pipeline lists them all).
  Future<Map<int, GoLiveChecklist>> checklists(
    Session session,
    List<Facility> facilities, {
    Transaction? transaction,
  }) async {
    if (facilities.isEmpty) return {};
    final ids = {for (final f in facilities) f.id!};
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) =>
          t.facilityId.inSet(ids) &
          t.role.inSet(<UserRole>{UserRole.hospitalAdmin, UserRole.deskStaff}),
      transaction: transaction,
    );
    final deskIds = {
      for (final r in roles)
        if (r.role == UserRole.deskStaff) r.userId,
    };
    final activeDeskIds = deskIds.isEmpty
        ? <int>{}
        : {
            for (final u in await AppUser.db.find(
              session,
              where: (t) => t.id.inSet(deskIds) & t.suspendedAt.equals(null),
              transaction: transaction,
            ))
              u.id!,
          };
    final capabilities = await FacilityCapability.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids),
      transaction: transaction,
    );
    final withStatus = {
      for (final s in await FacilityStatus.db.find(
        session,
        where: (t) => t.facilityId.inSet(ids),
        transaction: transaction,
      ))
        s.facilityId,
    };
    return {
      for (final facility in facilities)
        facility.id!: ChecklistRules.build(
          facility.id!,
          ChecklistFacts(
            verified:
                facility.verificationStatus == VerificationStatus.verified,
            hospitalAdminCount: roles
                .where(
                  (r) =>
                      r.facilityId == facility.id &&
                      r.role == UserRole.hospitalAdmin,
                )
                .length,
            activeDeskStaffCount: roles
                .where(
                  (r) =>
                      r.facilityId == facility.id &&
                      r.role == UserRole.deskStaff &&
                      activeDeskIds.contains(r.userId),
                )
                .length,
            capabilityCount: capabilities
                .where((c) => c.facilityId == facility.id)
                .length,
            hasOpeningHours: facility.openingHours != null,
            deskPhoneConfirmed: facility.deskPhoneConfirmedAt != null,
            trainingCompleted: facility.trainingCompletedAt != null,
            hasRealStatus: withStatus.contains(facility.id),
          ),
        ),
    };
  }

  /// Re-checks the go-live checklist. Promotes a verified facility to live
  /// when complete, and warns the hospital admin and agent when a live
  /// facility stops meeting it.
  Future<GoLiveChecklist> evaluate(Session session, int facilityId) async {
    final facility = await Facility.db.findById(session, facilityId);
    if (facility == null) throw Errors.notFound('Facility');
    final result = await checklist(session, facility);
    if (result.complete &&
        facility.onboardingStage == OnboardingStage.verified) {
      await session.db.transaction((tx) async {
        await moveStage(
          session,
          facility,
          OnboardingStage.live,
          byUserId: null,
          note: 'Go-live checklist complete',
          transaction: tx,
          liveAt: clock.now(),
        );
      });
    } else if (!result.complete &&
        facility.onboardingStage == OnboardingStage.live) {
      await _warnChecklistBroken(session, facility, result);
    }
    return result;
  }

  /// Writes a stage change and its event. No permission checks.
  Future<Facility> moveStage(
    Session session,
    Facility facility,
    OnboardingStage to, {
    required int? byUserId,
    String? note,
    required Transaction transaction,
    DateTime? liveAt,
  }) async {
    final now = clock.now();
    final updated = await Facility.db.updateRow(
      session,
      facility.copyWith(
        onboardingStage: to,
        liveAt: liveAt ?? facility.liveAt,
        updatedAt: now,
      ),
      transaction: transaction,
    );
    final record = await recordFor(session, facility, transaction: transaction);
    await OnboardingRecord.db.updateRow(
      session,
      record.copyWith(stage: to, updatedAt: now),
      transaction: transaction,
    );
    await OnboardingEvent.db.insertRow(
      session,
      OnboardingEvent(
        facilityId: facility.id!,
        fromStage: facility.onboardingStage,
        toStage: to,
        byUserId: byUserId,
        note: note,
        at: now,
      ),
      transaction: transaction,
    );
    return updated;
  }

  Future<Facility> setStage(
    Session session, {
    required Facility facility,
    required OnboardingStage to,
    required AppUser actor,
    required bool isPlatformAdmin,
    String? note,
  }) async {
    final reason = StageRules.checkManualMove(
      from: facility.onboardingStage,
      to: to,
      isPlatformAdmin: isPlatformAdmin,
      trainingCompleted: facility.trainingCompletedAt != null,
    );
    if (reason != null) throw Errors.invalidState(reason);
    return session.db.transaction((tx) async {
      final updated = await moveStage(
        session,
        facility,
        to,
        byUserId: actor.id,
        note: note,
        transaction: tx,
      );
      await AuditLog.record(
        session,
        actorUserId: actor.id!,
        action: 'stage:${to.name}',
        targetType: 'facility',
        targetId: facility.id!,
        reason: note,
        transaction: tx,
      );
      return updated;
    });
  }

  Future<OnboardingRecord> updateRecord(
    Session session, {
    required Facility facility,
    required AppUser actor,
    String? notes,
    DateTime? nextActionAt,
  }) async {
    final record = await recordFor(session, facility);
    return OnboardingRecord.db.updateRow(
      session,
      record.copyWith(
        notes: notes,
        nextActionAt: nextActionAt?.toUtc(),
        updatedAt: clock.now(),
      ),
    );
  }

  Future<Facility> submitForVerification(
    Session session, {
    required Facility facility,
    required AppUser actor,
    String? notes,
  }) async {
    if (facility.verificationStatus == VerificationStatus.verified) {
      throw Errors.invalidState('This facility is already verified.');
    }
    if (facility.verificationStatus == VerificationStatus.suspended) {
      throw Errors.invalidState('This facility is suspended.');
    }
    final documents = await FacilityDocument.db.count(
      session,
      where: (t) =>
          t.facilityId.equals(facility.id!) &
          t.kind.equals(DocumentKind.registration),
    );
    if (documents == 0) {
      throw Errors.invalidState('Upload the registration document first.');
    }
    return session.db.transaction((tx) async {
      final now = clock.now();
      final record = await recordFor(session, facility, transaction: tx);
      await OnboardingRecord.db.updateRow(
        session,
        record.copyWith(
          submittedAt: now,
          submittedByUserId: actor.id,
          notes: notes ?? record.notes,
          updatedAt: now,
        ),
        transaction: tx,
      );
      await AuditLog.record(
        session,
        actorUserId: actor.id!,
        action: 'verification:submit',
        targetType: 'facility',
        targetId: facility.id!,
        reason: notes,
        transaction: tx,
      );
      return Facility.db.updateRow(
        session,
        facility.copyWith(
          verificationStatus: VerificationStatus.pending,
          updatedAt: now,
        ),
        transaction: tx,
      );
    });
  }

  /// Platform admins only. An admin may approve a submission they made
  /// themselves (owner's choice, docs/DECISIONS.md 56).
  Future<Facility> approve(
    Session session, {
    required Facility facility,
    required AppUser admin,
  }) async {
    if (facility.verificationStatus != VerificationStatus.pending) {
      throw Errors.invalidState('This facility is not awaiting verification.');
    }
    return _markVerified(
      session,
      facility: facility,
      admin: admin,
      action: 'verification:approve',
      note: 'Verification approved',
    );
  }

  /// Platform admins only: verifies a listing nobody has submitted, such as
  /// an imported hospital the admin has checked by phone or a visit. The
  /// public label stays "Unverified" until the desk confirms a status.
  Future<Facility> verifyListing(
    Session session, {
    required Facility facility,
    required AppUser admin,
  }) async {
    switch (facility.verificationStatus) {
      case VerificationStatus.verified:
        throw Errors.invalidState('This hospital is already verified.');
      case VerificationStatus.suspended:
        throw Errors.invalidState('Reinstate this hospital first.');
      case VerificationStatus.pending:
        return approve(session, facility: facility, admin: admin);
      case VerificationStatus.seeded:
      case VerificationStatus.rejected:
        return _markVerified(
          session,
          facility: facility,
          admin: admin,
          action: 'verification:direct',
          note: 'Verified by a platform admin',
        );
    }
  }

  Future<Facility> _markVerified(
    Session session, {
    required Facility facility,
    required AppUser admin,
    required String action,
    required String note,
  }) async {
    final updated = await session.db.transaction((tx) async {
      var f = await Facility.db.updateRow(
        session,
        facility.copyWith(
          verificationStatus: VerificationStatus.verified,
          updatedAt: clock.now(),
        ),
        transaction: tx,
      );
      if (!StageRules.isAtLeast(f.onboardingStage, OnboardingStage.verified)) {
        f = await moveStage(
          session,
          f,
          OnboardingStage.verified,
          byUserId: admin.id,
          note: note,
          transaction: tx,
        );
      }
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: action,
        targetType: 'facility',
        targetId: facility.id!,
        transaction: tx,
      );
      return f;
    });
    await evaluate(session, facility.id!);
    return (await Facility.db.findById(session, facility.id!)) ?? updated;
  }

  Future<Facility> reject(
    Session session, {
    required Facility facility,
    required AppUser admin,
    required String reason,
  }) async {
    if (facility.verificationStatus != VerificationStatus.pending) {
      throw Errors.invalidState('This facility is not awaiting verification.');
    }
    return session.db.transaction((tx) async {
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'verification:reject',
        targetType: 'facility',
        targetId: facility.id!,
        reason: reason,
        transaction: tx,
      );
      return Facility.db.updateRow(
        session,
        facility.copyWith(
          verificationStatus: VerificationStatus.rejected,
          updatedAt: clock.now(),
        ),
        transaction: tx,
      );
    });
  }

  /// Called after a practice status update.
  Future<void> markTrainingCompleted(Session session, Facility facility) async {
    if (facility.trainingCompletedAt != null) return;
    await session.db.transaction((tx) async {
      var f = await Facility.db.updateRow(
        session,
        facility.copyWith(trainingCompletedAt: clock.now()),
        transaction: tx,
      );
      if (!StageRules.isAtLeast(
            f.onboardingStage,
            OnboardingStage.staffTrained,
          ) &&
          f.onboardingStage != OnboardingStage.paused &&
          f.onboardingStage != OnboardingStage.declined) {
        f = await moveStage(
          session,
          f,
          OnboardingStage.staffTrained,
          byUserId: null,
          note: 'Training mode completed',
          transaction: tx,
        );
      }
    });
  }

  /// Facilities a field agent is responsible for, nearest first when a
  /// location is given.
  Future<List<AgentFacility>> agentFacilities(
    Session session, {
    required AppUser agent,
    double? lat,
    double? lng,
  }) async {
    final areas = await FieldAgentArea.db.find(
      session,
      where: (t) => t.userId.equals(agent.id!),
    );
    final records = await OnboardingRecord.db.find(
      session,
      where: (t) => t.assignedAgentUserId.equals(agent.id!),
    );
    final ids = {for (final r in records) r.facilityId};
    final areaNames = {for (final a in areas) a.area};
    if (ids.isEmpty && areaNames.isEmpty) return [];
    final facilities = await Facility.db.find(
      session,
      where: (t) {
        final byId = t.id.inSet(ids.isEmpty ? {-1} : ids);
        return areaNames.isEmpty ? byId : byId | t.area.inSet(areaNames);
      },
      orderBy: (t) => t.name,
    );
    final allRecords = await OnboardingRecord.db.find(
      session,
      where: (t) =>
          t.facilityId.inSet(<int>{for (final f in facilities) f.id!}),
    );
    final byFacility = {for (final r in allRecords) r.facilityId: r};
    final checklistBy = await checklists(session, facilities);
    final result = <AgentFacility>[];
    for (final f in facilities) {
      final list = checklistBy[f.id]!;
      final record = byFacility[f.id];
      result.add(
        AgentFacility(
          facility: summary(f),
          address: f.address,
          nextActionAt: record?.nextActionAt,
          notes: record?.notes,
          checklistDone: list.items.where((i) => i.done).length,
          checklistTotal: list.items.length,
          submitted: record?.submittedAt != null,
          distanceMeters: lat == null || lng == null
              ? null
              : haversineKm(lat, lng, f.lat, f.lng) * 1000,
        ),
      );
    }
    if (lat != null && lng != null) {
      result.sort((a, b) => a.distanceMeters!.compareTo(b.distanceMeters!));
    }
    return result;
  }

  static FacilitySummary summary(Facility f) => FacilitySummary(
    id: f.id!,
    name: f.name,
    area: f.area,
    onboardingStage: f.onboardingStage,
    verificationStatus: f.verificationStatus,
  );

  Future<void> _warnChecklistBroken(
    Session session,
    Facility facility,
    GoLiveChecklist checklist,
  ) async {
    const kind = 'checklist_broken';
    if (await Notifier.sentRecently(
      session,
      facilityId: facility.id!,
      kind: kind,
      window: const Duration(hours: 24),
    )) {
      return;
    }
    final missing = checklist.items.where((i) => !i.done).map((i) => i.label);
    final message =
        'EmergencyHr: ${facility.name} no longer meets the go-live checklist '
        '(${missing.join('; ')}). Please fix this so your status stays visible.';
    final admins = await RoleAssignment.db.find(
      session,
      where: (t) =>
          t.facilityId.equals(facility.id!) &
          t.role.equals(UserRole.hospitalAdmin),
    );
    final record = await recordFor(session, facility);
    final userIds = {
      for (final a in admins) a.userId,
      ?record.assignedAgentUserId,
    };
    final users = await AppUser.db.find(
      session,
      where: (t) => t.id.inSet(userIds.isEmpty ? {-1} : userIds),
    );
    for (final u in users) {
      if (u.phone == null) continue;
      await Notifier.sms(
        session,
        to: u.phone!,
        message: message,
        kind: kind,
        facilityId: facility.id,
      );
    }
  }
}
