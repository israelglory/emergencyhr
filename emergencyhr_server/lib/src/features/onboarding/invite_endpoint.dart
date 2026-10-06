import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../facilities/facility_service.dart';
import 'invite_service.dart';

class InviteEndpoint extends Endpoint {
  static final _invites = InviteService();
  static const _facilities = FacilityService();

  /// Hospital admins may invite desk staff. Field agents and platform admins
  /// may invite both roles.
  Future<InviteCreated> create(
    Session session,
    int facilityId,
    UserRole role, {
    String? phone,
  }) async {
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    if (role == UserRole.hospitalAdmin &&
        !await AuthGuard.hasRole(session, user, {
          UserRole.fieldAgent,
          UserRole.platformAdmin,
        }, facilityId: facilityId)) {
      throw Errors.notAuthorized(
        'Only field agents can invite hospital admins.',
      );
    }
    final facility = await _facilities.require(session, facilityId);
    return _invites.create(
      session,
      facility: facility,
      role: role,
      createdBy: user,
      phone: Validate.optionalPhone(phone),
    );
  }

  /// Who may call: the facility's managers.
  Future<List<FacilityInvite>> list(Session session, int facilityId) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    return _invites.list(session, facilityId);
  }

  /// Who may call: the facility's managers.
  Future<FacilityInvite> revoke(Session session, int inviteId) async {
    final invite = await FacilityInvite.db.findById(session, inviteId);
    if (invite == null) throw Errors.notFound('Invite');
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: invite.facilityId,
    );
    return _invites.revoke(session, invite: invite, actor: user);
  }

  /// Shows what an invite is for before signing in. Who may call: anyone.
  Future<InvitePreview> preview(Session session, String code) {
    return _invites.preview(
      session,
      Validate.text(code, field: 'code', max: 100),
    );
  }

  /// Who may call: any signed-in user (the invite may be tied to a phone).
  Future<RoleAssignment> accept(Session session, String code) async {
    final user = await AuthGuard.requireUser(session);
    return _invites.accept(
      session,
      codeOrToken: Validate.text(code, field: 'code', max: 100),
      user: user,
    );
  }
}
