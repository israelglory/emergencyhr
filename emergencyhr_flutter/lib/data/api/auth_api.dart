import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Email sign-in, registration, password reset and the signed-in account.
class AuthApi {
  AuthApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;

  static const _tag = 'AuthApi';

  bool get isSignedIn => _client.auth.isAuthenticated;

  /// Fires when the user signs in or out (also on other tabs/devices).
  Listenable get authChanges => _client.auth.authInfoListenable;

  /// Signs in and stores the session on the device.
  Future<ApiResponse<bool>> signIn(String email, String password) =>
      ApiResponse.guard(_tag, () async {
        final auth = await _client.emailIdp.login(
          email: email.trim().toLowerCase(),
          password: password,
        );
        await _client.auth.updateSignedInUser(auth);
        return true;
      });

  /// Emails a verification code. Returns the request id for the next step.
  Future<ApiResponse<UuidValue>> startRegistration(String email) =>
      ApiResponse.guard(
        _tag,
        () => _client.emailIdp.startRegistration(
          email: email.trim().toLowerCase(),
        ),
      );

  /// Returns a registration token when the code is right.
  Future<ApiResponse<String>> verifyRegistrationCode(
    UuidValue requestId,
    String code,
  ) => ApiResponse.guard(
    _tag,
    () => _client.emailIdp.verifyRegistrationCode(
      accountRequestId: requestId,
      verificationCode: code.trim(),
    ),
  );

  /// Creates the account with a password and signs in.
  Future<ApiResponse<bool>> finishRegistration(String token, String password) =>
      ApiResponse.guard(_tag, () async {
        final auth = await _client.emailIdp.finishRegistration(
          registrationToken: token,
          password: password,
        );
        await _client.auth.updateSignedInUser(auth);
        return true;
      });

  Future<ApiResponse<UuidValue>> startPasswordReset(String email) =>
      ApiResponse.guard(
        _tag,
        () => _client.emailIdp.startPasswordReset(
          email: email.trim().toLowerCase(),
        ),
      );

  Future<ApiResponse<String>> verifyPasswordResetCode(
    UuidValue requestId,
    String code,
  ) => ApiResponse.guard(
    _tag,
    () => _client.emailIdp.verifyPasswordResetCode(
      passwordResetRequestId: requestId,
      verificationCode: code.trim(),
    ),
  );

  Future<ApiResponse<bool>> finishPasswordReset(
    String token,
    String newPassword,
  ) => ApiResponse.guardVoid(
    _tag,
    () => _client.emailIdp.finishPasswordReset(
      finishPasswordResetToken: token,
      newPassword: newPassword,
    ),
  );

  Future<ApiResponse<CurrentUser>> me() =>
      ApiResponse.guard(_tag, () => _client.account.me());

  Future<ApiResponse<CurrentUser>> updateName(String name) =>
      ApiResponse.guard(_tag, () => _client.account.updateName(name));

  /// Adds, changes or (with null) removes the optional phone number.
  Future<ApiResponse<CurrentUser>> updatePhone(String? phone) =>
      ApiResponse.guard(_tag, () => _client.account.updatePhone(phone));

  Future<void> signOut() => _client.auth.signOutDevice();
}
