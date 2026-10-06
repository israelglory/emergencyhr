import 'dart:async';

import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/expense_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExpenseHomeViewModel extends BaseViewModel {
  final ExpenseRepo _expenseRepo;
  final BranchRepo _branchRepo;

  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  ExpenseHomeViewModel({ExpenseRepo? expenseRepo, BranchRepo? branchRepo})
    : _expenseRepo = expenseRepo ?? expenseRepoLocator,
      _branchRepo = branchRepo ?? branchRepoLocator;

  static ExpenseRepo get expenseRepoLocator => expenseRepo;
  static BranchRepo get branchRepoLocator => branchRepo;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;
  List<Expense> get allExpenses => _expenses;

  List<Branch> _branches = [];
  List<Branch> get branches => _branches;

  String? _selectedBranchId;
  String? get selectedBranchId => _selectedBranchId;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  DateTime? _startDate;
  DateTime? get startDate => _startDate;

  DateTime? _endDate;
  DateTime? get endDate => _endDate;

  int _totalElements = 0;
  int get totalElements => _totalElements;

  final List<String> categories = [
    'All',
    'Office Supplies',
    'Materials',
    'Equipment',
    'Utilities',
    'Logistics',
    'Rent',
    'General',
  ];

  Future<void> init() async {
    // Load branches for Admin filter
    if (appGlobals.isAdmin) {
      _branches = _branchRepo.getCachedBranches();
      if (_branches.isEmpty && appGlobals.user?.branches != null) {
        _branches = appGlobals.user!.branches;
      }
    } else {
      _selectedBranchId =
          appGlobals.user?.branch?.id ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.first.id
              : null);
    }

    // Load initial cached expenses
    final cached = _expenseRepo.getCachedExpenses();
    if (cached.isNotEmpty) {
      _expenses = cached;
      _totalElements = cached.length;
      notifyListeners();
    }

    await loadExpenses(showLoading: cached.isEmpty);
  }

  Future<void> loadExpenses({bool showLoading = true}) async {
    if (showLoading) setBusy(true);

    try {
      final response = await _expenseRepo.getExpenses(
        branchId: _selectedBranchId,
        search: _searchQuery,
        category: _selectedCategory == 'All' ? null : _selectedCategory,
        startDate: _startDate,
        endDate: _endDate,
        page: 0,
        size: 50,
      );

      if (response.success && response.data != null) {
        _expenses = response.data!.content;
        _totalElements = response.data!.totalElements;
      } else if (_expenses.isEmpty) {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to load expenses',
        );
      }
    } catch (e) {
      if (_expenses.isEmpty) {
        snackbarService.error(message: 'Error loading expenses');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void onSearchChanged(String query) {
    _searchQuery = query.trim();
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      loadExpenses(showLoading: false);
    });
  }

  void setCategoryFilter(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
    loadExpenses(showLoading: true);
  }

  void setBranchFilter(String? branchId) {
    if (_selectedBranchId == branchId) return;
    _selectedBranchId = branchId;
    notifyListeners();
    loadExpenses(showLoading: true);
  }

  void setDateFilter(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
    loadExpenses(showLoading: true);
  }

  void clearFilters() {
    _searchQuery = '';
    searchController.clear();
    _selectedCategory = 'All';
    _startDate = null;
    _endDate = null;
    if (appGlobals.isAdmin) {
      _selectedBranchId = null;
    }
    notifyListeners();
    loadExpenses(showLoading: true);
  }

  double get totalExpensesAmount {
    return _expenses.fold(0.0, (sum, e) => sum + e.amount);
  }

  double get thisMonthExpensesAmount {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  String get activeBranchName {
    if (_selectedBranchId == null || _selectedBranchId!.isEmpty) {
      return 'All Store Branches';
    }
    final match = _branches.where((b) => b.id == _selectedBranchId);
    if (match.isNotEmpty) return match.first.name;
    if (appGlobals.user?.branch?.name != null) {
      return appGlobals.user!.branch!.name;
    }
    return 'Assigned Branch';
  }

  Future<bool> createExpense(CreateExpenseParam param) async {
    setBusy(true);
    try {
      final response = await _expenseRepo.createExpense(param);
      if (response.success && response.data != null) {
        snackbarService.success(
          message: response.message ?? 'Expense recorded successfully',
        );
        await loadExpenses(showLoading: false);
        return true;
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to record expense',
        );
        return false;
      }
    } catch (e) {
      snackbarService.error(message: 'Failed to record expense');
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteExpense(String id) async {
    if (!appGlobals.canDelete) {
      snackbarService.error(
        message: 'Only administrators have permission to delete expenses',
      );
      return;
    }

    try {
      final response = await _expenseRepo.deleteExpense(id);
      if (response.success) {
        snackbarService.success(message: 'Expense deleted successfully');
        await loadExpenses(showLoading: false);
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to delete expense',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Failed to delete expense');
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
