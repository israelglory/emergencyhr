import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../facilities/desk_phone_service.dart';
import '../facilities/facility_service.dart';
import 'onboarding_service.dart';

class OnboardingEndpoint extends Endpoint {
  static const _onboarding = OnboardingService();
  static const _facilities = FacilityService();
  static final _deskPhone = DeskPhoneService();

  static const _agents = {UserRole.fieldAgent, UserRole.platformAdmin};

  /// The agent's assigned facilities. Who may call: field agents.
  Future<List<AgentFacility>> myFacilities(
    Session session, {
    double? lat,
    double? lng,
  }) async {
    final user = await AuthGuard.requireRole(session, {UserRole.fieldAgent});
    if (lat != null && lng != null) Validate.coordinates(lat, lng);
    return _onboarding.agentFacilities(
      session,
      agent: user,
      lat: lat,
      lng: lng,
    );
  }

  /// Who may call: the facility's managers.
  Future<GoLiveChecklist> checklist(Session session, int facilityId) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    return _onboarding.checklist(
      session,
      await _facilities.require(session, facilityId),
    );
  }

  /// Who may call: the assigned field agent, platform admins.
  Future<Facility> setStage(
    Session session,
    int facilityId,
    OnboardingStage stage, {
    String? note,
  }) async {
    final user = await AuthGuard.requireRole(
      session,
      _agents,
      facilityId: facilityId,
    );
    return _onboarding.setStage(
      session,
      facility: await _facilities.require(session, facilityId),
      to: stage,
      actor: user,
      isPlatformAdmin: await AuthGuard.hasRole(session, user, {
        UserRole.platformAdmin,
      }),
      note: Validate.optionalText(note, field: 'note', max: 500),
    );
  }

  /// Who may call: the assigned field agent, platform admins.
  Future<OnboardingRecord> updateRecord(
    Session session,
    int facilityId, {
    String? notes,
    DateTime? nextActionAt,
  }) async {
    final user = await AuthGuard.requireRole(
      session,
      _agents,
      facilityId: facilityId,
    );
    return _onboarding.updateRecord(
      session,
      facility: await _facilities.require(session, facilityId),
      actor: user,
      notes: Validate.optionalText(notes, field: 'notes', max: 2000),
      nextActionAt: nextActionAt,
    );
  }

  /// Who may call: the assigned field agent, the facility's hospital admin.
  Future<Facility> submitForVerification(
    Session session,
    int facilityId, {
    String? notes,
  }) async {
    final user = await AuthGuard.requireRole(session, {
      UserRole.fieldAgent,
      UserRole.hospitalAdmin,
    }, facilityId: facilityId);
    return _onboarding.submitForVerification(
      session,
      facility: await _facilities.require(session, facilityId),
      actor: user,
      notes: Validate.optionalText(notes, field: 'notes', max: 2000),
    );
  }

  /// Sends a code to the desk phone. Who may call: the facility's managers.
  Future<OtpRequestResult> requestDeskPhoneCode(
    Session session,
    int facilityId,
  ) async {
    await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    return _deskPhone.requestCode(
      session,
      await _facilities.require(session, facilityId),
    );
  }

  /// Who may call: the facility's managers.
  Future<Facility> confirmDeskPhone(
    Session session,
    int facilityId,
    String code,
  ) async {
    final user = await AuthGuard.requireRole(
      session,
      AuthGuard.managers,
      facilityId: facilityId,
    );
    return _deskPhone.confirmWithCode(
      session,
      facility: await _facilities.require(session, facilityId),
      code: code,
      actor: user,
    );
  }

  /// The agent called the desk and someone answered. Who may call: the
  /// assigned field agent.
  Future<Facility> recordTestCall(
    Session session,
    int facilityId, {
    String? note,
  }) async {
    final user = await AuthGuard.requireRole(session, {
      UserRole.fieldAgent,
    }, facilityId: facilityId);
    return _deskPhone.recordTestCall(
      session,
      facility: await _facilities.require(session, facilityId),
      actor: user,
      note: Validate.optionalText(note, field: 'note', max: 500),
    );
  }
}
