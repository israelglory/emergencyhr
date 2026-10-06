import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/invoice_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class InvoiceHomeViewModel extends BaseViewModel {
  final InvoiceRepo _invoiceRepo;
  final BranchRepo _branchRepo;

  final TextEditingController searchController = TextEditingController();

  InvoiceHomeViewModel({InvoiceRepo? invoiceRepo, BranchRepo? branchRepo})
    : _invoiceRepo = invoiceRepo ?? invoiceRepoLocator,
      _branchRepo = branchRepo ?? branchRepoLocator;

  static InvoiceRepo get invoiceRepoLocator => invoiceRepo;
  static BranchRepo get branchRepoLocator => branchRepo;

  List<Invoice> _allInvoices = [];
  List<Invoice> _filteredInvoices = [];

  String _selectedStatusFilter = 'ALL';
  String get selectedStatusFilter => _selectedStatusFilter;

  String? _selectedBranchId;
  String? get selectedBranchId => _selectedBranchId;

  List<Branch> _branches = [];
  List<Branch> get branches => _branches;

  List<Invoice> get invoices => _filteredInvoices;
  bool get hasInvoices => _filteredInvoices.isNotEmpty;

  Future<void> init() async {
    // Load branches for Admin filter
    if (appGlobals.isAdmin) {
      _branches = _branchRepo.getCachedBranches();
      if (_branches.isEmpty && appGlobals.user?.branches != null) {
        _branches = appGlobals.user!.branches;
      }
    }

    // Load initial cached invoices
    final cached = _invoiceRepo.getCachedInvoices();
    if (cached.isNotEmpty) {
      _allInvoices = cached;
      _applyFilters();
      notifyListeners();
    }

    await loadInvoices(showLoading: cached.isEmpty);
  }

  Future<void> loadInvoices({bool showLoading = true}) async {
    if (showLoading) setBusy(true);

    try {
      final response = await _invoiceRepo.getInvoices(
        branchId: _selectedBranchId,
      );

      if (response.success && response.data != null) {
        _allInvoices = response.data!;
        _applyFilters();
      } else if (_allInvoices.isEmpty) {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to load invoices',
        );
      }
    } catch (e) {
      if (_allInvoices.isEmpty) {
        snackbarService.error(message: 'Error loading invoices');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void onSearchChanged(String query) {
    _applyFilters();
  }

  void setStatusFilter(String status) {
    _selectedStatusFilter = status;
    _applyFilters();
  }

  void setBranchFilter(String? branchId) {
    _selectedBranchId = branchId;
    loadInvoices(showLoading: false);
  }

  void clearSearch() {
    searchController.clear();
    _applyFilters();
  }

  void _applyFilters() {
    final query = searchController.text.toLowerCase().trim();

    _filteredInvoices = _allInvoices.where((invoice) {
      // Status match
      bool statusMatch = true;
      if (_selectedStatusFilter != 'ALL') {
        final st = invoice.status.label.toUpperCase();
        final rawSt = invoice.statusString?.toUpperCase();
        if (_selectedStatusFilter == 'UNPAID') {
          statusMatch = st == 'UNPAID' || rawSt == 'UNPAID';
        } else if (_selectedStatusFilter == 'PARTIALLY_PAID') {
          statusMatch =
              st == 'PARTIALLY PAID' ||
              st == 'PARTIALLY_PAID' ||
              rawSt == 'PARTIALLY_PAID' ||
              rawSt == 'PARTIALLY PAID';
        } else if (_selectedStatusFilter == 'PAID') {
          statusMatch = st == 'PAID' || rawSt == 'PAID';
        }
      }

      // Branch match (if filtered locally)
      bool branchMatch = true;
      if (_selectedBranchId != null && _selectedBranchId!.isNotEmpty) {
        branchMatch = invoice.branchId == _selectedBranchId;
      }

      // Search match
      bool searchMatch = true;
      if (query.isNotEmpty) {
        searchMatch =
            invoice.customerName.toLowerCase().contains(query) ||
            invoice.customerPhone.toLowerCase().contains(query) ||
            invoice.invoiceNumber.toLowerCase().contains(query);
      }

      return statusMatch && branchMatch && searchMatch;
    }).toList();

    notifyListeners();
  }

  Future<void> deleteInvoice(String invoiceId) async {
    if (!appGlobals.canDelete) {
      snackbarService.error(
        message: 'You do not have permission to delete invoices.',
      );
      return;
    }

    setBusy(true);
    try {
      final res = await _invoiceRepo.deleteInvoice(invoiceId);
      if (res.success) {
        _allInvoices.removeWhere((i) => i.id == invoiceId);
        _applyFilters();
        snackbarService.success(message: 'Invoice deleted successfully');
      } else {
        snackbarService.error(
          message: res.message?.isNotEmpty == true
              ? res.message!
              : 'Failed to delete invoice',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Error deleting invoice');
    } finally {
      setBusy(false);
    }
  }

  Future<void> refreshInvoices() async {
    await loadInvoices(showLoading: false);
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
