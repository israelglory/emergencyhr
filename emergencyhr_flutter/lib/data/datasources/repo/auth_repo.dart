import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/auth_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class AuthRepo {
  final _authapi = AuthenticationDataProvider();

  Future<ApiResponse<LoginResponse?>> login({required LoginParam param}) async {
    final response = await _authapi.loginAPI(param: param);
    if (response.success && response.data != null) {
      saveTokens(
        accessToken: response.data?.accessToken,
        refreshToken: response.data?.refreshToken,
      );
      // Fetch and cache user profile after successful login
      await getCurrentUser();
    }
    return response;
  }

  Future<ApiResponse<LoginResponse?>> register({
    required SignUpParam param,
  }) async {
    final response = await _authapi.register(param: param);
    if (response.success && response.data != null) {
      saveTokens(
        accessToken: response.data?.accessToken,
        refreshToken: response.data?.refreshToken,
      );
      // Fetch and cache user profile after successful registration
      await getCurrentUser();
    }
    return response;
  }

  Future<ApiResponse<User?>> getCurrentUser() async {
    final response = await _authapi.getProfile();
    if (response.success && response.data != null) {
      appLocalStorage.saveUser(response.data);
      appGlobals.user = response.data;
    }
    return response;
  }

  void saveTokens({String? accessToken, String? refreshToken}) {
    if (accessToken != null) {
      authLocalStorage.saveToken(accessToken);
      appGlobals.token = accessToken;
    }
    if (refreshToken != null) {
      authLocalStorage.saveRefreshToken(refreshToken);
      appGlobals.refreshToken = refreshToken;
    }
  }

  Future<ApiResponse<LoginResponse?>> refreshLoginAPI() async {
    String? refreshToken = authLocalStorage.getRefreshToken();
    if (refreshToken == null) return ApiResponse();
    final response = await _authapi.refreshLoginAPI(refreshToken: refreshToken);
    if (response.success && response.data != null) {
      saveTokens(
        accessToken: response.data?.accessToken,
        refreshToken: response.data?.refreshToken,
      );
      // Fetch and cache user profile after successful login
      await getCurrentUser();
    }
    return response;
  }

  void logOut() {
    authLocalStorage.clearTokens();
    appLocalStorage.saveUser(null);
    appGlobals.clearAuth();
  }

  bool get isAuthenticated =>
      appGlobals.token != null && appGlobals.token!.isNotEmpty;

  String? get token => authLocalStorage.getToken();

  String? get refreshToken => authLocalStorage.getRefreshToken();

  User? get currentUser => appGlobals.user ?? appLocalStorage.getUser();
}
