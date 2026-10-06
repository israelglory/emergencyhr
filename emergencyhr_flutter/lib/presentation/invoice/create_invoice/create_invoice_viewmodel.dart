import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/customer_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/invoice_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:emergencyhr_flutter/presentation/invoice/invoice_preview/invoice_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:stacked/stacked.dart';

class CreateInvoiceViewModel extends BaseViewModel {
  final InvoiceRepo _invoiceRepo;
  final CustomerRepo _customerRepo;
  final BranchRepo _branchRepo;
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  CreateInvoiceViewModel({
    InvoiceRepo? invoiceRepo,
    CustomerRepo? customerRepo,
    BranchRepo? branchRepo,
    String? prefilledCustomerName,
    String? prefilledCustomerAddress,
    String? prefilledCustomerPhone,
  }) : _invoiceRepo = invoiceRepo ?? invoiceRepoLocator,
       _customerRepo = customerRepo ?? customerRepoLocator,
       _branchRepo = branchRepo ?? branchRepoLocator {
    if (prefilledCustomerName != null) {
      customerNameController.text = prefilledCustomerName;
    }
    if (prefilledCustomerAddress != null) {
      addressController.text = prefilledCustomerAddress;
    }
    if (prefilledCustomerPhone != null) {
      phoneNumberController.text = prefilledCustomerPhone;
    }
  }

  static InvoiceRepo get invoiceRepoLocator => invoiceRepo;
  static CustomerRepo get customerRepoLocator => customerRepo;
  static BranchRepo get branchRepoLocator => branchRepo;

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController taxRateController = TextEditingController(
    text: '7.5',
  );

  // Branch Selection
  String? _selectedBranchId;
  String? get selectedBranchId => _selectedBranchId;
  List<Branch> _branches = [];
  List<Branch> get branches => _branches;

  // Customers Cache for Auto-Select
  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  // Dates
  DateTime invoiceDate = DateTime.now();
  DateTime dueDate = DateTime.now().add(const Duration(days: 30));

  // Items list
  final List<InvoiceItemInput> _items = [InvoiceItemInput()];
  List<InvoiceItemInput> get items => _items;

  // Tax state
  bool _isTaxEnabled = true;
  bool get isTaxEnabled => _isTaxEnabled;

  // Form validation
  String? _branchError;
  String? _customerNameError;
  String? _addressError;
  String? _phoneError;
  final List<String?> _itemErrors = [];

  String? get branchError => _branchError;
  String? get customerNameError => _customerNameError;
  String? get addressError => _addressError;
  String? get phoneError => _phoneError;
  List<String?> get itemErrors => _itemErrors;

  // Loading states
  bool _isCreatingInvoice = false;
  bool get isCreatingInvoice => _isCreatingInvoice;

  Future<void> init() async {
    _initializeItemListeners();
    taxRateController.addListener(() => _calculateTotals());

    // Load branches
    _branches = _branchRepo.getCachedBranches();
    if (_branches.isEmpty && appGlobals.user?.branches != null) {
      _branches = appGlobals.user!.branches;
    }

    // Set initial branch
    if (appGlobals.isAdmin) {
      if (_branches.isNotEmpty) {
        final mainBranch = _branches.firstWhere(
          (b) => b.isMainBranch,
          orElse: () => _branches.first,
        );
        _selectedBranchId = mainBranch.id;
      }
    } else {
      // Non-admin uses assigned branch
      _selectedBranchId =
          appGlobals.user?.branch?.id ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.first.id
              : null);
    }

    // Load customers
    _customers = _customerRepo.getCachedCustomers();
    if (_customers.isEmpty) {
      final res = await _customerRepo.getCustomers();
      if (res.success && res.data != null) {
        _customers = res.data!;
      }
    }

    notifyListeners();
  }

  void setSelectedBranch(String? branchId) {
    _selectedBranchId = branchId;
    _branchError = null;
    notifyListeners();
  }

  String get assignedBranchName {
    if (_selectedBranchId == null) return 'Default Branch';
    final match = _branches.where((b) => b.id == _selectedBranchId);
    if (match.isNotEmpty) return match.first.name;
    if (appGlobals.user?.branch?.name != null) {
      return appGlobals.user!.branch!.name;
    }
    return 'Assigned Branch';
  }

  void selectCustomer(Customer customer) {
    customerNameController.text = customer.name;
    addressController.text = customer.address;
    phoneNumberController.text = customer.phone;
    _customerNameError = null;
    _addressError = null;
    _phoneError = null;
    notifyListeners();
  }

  void _initializeItemListeners() {
    for (int i = 0; i < _items.length; i++) {
      _items[i].nameController.addListener(() => _calculateTotals());
      _items[i].qtyController.addListener(() => _calculateTotals());
      _items[i].priceController.addListener(() => _calculateTotals());
    }
  }

  void _calculateTotals() {
    notifyListeners();
  }

  void toggleTax(bool value) {
    _isTaxEnabled = value;
    notifyListeners();
  }

  Future<void> selectContactPhone() async {
    try {
      final Contact? contact = await _contactPicker.selectPhoneNumber();
      if (contact != null) {
        String? phone = contact.selectedPhoneNumber;
        if (phone == null || phone.isEmpty) {
          if (contact.phoneNumbers != null &&
              contact.phoneNumbers!.isNotEmpty) {
            phone = contact.phoneNumbers!.first;
          }
        }

        if (phone != null && phone.isNotEmpty) {
          phoneNumberController.text = phone;
          _phoneError = null;
        }

        if (customerNameController.text.trim().isEmpty &&
            contact.fullName != null &&
            contact.fullName!.isNotEmpty) {
          customerNameController.text = contact.fullName!;
          _customerNameError = null;
        }

        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error selecting contact: $e');
    }
  }

  void addNewItem() {
    final newItem = InvoiceItemInput();
    newItem.nameController.addListener(() => _calculateTotals());
    newItem.qtyController.addListener(() => _calculateTotals());
    newItem.priceController.addListener(() => _calculateTotals());

    _items.add(newItem);
    _itemErrors.add(null);
    notifyListeners();
  }

  void removeItem(int index) {
    if (_items.length > 1) {
      _items[index].dispose();
      _items.removeAt(index);
      _itemErrors.removeAt(index);
      notifyListeners();
    }
  }

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.total);
  double get taxRate {
    if (!_isTaxEnabled) return 0.0;
    return double.tryParse(taxRateController.text.trim()) ?? 0.0;
  }

  String get formattedTaxRate {
    if (!_isTaxEnabled) return '0';
    final rate = double.tryParse(taxRateController.text.trim()) ?? 0.0;
    return rate % 1 == 0 ? rate.toInt().toString() : rate.toString();
  }

  double get tax => subtotal * (taxRate / 100.0);
  double get total => subtotal + tax;

  void updateInvoiceDate(DateTime date) {
    invoiceDate = date;
    notifyListeners();
  }

  void updateDueDate(DateTime date) {
    dueDate = date;
    notifyListeners();
  }

  bool _validateForm() {
    bool isValid = true;

    // Validate Branch
    if (_selectedBranchId == null || _selectedBranchId!.isEmpty) {
      _branchError = 'Please select a store branch';
      isValid = false;
    } else {
      _branchError = null;
    }

    // Validate customer name
    if (customerNameController.text.trim().isEmpty) {
      _customerNameError = 'Customer name is required';
      isValid = false;
    } else {
      _customerNameError = null;
    }

    // Validate address
    if (addressController.text.trim().isEmpty) {
      _addressError = 'Address is required';
      isValid = false;
    } else {
      _addressError = null;
    }

    // Validate phone
    if (phoneNumberController.text.trim().isEmpty) {
      _phoneError = 'Phone number is required';
      isValid = false;
    } else {
      _phoneError = null;
    }

    // Validate items
    _itemErrors.clear();
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      String? error;

      if (item.nameController.text.trim().isEmpty) {
        error = 'Item name is required';
        isValid = false;
      } else if ((int.tryParse(item.qtyController.text) ?? 0) <= 0) {
        error = 'Valid quantity is required';
        isValid = false;
      } else if ((double.tryParse(item.priceController.text) ?? 0) <= 0) {
        error = 'Valid price is required';
        isValid = false;
      }

      _itemErrors.add(error);
    }

    // Check if there's at least one valid item
    if (_items.isEmpty || subtotal <= 0) {
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> createInvoice() async {
    if (!_validateForm()) {
      return;
    }

    _isCreatingInvoice = true;
    notifyListeners();

    try {
      final param = CreateInvoiceParam(
        branchId: _selectedBranchId!,
        customerName: customerNameController.text.trim(),
        customerAddress: addressController.text.trim(),
        customerPhone: phoneNumberController.text.trim(),
        invoiceDate: invoiceDate,
        dueDate: dueDate,
        taxRate: taxRate,
        items: _items.map((item) => item.toInvoiceItem()).toList(),
      );

      final response = await _invoiceRepo.createInvoice(param: param);

      if (response.success && response.data != null) {
        snackbarService.success(message: 'Invoice created successfully!');

        // Navigate to preview page
        await navigationService.push(
          InvoicePreviewView(invoice: response.data!),
        );

        // Clear form
        _clearForm();
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to create invoice',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Failed to create invoice: $e');
    } finally {
      _isCreatingInvoice = false;
      notifyListeners();
    }
  }

  void _clearForm() {
    customerNameController.clear();
    addressController.clear();
    phoneNumberController.clear();
    taxRateController.text = '7.5';
    _isTaxEnabled = true;

    // Clear all items and add one empty item
    for (var item in _items) {
      item.dispose();
    }
    _items.clear();
    _items.add(InvoiceItemInput());
    _initializeItemListeners();

    // Reset dates
    invoiceDate = DateTime.now();
    dueDate = DateTime.now().add(const Duration(days: 30));

    // Clear errors
    _branchError = null;
    _customerNameError = null;
    _addressError = null;
    _phoneError = null;
    _itemErrors.clear();

    notifyListeners();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    taxRateController.dispose();

    for (var item in _items) {
      item.dispose();
    }
    super.dispose();
  }
}
