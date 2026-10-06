import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/validation.dart';
import '../../generated/protocol.dart';
import 'phone_idp.dart';

/// Phone sign-in. Who may call: anyone.
class PhoneAuthEndpoint extends Endpoint {
  /// Sends a 6-digit code to [phone] by SMS.
  Future<OtpRequestResult> requestCode(Session session, String phone) {
    return AuthServices.instance.phoneIdp.requestCode(
      session,
      Validate.phone(phone),
    );
  }

  /// Signs in with the code, creating the account on first use.
  Future<AuthSuccess> verifyCode(
    Session session,
    String phone,
    String code,
  ) {
    Validate.otpCode(code);
    return AuthServices.instance.phoneIdp.verifyCode(
      session,
      Validate.phone(phone),
      code,
    );
  }
}
