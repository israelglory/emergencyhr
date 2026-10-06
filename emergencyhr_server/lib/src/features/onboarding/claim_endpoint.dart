import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../generated/protocol.dart';
import '../facilities/facility_service.dart';
import 'claim_service.dart';

/// Self-serve claims. Who may call: any signed-in user.
class ClaimEndpoint extends Endpoint {
  static final _claims = ClaimService();
  static const _facilities = FacilityService();

  Future<OtpRequestResult> requestDeskPhoneCode(
    Session session,
    int facilityId,
  ) async {
    await AuthGuard.requireUser(session);
    return _claims.requestDeskPhoneCode(
      session,
      await _facilities.require(session, facilityId),
    );
  }

  Future<ClaimRequest> submit(
    Session session,
    int facilityId,
    String contactName,
    List<String> documentPaths, {
    String? deskPhoneCode,
  }) async {
    final user = await AuthGuard.requireUser(session);
    return _claims.submit(
      session,
      facility: await _facilities.require(session, facilityId),
      user: user,
      contactName: contactName,
      documentPaths: documentPaths,
      deskPhoneCode: deskPhoneCode,
    );
  }

  Future<List<ClaimRequest>> mine(Session session) async {
    final user = await AuthGuard.requireUser(session);
    return _claims.mine(session, user);
  }
}
