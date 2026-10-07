import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/auth_api.dart';

enum ResetStep { email, code, password }

/// Email, then the emailed code, then a new password.
class ResetPasswordViewModel extends BaseViewModel {
  ResetPasswordViewModel({
    String? email,
    AuthApi? api,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? authApi,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService {
    emailController.text = email ?? '';
  }

  final AuthApi _api;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();

  ResetStep _step = ResetStep.email;
  UuidValue? _requestId;
  String? _token;
  Map<String, String> _errors = {};

  static const title = 'Reset password';
  static const passwordHint =
      'At least 8 characters, with no spaces at the start or end.';

  ResetStep get step => _step;
  String? errorFor(String field) => _errors[field];

  String get heading => switch (_step) {
    ResetStep.email => 'Forgot your password?',
    ResetStep.code => 'Check your email',
    ResetStep.password => 'Choose a new password',
  };

  String get explainer => switch (_step) {
    ResetStep.email => 'Enter your email and we will send you a code.',
    ResetStep.code =>
      'If an account uses ${emailController.text.trim()}, we sent it a code.',
    ResetStep.password => passwordHint,
  };

  String get primaryLabel => switch (_step) {
    ResetStep.email => 'Send code',
    ResetStep.code => 'Confirm code',
    ResetStep.password => 'Save new password',
  };

  void onChanged(String _) {
    if (_errors.isEmpty) return;
    _errors = {};
    notifyListeners();
  }

  Future<void> continueStep() => switch (_step) {
    ResetStep.email => _sendCode(),
    ResetStep.code => _confirmCode(),
    ResetStep.password => _save(),
  };

  Future<void> _sendCode() async {
    final email = emailController.text.trim();
    if (!email.contains('@')) {
      _fail('email', 'Enter your email address.');
      return;
    }
    final response = await runBusyFuture(_api.startPasswordReset(email));
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    _requestId = response.data;
    _step = ResetStep.code;
    notifyListeners();
  }

  Future<void> _confirmCode() async {
    final response = await runBusyFuture(
      _api.verifyPasswordResetCode(_requestId!, codeController.text),
    );
    if (!response.success) {
      _fail('code', response.message!);
      return;
    }
    _token = response.data;
    _step = ResetStep.password;
    notifyListeners();
  }

  Future<void> _save() async {
    if (passwordController.text.length < 8) {
      _fail('password', passwordHint);
      return;
    }
    final response = await runBusyFuture(
      _api.finishPasswordReset(_token!, passwordController.text),
    );
    if (!response.success) {
      _fail('password', response.message!);
      return;
    }
    _snackbar.success(message: 'Password changed. Sign in with it now.');
    await _navigation.replaceWith<void>(AppRoutes.signIn);
  }

  void _fail(String field, String message) {
    _errors = {field: message};
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
