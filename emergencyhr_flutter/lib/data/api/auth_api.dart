import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Phone sign-in and the signed-in account.
class AuthApi {
  AuthApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;

  static const _tag = 'AuthApi';

  bool get isSignedIn => _client.auth.isAuthenticated;

  /// Fires when the user signs in or out (also on other tabs/devices).
  Listenable get authChanges => _client.auth.authInfoListenable;

  Future<ApiResponse<OtpRequestResult>> requestCode(String phone) =>
      ApiResponse.guard(_tag, () => _client.phoneAuth.requestCode(phone));

  /// Verifies the code and stores the session on the device.
  Future<ApiResponse<bool>> verifyCode(String phone, String code) =>
      ApiResponse.guard(_tag, () async {
        final auth = await _client.phoneAuth.verifyCode(phone, code);
        await _client.auth.updateSignedInUser(auth);
        return true;
      });

  Future<ApiResponse<CurrentUser>> me() =>
      ApiResponse.guard(_tag, () => _client.account.me());

  Future<ApiResponse<CurrentUser>> updateName(String name) =>
      ApiResponse.guard(_tag, () => _client.account.updateName(name));

  Future<void> signOut() => _client.auth.signOutDevice();
}
