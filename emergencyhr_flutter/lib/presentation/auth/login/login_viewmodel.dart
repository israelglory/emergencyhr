import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:emergencyhr_flutter/presentation/auth/signup/signup_view.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setBusy(true);

    try {
      final param = LoginParam(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final response = await authRepo.login(param: param);

      if (response.success && response.data != null) {
        snackbarService.success(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Login successful',
        );
        navigationService.pushAndRemoveUntil(const BottomNavigationView());
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Login failed. Please check your credentials.',
        );
      }
    } catch (e) {
      snackbarService.error(
        message: 'An error occurred during login. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  void navigateToSignUp() {
    navigationService.push(const SignUpView());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
