import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../generated/protocol.dart';
import '../facilities/facility_service.dart';
import 'status_service.dart';

class StatusEndpoint extends Endpoint {
  static const _status = StatusService();
  static const _facilities = FacilityService();

  /// Who may call: the facility's hospital admin and desk staff only.
  Future<FacilityStatus> update(
    Session session,
    int facilityId,
    StatusInput input,
  ) async {
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.staff,
      facilityId: facilityId,
    );
    final facility = await _facilities.require(session, facilityId);
    return _status.update(
      session,
      facility: facility,
      user: user,
      input: input,
    );
  }

  /// "Still accurate". Who may call: the facility's staff.
  Future<FacilityStatus> confirm(Session session, int facilityId) async {
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.staff,
      facilityId: facilityId,
    );
    final facility = await _facilities.require(session, facilityId);
    return _status.confirm(session, facility: facility, user: user);
  }

  /// Who may call: the facility's staff.
  Future<FacilityStatus?> current(Session session, int facilityId) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.staffAndManagers,
      facilityId: facilityId,
    );
    return _status.current(session, facilityId);
  }

  /// Training mode. Who may call: the facility's staff and assigned agent.
  Future<void> practice(
    Session session,
    int facilityId,
    StatusInput input,
  ) async {
    final user = await AuthGuard.requireRole(session, {
      ...AuthGuard.staff,
      UserRole.fieldAgent,
    }, facilityId: facilityId);
    final facility = await _facilities.require(session, facilityId);
    await _status.practice(
      session,
      facility: facility,
      user: user,
      input: input,
    );
  }

  /// Who may call: the facility's staff, managers.
  Future<List<AuditEntry>> auditLog(
    Session session,
    int facilityId, {
    int limit = 50,
    int offset = 0,
  }) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.staffAndManagers,
      facilityId: facilityId,
    );
    return _status.auditLog(
      session,
      facilityId: facilityId,
      limit: limit,
      offset: offset,
    );
  }
}
