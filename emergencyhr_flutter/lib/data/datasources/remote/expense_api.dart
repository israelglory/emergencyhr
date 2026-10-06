import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/params/expense.dart';

class ExpenseDataProvider {
  final _apiService = ApiService(path: '/expenses');

  Future<ApiResponse<PaginatedExpenses?>> getExpenses({
    String? branchId,
    String? search,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'size': size,
      };

      if (branchId != null && branchId.isNotEmpty) {
        queryParams['branchId'] = branchId;
      }
      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }
      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != 'all') {
        queryParams['category'] = category;
      }
      if (startDate != null) {
        queryParams['startDate'] = startDate.toUtc().toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toUtc().toIso8601String();
      }

      final res = await _apiService.get(
        '',
        queryParams: queryParams,
      );

      PaginatedExpenses? paginated;
      if (res["data"] is Map<String, dynamic>) {
        paginated = PaginatedExpenses.fromJson(
          res["data"] as Map<String, dynamic>,
        );
      } else if (res["data"] is List<dynamic>) {
        final list = (res["data"] as List<dynamic>)
            .map((e) => Expense.fromJson(e as Map<String, dynamic>))
            .toList();
        paginated = PaginatedExpenses(
          content: list,
          page: page,
          size: size,
          totalElements: list.length,
          totalPages: (list.length / size).ceil(),
        );
      }

      return ApiResponse<PaginatedExpenses?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Expenses retrieved successfully"
        ..data = paginated;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Expense?>> createExpense(CreateExpenseParam param) async {
    try {
      final res = await _apiService.post(
        '',
        data: param.toJson(),
      );

      return ApiResponse<Expense?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Expense recorded successfully"
        ..data = res["data"] != null
            ? Expense.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<dynamic>> deleteExpense(String id) async {
    try {
      final res = await _apiService.delete('/$id');
      return ApiResponse.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Expense deleted successfully";
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
