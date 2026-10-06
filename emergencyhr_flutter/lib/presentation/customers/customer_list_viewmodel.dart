import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/customer_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/add_edit_customer_bottom_sheet.dart';
import 'customer_statement/customer_statement_view.dart';

class CustomerListViewModel extends BaseViewModel {
  final CustomerRepo _customerRepo;

  CustomerListViewModel({CustomerRepo? customerRepo})
    : _customerRepo = customerRepo ?? customerRepoLocator;

  static CustomerRepo get customerRepoLocator => customerRepo;

  final TextEditingController searchController = TextEditingController();

  List<Customer> _allCustomers = [];
  List<Customer> _filteredCustomers = [];
  List<Customer> get customers => _filteredCustomers;

  int get totalCount => _filteredCustomers.length;

  Future<void> init() async {
    // Load local cache immediately for instant UI
    final cached = _customerRepo.getCachedCustomers();
    if (cached.isNotEmpty) {
      _allCustomers = cached;
      _filteredCustomers = cached;
      notifyListeners();
    }
    await fetchCustomers(showLoading: cached.isEmpty);
  }

  Future<void> fetchCustomers({bool showLoading = true}) async {
    if (showLoading) setBusy(true);

    try {
      final response = await _customerRepo.getCustomers();
      if (response.success && response.data != null) {
        _allCustomers = response.data!;
        _applySearch(searchController.text);
      } else if (_allCustomers.isEmpty) {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to load customers',
        );
      }
    } catch (e) {
      if (_allCustomers.isEmpty) {
        snackbarService.error(message: 'Error loading customers');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void onSearchChanged(String query) {
    _applySearch(query);
  }

  void _applySearch(String query) {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      _filteredCustomers = List.from(_allCustomers);
    } else {
      _filteredCustomers = _allCustomers.where((c) {
        final nameMatch = c.name.toLowerCase().contains(cleanQuery);
        final phoneMatch = c.phone.toLowerCase().contains(cleanQuery);
        final addressMatch = c.address.toLowerCase().contains(cleanQuery);
        return nameMatch || phoneMatch || addressMatch;
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _filteredCustomers = List.from(_allCustomers);
    notifyListeners();
  }

  Future<void> deleteCustomer(String id) async {
    if (!appGlobals.canDelete) {
      snackbarService.error(
        message: 'Permission denied: Only administrators can delete customers.',
      );
      return;
    }

    setBusy(true);
    try {
      final response = await _customerRepo.deleteCustomer(id);
      if (response.success) {
        _allCustomers.removeWhere((c) => c.id == id);
        _applySearch(searchController.text);
        snackbarService.success(message: 'Customer deleted successfully');
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to delete customer',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Error deleting customer');
    } finally {
      setBusy(false);
    }
  }

  Future<void> callCustomer(String phone) async {
    if (phone.isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        copyToClipboard(phone, 'Phone number');
      }
    } catch (e) {
      copyToClipboard(phone, 'Phone number');
    }
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    snackbarService.success(message: '$label copied to clipboard!');
  }

  void openAddCustomerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditCustomerBottomSheet(
        onSaved: () => fetchCustomers(showLoading: false),
      ),
    );
  }

  void openEditCustomerSheet(BuildContext context, Customer customer) {
    if (!appGlobals.canEdit) {
      openViewCustomerDetails(context, customer);
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditCustomerBottomSheet(
        customer: customer,
        onSaved: () => fetchCustomers(showLoading: false),
      ),
    );
  }

  void openViewCustomerDetails(BuildContext context, Customer customer) {
    navigationService.push(CustomerStatementView(customer: customer));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
