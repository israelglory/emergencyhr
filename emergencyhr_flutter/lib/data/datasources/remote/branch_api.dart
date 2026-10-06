import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class BranchDataProvider {
  final _apiService = ApiService(path: '/branches');

  Future<ApiResponse<List<Branch>>> getBranches({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _apiService.get('', queryParams: queryParams);
      final List<dynamic> list = res["data"] as List<dynamic>? ?? [];
      final branches = list
          .map((item) => Branch.fromJson(item as Map<String, dynamic>))
          .toList();

      return ApiResponse<List<Branch>>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Branches retrieved successfully"
        ..data = branches;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Branch?>> getBranchById(String id) async {
    try {
      final res = await _apiService.get('/$id');
      return ApiResponse<Branch?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Branch retrieved successfully"
        ..data = res["data"] != null
            ? Branch.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Branch?>> createBranch({
    required CreateBranchParam param,
  }) async {
    try {
      final res = await _apiService.post('', data: param.toJson());
      return ApiResponse<Branch?>.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Branch created successfully"
        ..data = res["data"] != null
            ? Branch.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Branch?>> updateBranch({
    required String id,
    required CreateBranchParam param,
  }) async {
    try {
      final res = await _apiService.put('/$id', data: param.toJson());
      return ApiResponse<Branch?>.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Branch updated successfully"
        ..data = res["data"] != null
            ? Branch.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<bool>> deleteBranch(String id) async {
    try {
      final res = await _apiService.delete('/$id');
      return ApiResponse<bool>.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Branch deleted successfully"
        ..data = true;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
