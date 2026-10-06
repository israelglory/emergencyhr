import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class UserDataProvider {
  final _apiService = ApiService(path: '/users');

  Future<ApiResponse<List<AppUser>>> getUsers({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _apiService.get('', queryParams: queryParams);
      final List<dynamic> list = res["data"] as List<dynamic>? ?? [];
      final users = list
          .map((item) => AppUser.fromJson(item as Map<String, dynamic>))
          .toList();

      return ApiResponse<List<AppUser>>.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Users retrieved successfully"
        ..data = users;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<AppUser?>> createUser({
    required CreateUserParam param,
  }) async {
    try {
      final res = await _apiService.post('', data: param.toJson());
      return ApiResponse<AppUser?>.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "User created successfully"
        ..data = res["data"] != null
            ? AppUser.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<AppUser?>> updateUserStatus({
    required String id,
    required bool isActive,
  }) async {
    try {
      final res = await _apiService.patch(
        '/$id/status',
        queryParams: {'isActive': isActive},
      );
      return ApiResponse<AppUser?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "User status updated successfully"
        ..data = res["data"] != null
            ? AppUser.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<UserBankDetails?>> updateBankDetails({
    required UserBankDetails bankDetails,
  }) async {
    try {
      final res = await _apiService.put(
        '/bank-details',
        data: bankDetails.toJson(),
      );
      return ApiResponse<UserBankDetails?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Bank details updated successfully"
        ..data = res["data"] != null
            ? UserBankDetails.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
