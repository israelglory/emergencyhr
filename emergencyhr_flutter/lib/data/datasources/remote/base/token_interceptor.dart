import 'package:emergencyhr_flutter/core/states/app_state.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:dio/dio.dart';

import '../../../../core/cores.dart';

import 'dart:async';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static Completer<bool>? _refreshCompleter;
  static bool _logoutInProgress = false;

  static const _retriedKey = '__planetal_retried';

  bool _isAuthRequest(RequestOptions options) {
    final baseUrl = options.baseUrl.toLowerCase();
    final path = options.path.toLowerCase();

    // AuthApi uses ApiService(path: '/auth'), so baseUrl contains '/auth'
    if (baseUrl.contains('/auth')) return true;

    // Defensive: treat explicit refresh path as auth.
    if (path.contains('refresh')) return true;

    return false;
  }

  void _applyLatestAccessToken(RequestOptions options) {
    final token = appGlobals.token;
    if (token == null || token.isEmpty) {
      options.headers.remove('Authorization');
      return;
    }
    options.headers['Authorization'] = 'Bearer $token';
  }

  Future<bool> _refreshTokenOnce() async {
    // No refresh token available => can't refresh.
    final refreshToken = authLocalStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    // If a refresh is already in progress, await it.
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<bool>();
    try {
      final res = await authRepo.refreshLoginAPI();
      final ok = res.success == true && res.data?.accessToken != null;
      _refreshCompleter!.complete(ok);
      return ok;
    } catch (_) {
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _forceLogoutOnce() async {
    if (_logoutInProgress) return;
    _logoutInProgress = true;
    try {
      appGlobals.token = null;
      appGlobals.refreshToken = null;
      appGlobals.user = null;

      await LocalStorageService.clear();
      appLocalStorage.saveAppState(AppState.unauthenticated);

      /// navigationService.pushAndRemoveUntil(SignInView());
    } finally {
      _logoutInProgress = false;
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _applyLatestAccessToken(options);
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    if (status != 401) {
      return handler.next(err);
    }

    // Never attempt refresh for auth endpoints.
    // (Example: login can legitimately return 401 for bad credentials.)
    if (_isAuthRequest(err.requestOptions)) {
      return handler.next(err);
    }

    // Avoid infinite refresh loops.
    final alreadyRetried = err.requestOptions.extra[_retriedKey] == true;
    if (alreadyRetried) {
      return handler.next(err);
    }

    final refreshed = await _refreshTokenOnce();
    if (!refreshed) {
      await _forceLogoutOnce();
      return handler.next(err);
    }

    // Retry original request once with the new token.
    try {
      final RequestOptions requestOptions = err.requestOptions;
      requestOptions.extra[_retriedKey] = true;
      _applyLatestAccessToken(requestOptions);

      final response = await _dio.fetch<dynamic>(requestOptions);
      return handler.resolve(response);
    } catch (e) {
      // If retry fails, propagate original error.
      return handler.next(err);
    }
  }
}
