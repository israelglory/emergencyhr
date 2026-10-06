import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/report_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class ReportViewModel extends BaseViewModel {
  final ReportRepo _reportRepo;
  final BranchRepo _branchRepo;

  ReportViewModel({ReportRepo? reportRepo, BranchRepo? branchRepo})
    : _reportRepo = reportRepo ?? reportRepoLocator,
      _branchRepo = branchRepo ?? branchRepoLocator;

  static ReportRepo get reportRepoLocator => reportRepo;
  static BranchRepo get branchRepoLocator => branchRepo;

  FinancialReport? _report;
  FinancialReport get report => _report ?? FinancialReport.empty();

  String _selectedFilter = 'ALL_TIME';
  String get selectedFilter => _selectedFilter;

  DateTime? _customStartDate;
  DateTime? get customStartDate => _customStartDate;

  DateTime? _customEndDate;
  DateTime? get customEndDate => _customEndDate;

  String? _selectedBranchId;
  String? get selectedBranchId => _selectedBranchId;

  List<Branch> _branches = [];
  List<Branch> get branches => _branches;

  final List<Map<String, String>> filterOptions = [
    {'value': 'ALL_TIME', 'label': 'All Time'},
    {'value': 'TODAY', 'label': 'Today'},
    {'value': 'THIS_WEEK', 'label': 'This Week'},
    {'value': 'THIS_MONTH', 'label': 'This Month'},
    {'value': 'THIS_YEAR', 'label': 'This Year'},
    {'value': 'CUSTOM', 'label': 'Custom Range'},
  ];

  Future<void> init() async {
    // If not allowed by RBAC, don't fetch
    if (!appGlobals.canViewFinancialReports) {
      return;
    }

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

    // Load initial cached report if present
    final cached = _reportRepo.getCachedFinancialReport();
    if (cached != null) {
      _report = cached;
      notifyListeners();
    }

    await loadReportData(showLoading: cached == null);
  }

  Future<void> loadReportData({bool showLoading = true}) async {
    if (!appGlobals.canViewFinancialReports) return;

    if (showLoading) setBusy(true);

    try {
      final response = await _reportRepo.getFinancialReport(
        filter: _selectedFilter,
        startDate: _customStartDate,
        endDate: _customEndDate,
        branchId: _selectedBranchId,
      );

      if (response.success && response.data != null) {
        _report = response.data!;
      } else if (_report == null) {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to generate financial report',
        );
      }
    } catch (e) {
      if (_report == null) {
        snackbarService.error(message: 'Error generating financial report');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    if (filter != 'CUSTOM') {
      _customStartDate = null;
      _customEndDate = null;
      loadReportData();
    }
    notifyListeners();
  }

  void setCustomDateRange(DateTime start, DateTime end) {
    _selectedFilter = 'CUSTOM';
    _customStartDate = start;
    _customEndDate = end;
    loadReportData();
  }

  void setBranchFilter(String? branchId) {
    _selectedBranchId = branchId;
    loadReportData();
  }

  String get activeFilterLabel {
    if (_selectedFilter == 'CUSTOM' &&
        _customStartDate != null &&
        _customEndDate != null) {
      final f = DateFormat('MMM dd, yyyy');
      return '${f.format(_customStartDate!)} - ${f.format(_customEndDate!)}';
    }
    final match = filterOptions.where((opt) => opt['value'] == _selectedFilter);
    return match.isNotEmpty ? match.first['label']! : 'All Time';
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

  Future<void> shareReportSummary() async {
    if (_report == null) return;
    final rep = _report!;
    final summaryText =
        '''
📊 Financial Performance Report: $activeBranchName ($activeFilterLabel)
━━━━━━━━━━━━━━━━━━━━━━━━━━
💰 Total Invoiced: ${CurrencyFormatter.formatNaira(rep.totalInvoicedAmount)} (${rep.totalInvoicesCount} invoices)
💵 Total Collected: ${CurrencyFormatter.formatNaira(rep.totalCollectedAmount)}
⏳ Outstanding Receivables: ${CurrencyFormatter.formatNaira(rep.totalOutstandingAmount)}
📈 Collection Rate: ${rep.collectionRate.toStringAsFixed(1)}%
📉 Total Expenses: ${CurrencyFormatter.formatNaira(rep.totalExpensesAmount)}
✨ Net Income: ${CurrencyFormatter.formatNaira(rep.netIncome)}
━━━━━━━━━━━━━━━━━━━━━━━━━━
Generated via Bglow creations ent.
''';

    try {
      await Share.share(summaryText);
    } catch (e) {
      debugPrint('Error sharing report: $e');
    }
  }
}
