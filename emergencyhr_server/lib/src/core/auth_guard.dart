import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../features/auth/account_service.dart';
import '../generated/protocol.dart';
import 'errors.dart';

/// The single authorization API used by every endpoint. Deny by default: a
/// caller passes only if they hold one of the roles the endpoint names.
abstract final class AuthGuard {
  /// Hospital staff of a facility.
  static const staff = {UserRole.hospitalAdmin, UserRole.deskStaff};

  /// People who manage a facility's listing and onboarding.
  static const managers = {
    UserRole.hospitalAdmin,
    UserRole.fieldAgent,
    UserRole.platformAdmin,
  };

  static const staffAndManagers = {
    UserRole.hospitalAdmin,
    UserRole.deskStaff,
    UserRole.fieldAgent,
    UserRole.platformAdmin,
  };

  /// The signed-in user, or null for guests. Suspended accounts count as
  /// guests so they lose every signed-in ability.
  static Future<AppUser?> currentUser(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;
    // Normally created at registration; created here if that was missed.
    final user = await const AccountService().ensureFor(
      session,
      authUserId: authUserId,
    );
    if (user.suspendedAt != null) return null;
    return user;
  }

  /// Any signed-in, non-suspended user.
  static Future<AppUser> requireUser(Session session) async {
    if (session.authenticated == null) throw Errors.notAuthenticated();
    final user = await currentUser(session);
    if (user == null) {
      throw Errors.notAuthorized('This account is suspended or not set up.');
    }
    return user;
  }

  static Future<List<RoleAssignment>> rolesOf(Session session, int userId) {
    return RoleAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  /// Requires one of [roles]. When [facilityId] is given, facility-scoped
  /// roles (hospital admin, desk staff) must be held for that facility, and a
  /// field agent must be assigned to it (directly or through its area).
  /// Platform admins pass only when [roles] includes [UserRole.platformAdmin].
  static Future<AppUser> requireRole(
    Session session,
    Set<UserRole> roles, {
    int? facilityId,
  }) async {
    final user = await requireUser(session);
    if (await hasRole(session, user, roles, facilityId: facilityId)) {
      return user;
    }
    throw Errors.notAuthorized();
  }

  static Future<bool> hasRole(
    Session session,
    AppUser user,
    Set<UserRole> roles, {
    int? facilityId,
  }) async {
    final assignments = await rolesOf(session, user.id!);
    for (final assignment in assignments) {
      if (!roles.contains(assignment.role)) continue;
      switch (assignment.role) {
        case UserRole.platformAdmin:
        case UserRole.public:
        case UserRole.doctor:
          return true;
        case UserRole.hospitalAdmin:
        case UserRole.deskStaff:
          if (facilityId == null || assignment.facilityId == facilityId) {
            return true;
          }
        case UserRole.fieldAgent:
          if (facilityId == null ||
              await agentCovers(session, user.id!, facilityId)) {
            return true;
          }
      }
    }
    return false;
  }

  /// True if the field agent is assigned to the facility or to its area.
  static Future<bool> agentCovers(
    Session session,
    int agentUserId,
    int facilityId,
  ) async {
    final record = await OnboardingRecord.db.findFirstRow(
      session,
      where: (t) => t.facilityId.equals(facilityId),
    );
    if (record?.assignedAgentUserId == agentUserId) return true;
    final facility = await Facility.db.findById(session, facilityId);
    if (facility == null) return false;
    final area = await FieldAgentArea.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(agentUserId) & t.area.equals(facility.area),
    );
    return area != null;
  }
}
