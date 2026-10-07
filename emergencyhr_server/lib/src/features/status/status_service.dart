import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../auth/account_service.dart';
import '../onboarding/onboarding_service.dart';

/// Live availability set by hospital staff. Every change is logged.
class StatusService {
  const StatusService({this.onboarding = const OnboardingService()});

  final OnboardingService onboarding;

  /// Channel for live status changes, consumed by the results stream.
  static const channel = 'facility-status';

  StatusInput validate(StatusInput input) => input.copyWith(
    erBedsFree: Validate.count(input.erBedsFree, field: 'erBedsFree', max: 500),
    icuBedsFree: Validate.count(
      input.icuBedsFree,
      field: 'icuBedsFree',
      max: 200,
    ),
  );

  Future<FacilityStatus?> current(Session session, int facilityId) {
    return FacilityStatus.db.findFirstRow(
      session,
      where: (t) => t.facilityId.equals(facilityId),
    );
  }

  Future<FacilityStatus> update(
    Session session, {
    required Facility facility,
    required AppUser user,
    required StatusInput input,
  }) async {
    _requireNotSuspended(facility);
    final data = validate(input);
    final now = clock.now();
    final saved = await session.db.transaction((tx) async {
      final old = await FacilityStatus.db.findFirstRow(
        session,
        where: (t) => t.facilityId.equals(facility.id!),
        transaction: tx,
      );
      final next = FacilityStatus(
        id: old?.id,
        facilityId: facility.id!,
        accepting: data.accepting,
        erBedsFree: data.erBedsFree,
        icuBedsFree: data.icuBedsFree,
        doctorOnDuty: data.doctorOnDuty,
        depositRequired: data.depositRequired,
        updatedByUserId: user.id,
        updatedAt: now,
      );
      final row = old == null
          ? await FacilityStatus.db.insertRow(session, next, transaction: tx)
          : await FacilityStatus.db.updateRow(session, next, transaction: tx);
      await StatusChangeLog.db.insertRow(
        session,
        StatusChangeLog(
          facilityId: facility.id!,
          userId: user.id,
          oldValue: old == null ? null : jsonEncode(_snapshot(old)),
          newValue: jsonEncode(_snapshot(row)),
          at: now,
        ),
        transaction: tx,
      );
      return row;
    });
    await _publish(session, facility, saved);
    if (_beforeLive(facility)) await onboarding.evaluate(session, facility.id!);
    return saved;
  }

  /// "Still accurate": refreshes the timestamp without changing values.
  Future<FacilityStatus> confirm(
    Session session, {
    required Facility facility,
    required AppUser user,
  }) async {
    _requireNotSuspended(facility);
    final existing = await current(session, facility.id!);
    if (existing == null) {
      throw Errors.invalidState('Submit a full status update first.');
    }
    final now = clock.now();
    final saved = await session.db.transaction((tx) async {
      final row = await FacilityStatus.db.updateRow(
        session,
        existing.copyWith(updatedAt: now, updatedByUserId: user.id),
        transaction: tx,
      );
      await StatusChangeLog.db.insertRow(
        session,
        StatusChangeLog(
          facilityId: facility.id!,
          userId: user.id,
          oldValue: jsonEncode(_snapshot(existing)),
          newValue: jsonEncode({..._snapshot(row), 'confirmed': true}),
          at: now,
        ),
        transaction: tx,
      );
      return row;
    });
    await _publish(session, facility, saved);
    return saved;
  }

  /// Training mode. Logged as practice, never shown to the public.
  Future<void> practice(
    Session session, {
    required Facility facility,
    required AppUser user,
    required StatusInput input,
  }) async {
    final data = validate(input);
    await StatusChangeLog.db.insertRow(
      session,
      StatusChangeLog(
        facilityId: facility.id!,
        userId: user.id,
        newValue: jsonEncode(_snapshotInput(data)),
        practice: true,
        at: clock.now(),
      ),
    );
    await onboarding.markTrainingCompleted(session, facility);
    await onboarding.evaluate(session, facility.id!);
  }

  Future<List<AuditEntry>> auditLog(
    Session session, {
    required int facilityId,
    required int limit,
    required int offset,
  }) async {
    final page = Validate.page(limit, offset);
    final rows = await StatusChangeLog.db.find(
      session,
      where: (t) => t.facilityId.equals(facilityId),
      orderBy: (t) => t.at.desc(),
      limit: page.limit,
      offset: page.offset,
    );
    final userIds = {for (final r in rows) ?r.userId};
    final users = userIds.isEmpty
        ? <AppUser>[]
        : await AppUser.db.find(session, where: (t) => t.id.inSet(userIds));
    final names = {
      for (final u in users) u.id!: AccountService.displayName(u),
    };
    return [
      for (final r in rows)
        AuditEntry(
          at: r.at,
          userName: r.userId == null ? 'System' : names[r.userId] ?? 'Unknown',
          summary: describe(r.oldValue, r.newValue),
          practice: r.practice,
        ),
    ];
  }

  /// Plain-language summary of a change, e.g. "Paused; ER beds 3 to 0".
  static String describe(String? oldJson, String newJson) {
    final next = jsonDecode(newJson) as Map<String, dynamic>;
    if (next['confirmed'] == true) return 'Confirmed still accurate';
    final prev = oldJson == null
        ? null
        : jsonDecode(oldJson) as Map<String, dynamic>;
    String yesNo(Object? v) => v == true ? 'yes' : 'no';
    final parts = <String>[];
    void diff(String key, String label, String Function(Object?) fmt) {
      if (prev == null || prev[key] != next[key]) {
        parts.add(
          prev == null
              ? '$label ${fmt(next[key])}'
              : '$label ${fmt(prev[key])} to ${fmt(next[key])}',
        );
      }
    }

    if (prev == null || prev['accepting'] != next['accepting']) {
      parts.add(next['accepting'] == true ? 'Accepting' : 'Paused');
    }
    diff('erBedsFree', 'ER beds', (v) => '$v');
    diff('icuBedsFree', 'ICU beds', (v) => '$v');
    diff('doctorOnDuty', 'Doctor on duty', yesNo);
    diff('depositRequired', 'Deposit required', yesNo);
    return parts.isEmpty ? 'No changes' : parts.join('; ');
  }

  /// The first real status is a checklist item, so re-check until live.
  static bool _beforeLive(Facility f) =>
      f.onboardingStage != OnboardingStage.live;

  Future<void> _publish(
    Session session,
    Facility facility,
    FacilityStatus status,
  ) async {
    await session.messages.postMessage(
      channel,
      FacilityStatusChanged(
        facilityId: facility.id!,
        status: status,
        flagged: facility.flaggedAt != null,
      ),
    );
  }

  void _requireNotSuspended(Facility f) {
    if (f.suspendedAt != null) {
      throw Errors.invalidState('This facility is suspended.');
    }
  }

  static Map<String, Object?> _snapshot(FacilityStatus s) => {
    'accepting': s.accepting,
    'erBedsFree': s.erBedsFree,
    'icuBedsFree': s.icuBedsFree,
    'doctorOnDuty': s.doctorOnDuty,
    'depositRequired': s.depositRequired,
  };

  static Map<String, Object?> _snapshotInput(StatusInput s) => {
    'accepting': s.accepting,
    'erBedsFree': s.erBedsFree,
    'icuBedsFree': s.icuBedsFree,
    'doctorOnDuty': s.doctorOnDuty,
    'depositRequired': s.depositRequired,
  };
}
