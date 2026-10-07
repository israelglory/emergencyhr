import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../generated/protocol.dart';
import '../admin/admin_service.dart';
import '../facilities/logic/opening_hours_rules.dart';
import 'notifier.dart';

/// Stale-status reminders and early-health follow-ups. Safe to run any
/// number of times: each message kind is sent at most once per window.
class ReminderService {
  const ReminderService();

  static const staleAfter = Duration(minutes: 60);
  static const staleWindow = Duration(minutes: 60);
  static const quietWindow = Duration(hours: 24);

  /// Pure: should this facility get a stale reminder now?
  static bool needsStaleReminder({
    required FacilityStatus? status,
    required OpeningHours? hours,
    required DateTime now,
  }) {
    if (!OpeningHoursRules.isOpen(hours, now)) return false;
    if (status == null) return true;
    return now.difference(status.updatedAt) > staleAfter;
  }

  Future<int> sendStaleReminders(Session session) async {
    final now = clock.now();
    final live = await Facility.db.find(
      session,
      where: (t) =>
          t.onboardingStage.equals(OnboardingStage.live) &
          t.verificationStatus.equals(VerificationStatus.verified) &
          t.suspendedAt.equals(null),
    );
    if (live.isEmpty) return 0;
    final statuses = await FacilityStatus.db.find(
      session,
      where: (t) => t.facilityId.inSet(<int>{for (final f in live) f.id!}),
    );
    final statusBy = {for (final s in statuses) s.facilityId: s};
    var sent = 0;
    for (final f in live) {
      final status = statusBy[f.id];
      if (!needsStaleReminder(
        status: status,
        hours: f.openingHours,
        now: now,
      )) {
        continue;
      }
      if (await Notifier.sentRecently(
        session,
        facilityId: f.id!,
        kind: 'stale_reminder',
        window: staleWindow,
      )) {
        continue;
      }
      final desk = await _staffPhones(session, f.id!, {UserRole.deskStaff});
      final phones = desk.isNotEmpty
          ? desk
          : await _staffPhones(session, f.id!, {UserRole.hospitalAdmin});
      final age = status == null
          ? 'has not been set'
          : 'was last confirmed ${now.difference(status.updatedAt).inMinutes} min ago';
      for (final phone in phones) {
        await Notifier.whatsAppOrSms(
          session,
          to: phone,
          kind: 'stale_reminder',
          facilityId: f.id,
          message:
              'Emergencyhr: the status for ${f.name} $age. Open the app and '
              'tap Still accurate, or reply C to confirm, A for accepting, '
              'P for paused.',
        );
      }
      if (phones.isNotEmpty) sent++;
    }
    return sent;
  }

  /// Live under 14 days and quiet for 48 hours: tell the assigned agent.
  Future<int> sendQuietNewcomerAlerts(Session session) async {
    final rows = await const AdminService().newHospitals(session);
    var sent = 0;
    for (final row in rows.where((r) => r.quiet)) {
      if (await Notifier.sentRecently(
        session,
        facilityId: row.facility.id,
        kind: 'quiet_newcomer',
        window: quietWindow,
      )) {
        continue;
      }
      final record = await OnboardingRecord.db.findFirstRow(
        session,
        where: (t) => t.facilityId.equals(row.facility.id),
      );
      final agentId = record?.assignedAgentUserId;
      if (agentId == null) continue;
      final agent = await AppUser.db.findById(session, agentId);
      if (agent?.phone == null) continue;
      await Notifier.sms(
        session,
        to: agent!.phone!,
        kind: 'quiet_newcomer',
        facilityId: row.facility.id,
        message:
            'Emergencyhr: ${row.facility.name} went live recently but has not '
            'updated its status for 48 hours. Please follow up with the desk.',
      );
      sent++;
    }
    return sent;
  }

  Future<List<String>> _staffPhones(
    Session session,
    int facilityId,
    Set<UserRole> roles,
  ) async {
    final assignments = await RoleAssignment.db.find(
      session,
      where: (t) => t.facilityId.equals(facilityId) & t.role.inSet(roles),
    );
    if (assignments.isEmpty) return [];
    final users = await AppUser.db.find(
      session,
      where: (t) =>
          t.id.inSet(<int>{for (final a in assignments) a.userId}) &
          t.suspendedAt.equals(null),
    );
    return [for (final u in users) ?u.phone];
  }
}
