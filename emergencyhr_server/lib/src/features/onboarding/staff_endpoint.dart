import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../generated/protocol.dart';
import 'staff_service.dart';

class StaffEndpoint extends Endpoint {
  static const _staff = StaffService();

  /// Who may call: the facility's managers.
  Future<List<StaffMember>> list(Session session, int facilityId) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    return _staff.list(session, facilityId);
  }

  /// Who may call: the facility's managers.
  Future<void> remove(
    Session session,
    int facilityId,
    int userId,
    UserRole role,
  ) async {
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    final elevated = await AuthGuard.hasRole(session, user, {
      UserRole.fieldAgent,
      UserRole.platformAdmin,
    }, facilityId: facilityId);
    await _staff.remove(
      session,
      facilityId: facilityId,
      userId: userId,
      role: role,
      actor: user,
      actorIsPlatformOrAgent: elevated,
    );
  }
}
