import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../auth/account_service.dart';
import '../facilities/logic/opening_hours_rules.dart';
import '../onboarding/onboarding_service.dart';
import '../status/status_service.dart';

/// Platform admin work: queues, directory, pipeline, agents, dashboards.
class AdminService {
  const AdminService({this.onboarding = const OnboardingService()});

  final OnboardingService onboarding;

  static const pilotTargetMin = 25;
  static const pilotTargetMax = 40;

  Future<Map<int, String>> _names(Session session, Set<int> ids) async {
    if (ids.isEmpty) return {};
    final users = await AppUser.db.find(session, where: (t) => t.id.inSet(ids));
    return {for (final u in users) u.id!: AccountService.displayName(u)};
  }

  Future<List<VerificationItem>> verificationQueue(
    Session session, {
    required int limit,
    required int offset,
  }) async {
    final page = Validate.page(limit, offset);
    final facilities = await Facility.db.find(
      session,
      where: (t) => t.verificationStatus.equals(VerificationStatus.pending),
      orderBy: (t) => t.updatedAt,
      limit: page.limit,
      offset: page.offset,
    );
    if (facilities.isEmpty) return [];
    final ids = {for (final f in facilities) f.id!};
    final records = await OnboardingRecord.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids),
    );
    final recordBy = {for (final r in records) r.facilityId: r};
    final docs = await FacilityDocument.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids),
      orderBy: (t) => t.createdAt,
    );
    final names = await _names(session, {
      for (final r in records) ?r.submittedByUserId,
    });
    return [
      for (final f in facilities)
        VerificationItem(
          facility: OnboardingService.summary(f),
          address: f.address,
          submittedAt: recordBy[f.id]?.submittedAt,
          submittedByName: names[recordBy[f.id]?.submittedByUserId],
          notes: recordBy[f.id]?.notes,
          documents: [
            for (final d in docs)
              if (d.facilityId == f.id) d,
          ],
          checklist: await onboarding.checklist(session, f),
        ),
    ];
  }

  Future<List<DirectoryRow>> directory(
    Session session, {
    String? query,
    String? area,
    OnboardingStage? stage,
    required int limit,
    required int offset,
  }) async {
    final page = Validate.page(limit, offset);
    final q = query?.trim();
    final rows = await Facility.db.find(
      session,
      where: (t) {
        Expression<dynamic> e = Constant.bool(true);
        if (q != null && q.isNotEmpty) e = e & t.name.ilike('%$q%');
        if (area != null) e = e & t.area.equals(area);
        if (stage != null) e = e & t.onboardingStage.equals(stage);
        return e;
      },
      orderBy: (t) => t.name,
      limit: page.limit,
      offset: page.offset,
    );
    return [
      for (final f in rows)
        DirectoryRow(
          facility: OnboardingService.summary(f),
          address: f.address,
          source: f.source,
          suspended: f.suspendedAt != null,
          flagged: f.flaggedAt != null,
        ),
    ];
  }

  Future<PipelineBoard> pipeline(
    Session session, {
    String? area,
    int? agentUserId,
  }) async {
    final all = await Facility.db.find(
      session,
      where: area == null ? null : (t) => t.area.equals(area),
      orderBy: (t) => t.name,
    );
    final records = await OnboardingRecord.db.find(session);
    final recordBy = {for (final r in records) r.facilityId: r};
    final facilities = agentUserId == null
        ? all
        : [
            for (final f in all)
              if (recordBy[f.id]?.assignedAgentUserId == agentUserId) f,
          ];
    final names = await _names(session, {
      for (final r in records) ?r.assignedAgentUserId,
    });
    final checklists = await onboarding.checklists(session, facilities);
    final rows = <PipelineRow>[];
    for (final f in facilities) {
      final list = checklists[f.id]!;
      final r = recordBy[f.id];
      rows.add(
        PipelineRow(
          facility: OnboardingService.summary(f),
          agentUserId: r?.assignedAgentUserId,
          agentName: names[r?.assignedAgentUserId],
          notes: r?.notes,
          nextActionAt: r?.nextActionAt,
          checklistDone: list.items.where((i) => i.done).length,
          checklistTotal: list.items.length,
        ),
      );
    }
    return PipelineBoard(
      counts: [
        for (final s in OnboardingStage.values)
          StageCount(
            stage: s,
            count: facilities.where((f) => f.onboardingStage == s).length,
          ),
      ],
      liveCount: all
          .where((f) => f.onboardingStage == OnboardingStage.live)
          .length,
      targetMin: pilotTargetMin,
      targetMax: pilotTargetMax,
      rows: rows,
    );
  }

  Future<void> assignAgent(
    Session session, {
    required List<int> facilityIds,
    required int agentUserId,
    required AppUser admin,
  }) async {
    final isAgent = await RoleAssignment.db.count(
      session,
      where: (t) =>
          t.userId.equals(agentUserId) & t.role.equals(UserRole.fieldAgent),
    );
    if (isAgent == 0) throw Errors.validation('Choose a field agent.');
    await session.db.transaction((tx) async {
      for (final id in facilityIds.toSet()) {
        final facility = await Facility.db.findById(
          session,
          id,
          transaction: tx,
        );
        if (facility == null) continue;
        final record = await onboarding.recordFor(
          session,
          facility,
          transaction: tx,
        );
        await OnboardingRecord.db.updateRow(
          session,
          record.copyWith(
            assignedAgentUserId: agentUserId,
            updatedAt: clock.now(),
          ),
          transaction: tx,
        );
        await AuditLog.record(
          session,
          actorUserId: admin.id!,
          action: 'agent:assign',
          targetType: 'facility',
          targetId: id,
          reason: 'agent $agentUserId',
          transaction: tx,
        );
      }
    });
  }

  Future<List<AgentRow>> agents(Session session) async {
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) => t.role.equals(UserRole.fieldAgent),
    );
    final ids = {for (final r in roles) r.userId};
    if (ids.isEmpty) return [];
    final users = await AppUser.db.find(
      session,
      where: (t) => t.id.inSet(ids),
      orderBy: (t) => t.name,
    );
    final areas = await FieldAgentArea.db.find(
      session,
      where: (t) => t.userId.inSet(ids),
    );
    final records = await OnboardingRecord.db.find(
      session,
      where: (t) => t.assignedAgentUserId.inSet(ids),
    );
    return [
      for (final u in users)
        AgentRow(
          userId: u.id!,
          name: u.name,
          email: u.email,
          phone: u.phone,
          areas: [
            for (final a in areas)
              if (a.userId == u.id) a.area,
          ]..sort(),
          facilityCount: records
              .where((r) => r.assignedAgentUserId == u.id)
              .length,
          active: u.suspendedAt == null,
        ),
    ];
  }

  /// Gives the field agent role to an existing account, found by email.
  /// The person creates their account first, then an admin promotes it.
  Future<AgentRow> addAgent(
    Session session, {
    required String email,
    required List<String> areas,
    required AppUser admin,
  }) async {
    final user = await const AccountService().findByEmail(
      session,
      Validate.email(email),
    );
    if (user == null) {
      throw Errors.validation(
        'No account uses this email yet. Ask them to create an account in '
        'the app first, then add them here.',
        field: 'email',
      );
    }
    await session.db.transaction((tx) async {
      final has = await RoleAssignment.db.count(
        session,
        where: (t) =>
            t.userId.equals(user.id!) & t.role.equals(UserRole.fieldAgent),
        transaction: tx,
      );
      if (has == 0) {
        await RoleAssignment.db.insertRow(
          session,
          RoleAssignment(
            userId: user.id!,
            role: UserRole.fieldAgent,
            createdByUserId: admin.id,
          ),
          transaction: tx,
        );
      }
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'agent:add',
        targetType: 'user',
        targetId: user.id!,
        transaction: tx,
      );
    });
    await setAgentAreas(session, userId: user.id!, areas: areas, admin: admin);
    return (await agents(session)).firstWhere((a) => a.userId == user.id);
  }

  Future<void> setAgentAreas(
    Session session, {
    required int userId,
    required List<String> areas,
    required AppUser admin,
  }) async {
    final clean = {
      for (final a in areas) Validate.text(a, field: 'areas', max: 80),
    };
    await session.db.transaction((tx) async {
      await FieldAgentArea.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId),
        transaction: tx,
      );
      if (clean.isNotEmpty) {
        await FieldAgentArea.db.insert(session, [
          for (final a in clean) FieldAgentArea(userId: userId, area: a),
        ], transaction: tx);
      }
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'agent:areas',
        targetType: 'user',
        targetId: userId,
        reason: clean.join(', '),
        transaction: tx,
      );
    });
  }

  Future<void> deactivateAgent(
    Session session, {
    required int userId,
    required AppUser admin,
  }) async {
    await session.db.transaction((tx) async {
      await RoleAssignment.db.deleteWhere(
        session,
        where: (t) =>
            t.userId.equals(userId) & t.role.equals(UserRole.fieldAgent),
        transaction: tx,
      );
      await FieldAgentArea.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId),
        transaction: tx,
      );
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'agent:deactivate',
        targetType: 'user',
        targetId: userId,
        transaction: tx,
      );
    });
  }

  /// Live facilities, stalest first.
  Future<List<FreshnessRow>> freshness(
    Session session, {
    required int limit,
    required int offset,
  }) async {
    final page = Validate.page(limit, offset);
    final live = await Facility.db.find(
      session,
      where: (t) => t.onboardingStage.equals(OnboardingStage.live),
    );
    if (live.isEmpty) return [];
    final statuses = await FacilityStatus.db.find(
      session,
      where: (t) => t.facilityId.inSet(<int>{for (final f in live) f.id!}),
    );
    final statusBy = {for (final s in statuses) s.facilityId: s};
    final now = clock.now();
    final rows =
        [
          for (final f in live)
            FreshnessRow(
              facility: OnboardingService.summary(f),
              lastUpdateAt: statusBy[f.id]?.updatedAt,
              accepting: statusBy[f.id]?.accepting,
              openNow: OpeningHoursRules.isOpen(f.openingHours, now),
            ),
        ]..sort((a, b) {
          final at = a.lastUpdateAt ?? DateTime.utc(1970);
          final bt = b.lastUpdateAt ?? DateTime.utc(1970);
          return at.compareTo(bt);
        });
    return rows.skip(page.offset).take(page.limit).toList();
  }

  Future<List<ReportRow>> reports(
    Session session, {
    bool onlyFlagged = false,
  }) async {
    final open = await StatusReport.db.find(
      session,
      where: (t) => t.reviewedAt.equals(null),
      orderBy: (t) => t.createdAt.desc(),
    );
    final flaggedFacilities = await Facility.db.find(
      session,
      where: (t) => t.flaggedAt.notEquals(null),
    );
    final ids = {
      for (final r in open) r.facilityId,
      for (final f in flaggedFacilities) f.id!,
    };
    if (ids.isEmpty) return [];
    final facilities = await Facility.db.find(
      session,
      where: (t) => t.id.inSet(ids),
    );
    final rows = <ReportRow>[];
    for (final f in facilities) {
      final mine = open.where((r) => r.facilityId == f.id).toList();
      if (onlyFlagged && f.flaggedAt == null) continue;
      rows.add(
        ReportRow(
          facility: OnboardingService.summary(f),
          flagged: f.flaggedAt != null,
          openReports: mine.length,
          latestReason: mine.isEmpty ? 'Flagged for review' : mine.first.reason,
          latestAt: mine.isEmpty ? f.flaggedAt! : mine.first.createdAt,
        ),
      );
    }
    rows.sort((a, b) {
      if (a.flagged != b.flagged) return a.flagged ? -1 : 1;
      return b.latestAt.compareTo(a.latestAt);
    });
    return rows;
  }

  /// Marks reports reviewed and lifts the flag.
  Future<void> reviewReports(
    Session session, {
    required int facilityId,
    required AppUser admin,
    String? note,
  }) async {
    final now = clock.now();
    final facility = await session.db.transaction((tx) async {
      final open = await StatusReport.db.find(
        session,
        where: (t) =>
            t.facilityId.equals(facilityId) & t.reviewedAt.equals(null),
        transaction: tx,
      );
      for (final r in open) {
        await StatusReport.db.updateRow(
          session,
          r.copyWith(reviewedAt: now, reviewedByUserId: admin.id),
          transaction: tx,
        );
      }
      final f = await Facility.db.findById(
        session,
        facilityId,
        transaction: tx,
      );
      if (f == null) throw Errors.notFound('Facility');
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'reports:review',
        targetType: 'facility',
        targetId: facilityId,
        reason: note,
        transaction: tx,
      );
      return Facility.db.updateRow(
        session,
        f.copyWith(flaggedAt: null),
        transaction: tx,
      );
    });
    await _publish(session, facility);
  }

  Future<Facility> setFacilitySuspended(
    Session session, {
    required int facilityId,
    required bool suspended,
    required String reason,
    required AppUser admin,
  }) async {
    final why = Validate.text(reason, field: 'reason', max: 500);
    final f = await session.db.transaction((tx) async {
      final facility = await Facility.db.findById(
        session,
        facilityId,
        transaction: tx,
      );
      if (facility == null) throw Errors.notFound('Facility');
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: suspended ? 'facility:suspend' : 'facility:reinstate',
        targetType: 'facility',
        targetId: facilityId,
        reason: why,
        transaction: tx,
      );
      return Facility.db.updateRow(
        session,
        facility.copyWith(
          suspendedAt: suspended ? clock.now() : null,
          suspendReason: suspended ? why : null,
          updatedAt: clock.now(),
        ),
        transaction: tx,
      );
    });
    await _publish(session, f);
    return f;
  }

  Future<List<UserRow>> users(
    Session session, {
    String? query,
    required int limit,
    required int offset,
  }) async {
    final page = Validate.page(limit, offset);
    final q = query?.trim() ?? '';
    final rows = await AppUser.db.find(
      session,
      where: q.isEmpty
          ? null
          : (t) =>
                t.email.ilike('%$q%') |
                t.phone.ilike('%$q%') |
                t.name.ilike('%$q%'),
      orderBy: (t) => t.createdAt.desc(),
      limit: page.limit,
      offset: page.offset,
    );
    if (rows.isEmpty) return [];
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) => t.userId.inSet(<int>{for (final u in rows) u.id!}),
    );
    return [
      for (final u in rows)
        UserRow(
          userId: u.id!,
          name: u.name,
          email: u.email,
          phone: u.phone,
          roles: {
            for (final r in roles)
              if (r.userId == u.id) r.role,
          }.toList(),
          suspended: u.suspendedAt != null,
        ),
    ];
  }

  Future<void> setUserSuspended(
    Session session, {
    required int userId,
    required bool suspended,
    required String reason,
    required AppUser admin,
  }) async {
    if (userId == admin.id) {
      throw Errors.invalidState('You cannot suspend your own account.');
    }
    final why = Validate.text(reason, field: 'reason', max: 500);
    final user = await AppUser.db.findById(session, userId);
    if (user == null) throw Errors.notFound('Account');
    await session.db.transaction((tx) async {
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: suspended ? 'user:suspend' : 'user:reinstate',
        targetType: 'user',
        targetId: userId,
        reason: why,
        transaction: tx,
      );
      await AppUser.db.updateRow(
        session,
        user.copyWith(
          suspendedAt: suspended ? clock.now() : null,
          suspendReason: suspended ? why : null,
        ),
        transaction: tx,
      );
    });
    if (suspended) {
      // Sign the account out everywhere.
      await AuthServices.instance.tokenManager.revokeAllTokens(
        session,
        authUserId: user.authUserId,
      );
    }
  }

  Future<PlatformMetrics> metrics(Session session, {int days = 30}) async {
    final since = clock.now().subtract(Duration(days: days));
    final sessions = await EmergencySession.db.find(
      session,
      where: (t) => t.startedAt > since,
    );
    final seconds = [
      for (final s in sessions)
        if (s.actedAt != null) s.actedAt!.difference(s.startedAt).inSeconds,
    ]..sort();
    int? median;
    if (seconds.isNotEmpty) {
      final mid = seconds.length ~/ 2;
      median = seconds.length.isOdd
          ? seconds[mid]
          : ((seconds[mid - 1] + seconds[mid]) / 2).round();
    }
    final live = await Facility.db.find(
      session,
      where: (t) =>
          t.onboardingStage.equals(OnboardingStage.live) &
          t.suspendedAt.equals(null),
    );
    final fresh = live.isEmpty
        ? 0
        : await FacilityStatus.db.count(
            session,
            where: (t) =>
                t.facilityId.inSet(<int>{for (final f in live) f.id!}) &
                (t.updatedAt >
                    clock.now().subtract(const Duration(minutes: 60))),
          );
    return PlatformMetrics(
      periodDays: days,
      sessions: sessions.length,
      actedSessions: seconds.length,
      medianSecondsToAction: median,
      emptyResultRate: sessions.isEmpty
          ? 0
          : sessions.where((s) => s.emptyResult).length / sessions.length,
      liveFacilities: live.length,
      freshUnder60Share: live.isEmpty ? 0 : fresh / live.length,
    );
  }

  /// Facilities live for under 14 days. Quiet: no update for 48 hours.
  Future<List<NewHospitalRow>> newHospitals(Session session) async {
    final now = clock.now();
    final recent = await Facility.db.find(
      session,
      where: (t) =>
          t.onboardingStage.equals(OnboardingStage.live) &
          (t.liveAt > now.subtract(const Duration(days: 14))),
      orderBy: (t) => t.liveAt,
    );
    if (recent.isEmpty) return [];
    final ids = {for (final f in recent) f.id!};
    final logs = await StatusChangeLog.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids) & t.practice.equals(false),
    );
    final records = await OnboardingRecord.db.find(
      session,
      where: (t) => t.facilityId.inSet(ids),
    );
    final agentBy = {
      for (final r in records) r.facilityId: r.assignedAgentUserId,
    };
    final names = await _names(session, {for (final a in agentBy.values) ?a});
    return [
      for (final f in recent)
        () {
          final mine = logs.where((l) => l.facilityId == f.id).toList()
            ..sort((a, b) => b.at.compareTo(a.at));
          final last = mine.isEmpty ? null : mine.first.at;
          return NewHospitalRow(
            facility: OnboardingService.summary(f),
            liveAt: f.liveAt!,
            statusUpdates: mine.length,
            lastUpdateAt: last,
            quiet: isQuiet(lastUpdateAt: last, liveAt: f.liveAt!, now: now),
            agentName: names[agentBy[f.id]],
          );
        }(),
    ];
  }

  static bool isQuiet({
    required DateTime? lastUpdateAt,
    required DateTime liveAt,
    required DateTime now,
  }) {
    final since = lastUpdateAt ?? liveAt;
    return now.difference(since) > const Duration(hours: 48);
  }

  Future<void> _publish(Session session, Facility f) async {
    final status = await FacilityStatus.db.findFirstRow(
      session,
      where: (t) => t.facilityId.equals(f.id!),
    );
    await session.messages.postMessage(
      StatusService.channel,
      FacilityStatusChanged(
        facilityId: f.id!,
        status: status,
        flagged: f.flaggedAt != null,
      ),
    );
  }
}
