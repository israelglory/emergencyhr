import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/local/report_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/report_api.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class ReportRepo {
  final ReportDataProvider _reportApi;
  final ReportLocalStorage _localStorage;

  ReportRepo({
    ReportDataProvider? reportApi,
    ReportLocalStorage? localStorage,
  }) : _reportApi = reportApi ?? ReportDataProvider(),
       _localStorage = localStorage ?? reportLocalStorage;

  /// Fetches the financial report based on the active role and filters.
  /// - ROLE_ADMIN: Can view all branches (branchId omitted) or a specific branch.
  /// - ROLE_STAFF: Locked to their assigned branch.
  /// - ROLE_SALE_BOY: Access denied.
  Future<ApiResponse<FinancialReport?>> getFinancialReport({
    String filter = 'ALL_TIME',
    DateTime? startDate,
    DateTime? endDate,
    String? branchId,
  }) async {
    // Check RBAC permissions
    if (!appGlobals.canViewFinancialReports) {
      return ApiResponse<FinancialReport?>(
        success: false,
        message: 'You do not have permission to view financial reports.',
      );
    }

    String? effectiveBranchId;
    if (appGlobals.isStaff) {
      // Staff must only see their attached branch
      effectiveBranchId =
          appGlobals.user?.branch?.id ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.first.id
              : null);
    } else if (appGlobals.isAdmin) {
      // Admin: if specific branch selected, pass it; if "All Branches" (null/empty), omit it.
      if (branchId != null && branchId.isNotEmpty) {
        effectiveBranchId = branchId;
      }
    }

    final response = await _reportApi.getFinancialReport(
      filter: filter,
      startDate: startDate,
      endDate: endDate,
      branchId: effectiveBranchId,
    );

    if (response.success && response.data != null) {
      _localStorage.saveFinancialReport(response.data!);
    } else {
      final cached = _localStorage.getFinancialReport();
      if (cached != null) {
        return ApiResponse<FinancialReport?>(
          success: true,
          message: 'Loaded from local cache',
          data: cached,
        );
      }
    }

    return response;
  }

  FinancialReport? getCachedFinancialReport() {
    return _localStorage.getFinancialReport();
  }
}
