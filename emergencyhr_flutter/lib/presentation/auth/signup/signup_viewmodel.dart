import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdditionalBranchItem {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;

  AdditionalBranchItem({
    String name = '',
    String address = '',
    String phone = '',
  }) : nameController = TextEditingController(text: name),
       addressController = TextEditingController(text: address),
       phoneController = TextEditingController(text: phone);

  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
  }
}

class SignUpViewModel extends BaseViewModel {
  int _currentStep = 0;
  int get currentStep => _currentStep;

  final PageController pageController = PageController();

  final GlobalKey<FormState> step0FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> step2FormKey = GlobalKey<FormState>();

  // Step 0: Owner Credentials
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  // Step 1: Business & Branches
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController mainBranchNameController = TextEditingController(
    text: 'Head Office & Main Store',
  );
  final TextEditingController mainBranchAddressController =
      TextEditingController();
  final TextEditingController mainBranchPhoneController =
      TextEditingController();

  final List<AdditionalBranchItem> additionalBranches = [];

  // Step 2: Bank Settlement Details
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void addBranch() {
    additionalBranches.add(
      AdditionalBranchItem(
        name: 'Branch ${additionalBranches.length + 2}',
        phone: phoneController.text.trim(),
      ),
    );
    notifyListeners();
  }

  void removeBranch(int index) {
    if (index >= 0 && index < additionalBranches.length) {
      additionalBranches[index].dispose();
      additionalBranches.removeAt(index);
      notifyListeners();
    }
  }

  void nextStep() {
    if (_currentStep == 0) {
      if (!step0FormKey.currentState!.validate()) return;
      if (mainBranchPhoneController.text.isEmpty) {
        mainBranchPhoneController.text = phoneController.text.trim();
      }
      _currentStep = 1;
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else if (_currentStep == 1) {
      if (!step1FormKey.currentState!.validate()) return;
      if (accountNameController.text.isEmpty) {
        accountNameController.text = businessNameController.text.trim();
      }
      _currentStep = 2;
      pageController.animateToPage(
        2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else if (_currentStep == 2) {
      submitSignUp();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else {
      navigationService.maybePop();
    }
  }

  Future<void> submitSignUp() async {
    if (!step2FormKey.currentState!.validate()) return;

    setBusy(true);

    try {
      final List<BranchParam> branches = [
        BranchParam(
          name: mainBranchNameController.text.trim().isEmpty
              ? 'Main Branch'
              : mainBranchNameController.text.trim(),
          address: mainBranchAddressController.text.trim(),
          phone: mainBranchPhoneController.text.trim().isEmpty
              ? phoneController.text.trim()
              : mainBranchPhoneController.text.trim(),
          isMainBranch: true,
        ),
        ...additionalBranches.map(
          (b) => BranchParam(
            name: b.nameController.text.trim(),
            address: b.addressController.text.trim(),
            phone: b.phoneController.text.trim(),
            isMainBranch: false,
          ),
        ),
      ];

      BankDetailsParam? bankDetails;
      if (bankNameController.text.trim().isNotEmpty &&
          accountNumberController.text.trim().isNotEmpty) {
        bankDetails = BankDetailsParam(
          bankName: bankNameController.text.trim(),
          accountNumber: accountNumberController.text.trim(),
          accountName: accountNameController.text.trim().isNotEmpty
              ? accountNameController.text.trim()
              : businessNameController.text.trim(),
        );
      }

      final param = SignUpParam(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        businessName: businessNameController.text.trim(),
        phone: phoneController.text.trim(),
        branches: branches,
        bankDetails: bankDetails,
      );

      final response = await authRepo.register(param: param);

      if (response.success && response.data != null) {
        snackbarService.success(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Business and owner registered successfully!',
        );
        navigationService.pushAndRemoveUntil(const BottomNavigationView());
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Registration failed. Please check your information.',
        );
      }
    } catch (e) {
      snackbarService.error(
        message: 'An error occurred during registration. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    businessNameController.dispose();
    mainBranchNameController.dispose();
    mainBranchAddressController.dispose();
    mainBranchPhoneController.dispose();
    for (var b in additionalBranches) {
      b.dispose();
    }
    bankNameController.dispose();
    accountNumberController.dispose();
    accountNameController.dispose();
    super.dispose();
  }
}
