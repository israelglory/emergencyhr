import 'package:serverpod/serverpod.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../auth/otp_service.dart';
import '../onboarding/onboarding_service.dart';

/// Confirms a facility's desk phone by SMS code or a recorded test call.
class DeskPhoneService {
  DeskPhoneService({
    OtpService? otp,
    this.onboarding = const OnboardingService(),
  }) : otp = otp ?? OtpService();

  final OtpService otp;
  final OnboardingService onboarding;

  String _phone(Facility f) {
    final phone = f.deskPhone;
    if (phone == null) throw Errors.invalidState('Add the desk phone first.');
    return phone;
  }

  Future<OtpRequestResult> requestCode(Session session, Facility facility) =>
      otp.request(
        session,
        phone: _phone(facility),
        purpose: OtpPurpose.deskPhone,
      );

  Future<Facility> confirmWithCode(
    Session session, {
    required Facility facility,
    required String code,
    required AppUser actor,
  }) async {
    Validate.otpCode(code);
    await otp.verify(
      session,
      phone: _phone(facility),
      purpose: OtpPurpose.deskPhone,
      code: code,
    );
    return _confirm(session, facility, actor, 'otp');
  }

  Future<Facility> recordTestCall(
    Session session, {
    required Facility facility,
    required AppUser actor,
    String? note,
  }) {
    _phone(facility);
    return _confirm(session, facility, actor, 'test call', note: note);
  }

  Future<Facility> _confirm(
    Session session,
    Facility facility,
    AppUser actor,
    String method, {
    String? note,
  }) async {
    final updated = await session.db.transaction((tx) async {
      await AuditLog.record(
        session,
        actorUserId: actor.id!,
        action: 'deskPhone:confirm:$method',
        targetType: 'facility',
        targetId: facility.id!,
        reason: note,
        transaction: tx,
      );
      return Facility.db.updateRow(
        session,
        facility.copyWith(deskPhoneConfirmedAt: clock.now()),
        transaction: tx,
      );
    });
    await onboarding.evaluate(session, facility.id!);
    return updated;
  }
}
