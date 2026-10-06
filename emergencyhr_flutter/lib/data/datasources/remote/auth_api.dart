import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class AuthenticationDataProvider {
  final _apiService = ApiService(path: '/auth');

  Future<ApiResponse<LoginResponse?>> loginAPI({
    required LoginParam param,
  }) async {
    try {
      final res = await _apiService.post('/login', data: param.toJson());
      return ApiResponse.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Success"
        ..data = res["data"] != null
            ? LoginResponse.fromJson(res["data"])
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<LoginResponse?>> register({
    required SignUpParam param,
  }) async {
    try {
      final res = await _apiService.post('/signup', data: param.toJson());
      return ApiResponse.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Success"
        ..data = res["data"] != null
            ? LoginResponse.fromJson(res["data"])
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<User?>> getProfile() async {
    try {
      final res = await _apiService.get('/me');
      return ApiResponse.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "User profile retrieved successfully"
        ..data = res["data"] != null ? User.fromJson(res["data"]) : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<LoginResponse?>> refreshLoginAPI({
    required String refreshToken,
  }) async {
    try {
      final res = await _apiService.post(
        '/refresh',
        data: {"refresh_token": refreshToken},
      );
      final dynamic payload = (res is Map && res['data'] is Map)
          ? res['data'] as Map<String, dynamic>
          : (res as Map<String, dynamic>);

      return ApiResponse.fromJson(res)
        ..success = true
        ..message = "Success"
        ..data = LoginResponse.fromJson(payload);
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      // Prevent unexpected parsing/shape issues from crashing the refresh flow.
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
