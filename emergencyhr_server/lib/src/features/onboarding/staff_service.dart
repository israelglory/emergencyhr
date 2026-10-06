import 'package:serverpod/serverpod.dart';

import '../../core/audit_log.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import 'onboarding_service.dart';

/// Hospital admins and desk staff of a facility.
class StaffService {
  const StaffService({this.onboarding = const OnboardingService()});

  final OnboardingService onboarding;

  Future<List<StaffMember>> list(Session session, int facilityId) async {
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) =>
          t.facilityId.equals(facilityId) &
          t.role.inSet(<UserRole>{UserRole.hospitalAdmin, UserRole.deskStaff}),
      orderBy: (t) => t.createdAt,
    );
    final users = roles.isEmpty
        ? <AppUser>[]
        : await AppUser.db.find(
            session,
            where: (t) => t.id.inSet(<int>{for (final r in roles) r.userId}),
          );
    final byId = {for (final u in users) u.id!: u};
    return [
      for (final r in roles)
        if (byId[r.userId] != null)
          StaffMember(
            userId: r.userId,
            name: byId[r.userId]!.name,
            phone: byId[r.userId]!.phone,
            role: r.role,
            since: r.createdAt,
          ),
    ];
  }

  /// Hospital admins can remove staff but not the last hospital admin.
  Future<void> remove(
    Session session, {
    required int facilityId,
    required int userId,
    required UserRole role,
    required AppUser actor,
    required bool actorIsPlatformOrAgent,
  }) async {
    final assignment = await RoleAssignment.db.findFirstRow(
      session,
      where: (t) =>
          t.facilityId.equals(facilityId) &
          t.userId.equals(userId) &
          t.role.equals(role),
    );
    if (assignment == null) throw Errors.notFound('Staff member');
    if (role == UserRole.hospitalAdmin && !actorIsPlatformOrAgent) {
      final admins = await RoleAssignment.db.count(
        session,
        where: (t) =>
            t.facilityId.equals(facilityId) &
            t.role.equals(UserRole.hospitalAdmin),
      );
      if (admins <= 1) {
        throw Errors.invalidState(
          'A facility needs at least one hospital admin.',
        );
      }
    }
    await session.db.transaction((tx) async {
      await RoleAssignment.db.deleteRow(session, assignment, transaction: tx);
      await AuditLog.record(
        session,
        actorUserId: actor.id!,
        action: 'staff:remove:${role.name}',
        targetType: 'facility',
        targetId: facilityId,
        reason: 'user $userId',
        transaction: tx,
      );
    });
    await onboarding.evaluate(session, facilityId);
  }
}
