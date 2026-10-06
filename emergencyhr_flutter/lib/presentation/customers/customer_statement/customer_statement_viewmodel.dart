import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/customer_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class CustomerStatementViewModel extends BaseViewModel {
  final Customer customer;
  final CustomerRepo _customerRepo;

  CustomerStatementViewModel({
    required this.customer,
    CustomerRepo? customerRepo,
  }) : _customerRepo = customerRepo ?? customerRepoLocator;

  static CustomerRepo get customerRepoLocator => customerRepo;

  CustomerStatement? _statement;
  CustomerStatement get statement =>
      _statement ?? CustomerStatement.empty(customer: customer);

  String _selectedStatusFilter = 'All';
  String get selectedStatusFilter => _selectedStatusFilter;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final TextEditingController searchController = TextEditingController();

  Future<void> init() async {
    await loadStatement(showLoading: true);
  }

  Future<void> loadStatement({bool showLoading = true}) async {
    if (showLoading) setBusy(true);

    try {
      final response = await _customerRepo.getCustomerInvoices(customer.id);
      if (response.success && response.data != null) {
        _statement = response.data!;
      } else {
        if (_statement == null) {
          snackbarService.error(
            message: response.message?.isNotEmpty == true
                ? response.message!
                : 'Failed to load customer statement',
          );
        }
      }
    } catch (e) {
      if (_statement == null) {
        snackbarService.error(message: 'Error loading customer statement');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void setStatusFilter(String filter) {
    _selectedStatusFilter = filter;
    notifyListeners();
  }

  void onSearchChanged(String query) {
    _searchQuery = query.trim().toLowerCase();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    searchController.clear();
    notifyListeners();
  }

  List<Invoice> get filteredInvoices {
    final list = statement.invoices;
    return list.where((inv) {
      // Status Filter
      if (_selectedStatusFilter == 'Paid' && inv.status != InvoiceStatus.paid) {
        return false;
      }
      if (_selectedStatusFilter == 'Partially Paid' &&
          inv.status != InvoiceStatus.partiallyPaid) {
        return false;
      }
      if (_selectedStatusFilter == 'Unpaid' &&
          inv.status != InvoiceStatus.unpaid) {
        return false;
      }

      // Search Query
      if (_searchQuery.isNotEmpty) {
        final matchesNum = inv.invoiceNumber.toLowerCase().contains(
          _searchQuery,
        );
        final matchesItems = inv.items.any(
          (i) => i.name.toLowerCase().contains(_searchQuery),
        );
        final matchesDate = DateFormat(
          'dd MMM yyyy',
        ).format(inv.invoiceDate).toLowerCase().contains(_searchQuery);
        if (!matchesNum && !matchesItems && !matchesDate) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  Future<void> shareStatementSummary() async {
    final st = statement;
    final summaryText =
        '''
🧾 Customer Financial Statement: ${st.customer.name}
━━━━━━━━━━━━━━━━━━━━━━━━━━
📞 Phone: ${st.customer.phone.isNotEmpty ? st.customer.phone : "N/A"}
📍 Address: ${st.customer.address.isNotEmpty ? st.customer.address : "N/A"}
━━━━━━━━━━━━━━━━━━━━━━━━━━
💰 Total Billed: ${CurrencyFormatter.formatNaira(st.totalAmount)}
💵 Total Paid: ${CurrencyFormatter.formatNaira(st.totalPaid)}
⏳ Outstanding Balance: ${CurrencyFormatter.formatNaira(st.totalRemaining)}
📊 Total Invoices: ${st.totalInvoices} (${st.paidCount} Paid, ${st.partiallyPaidCount} Partial, ${st.unpaidCount} Unpaid)
📈 Collection Rate: ${st.collectionRate.toStringAsFixed(1)}%
━━━━━━━━━━━━━━━━━━━━━━━━━━
Generated via Bglow creations ent.
''';

    try {
      await Share.share(summaryText);
    } catch (e) {
      debugPrint('Error sharing statement: $e');
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
