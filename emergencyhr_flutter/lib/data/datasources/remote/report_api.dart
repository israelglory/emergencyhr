import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class ReportDataProvider {
  final _apiService = ApiService(path: '/reports');

  Future<ApiResponse<FinancialReport?>> getFinancialReport({
    String filter = 'ALL_TIME',
    DateTime? startDate,
    DateTime? endDate,
    String? branchId,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'filter': filter,
      };

      if (filter == 'CUSTOM') {
        if (startDate != null) {
          queryParams['startDate'] = startDate.toUtc().toIso8601String();
        }
        if (endDate != null) {
          queryParams['endDate'] = endDate.toUtc().toIso8601String();
        }
      }

      // If branchId is provided and non-empty, pass it. If admin wants all reports, it is omitted.
      if (branchId != null && branchId.isNotEmpty) {
        queryParams['branchId'] = branchId;
      }

      final res = await _apiService.get(
        '/financial',
        queryParams: queryParams,
      );

      return ApiResponse<FinancialReport?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ??
            "Financial report generated successfully"
        ..data = res["data"] != null
            ? FinancialReport.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
