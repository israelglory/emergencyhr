import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/local/expense_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/expense_api.dart';
import 'package:emergencyhr_flutter/data/model/params/expense.dart';

class ExpenseRepo {
  final ExpenseDataProvider _expenseApi;
  final ExpenseLocalStorage _localStorage;

  ExpenseRepo({
    ExpenseDataProvider? expenseApi,
    ExpenseLocalStorage? localStorage,
  }) : _expenseApi = expenseApi ?? ExpenseDataProvider(),
       _localStorage = localStorage ?? expenseLocalStorage;

  /// Fetches paginated expenses with role-based scoping:
  /// - Admin: Can view all branches (omit branchId) or filter by branch.
  /// - Non-admin (Staff, Sales boy): Automatically scoped to assigned branch.
  Future<ApiResponse<PaginatedExpenses?>> getExpenses({
    String? branchId,
    String? search,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int size = 20,
  }) async {
    String? effectiveBranchId;
    if (!appGlobals.isAdmin) {
      // Non-admins must only view their assigned branch
      effectiveBranchId =
          appGlobals.user?.branch?.id ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.first.id
              : null);
    } else {
      // Admin: if a specific branch is selected, pass it; otherwise omit
      if (branchId != null && branchId.isNotEmpty) {
        effectiveBranchId = branchId;
      }
    }

    final response = await _expenseApi.getExpenses(
      branchId: effectiveBranchId,
      search: search,
      category: category,
      startDate: startDate,
      endDate: endDate,
      page: page,
      size: size,
    );

    if (response.success && response.data != null) {
      _localStorage.saveExpenses(response.data!.content);
    } else {
      final cached = _localStorage.getExpenses();
      if (cached.isNotEmpty) {
        return ApiResponse<PaginatedExpenses?>(
          success: true,
          message: 'Loaded from local cache',
          data: PaginatedExpenses(
            content: cached,
            page: 0,
            size: cached.length,
            totalElements: cached.length,
            totalPages: 1,
          ),
        );
      }
    }

    return response;
  }

  /// Records a new expense.
  Future<ApiResponse<Expense?>> createExpense(CreateExpenseParam param) async {
    final response = await _expenseApi.createExpense(param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getExpenses();
      cached.insert(0, response.data!);
      _localStorage.saveExpenses(cached);
    }
    return response;
  }

  /// Deletes an expense (Guarded by RBAC canDelete).
  Future<ApiResponse<dynamic>> deleteExpense(String id) async {
    if (!appGlobals.canDelete) {
      return ApiResponse(
        success: false,
        message: 'Only administrators have permission to delete expenses.',
      );
    }

    final response = await _expenseApi.deleteExpense(id);
    if (response.success) {
      final cached = _localStorage.getExpenses();
      cached.removeWhere((e) => e.id == id);
      _localStorage.saveExpenses(cached);
    }
    return response;
  }

  List<Expense> getCachedExpenses() {
    return _localStorage.getExpenses();
  }
}
