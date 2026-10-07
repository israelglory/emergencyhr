import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/auth_api.dart';
import '../auth_navigation.dart';

enum CreateAccountStep { email, code, details }

/// Email, then the emailed code, then name and password.
class CreateAccountViewModel extends BaseViewModel {
  CreateAccountViewModel({
    this.next,
    AuthApi? api,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? authApi,
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  final String? next;
  final AuthApi _api;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  CreateAccountStep _step = CreateAccountStep.email;
  UuidValue? _requestId;
  String? _token;
  Map<String, String> _errors = {};
  bool _hidePassword = true;

  static const title = 'Create an account';
  static const passwordHint =
      'At least 8 characters, with no spaces at the start or end.';

  CreateAccountStep get step => _step;
  String? errorFor(String field) => _errors[field];
  bool get hidePassword => _hidePassword;
  IconData get passwordIcon =>
      _hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  String get passwordToggleLabel =>
      _hidePassword ? 'Show password' : 'Hide password';

  String get heading => switch (_step) {
    CreateAccountStep.email => 'What is your email?',
    CreateAccountStep.code => 'Check your email',
    CreateAccountStep.details => 'Finish your account',
  };

  String get explainer => switch (_step) {
    CreateAccountStep.email =>
      'We will email you a code to confirm it is yours.',
    CreateAccountStep.code =>
      'We sent a code to ${emailController.text.trim()}. It may take a '
          'minute, and can land in spam.',
    CreateAccountStep.details =>
      'Add your name, used in family alerts, and choose a password. You can '
          'add a phone number later in your profile.',
  };

  String get primaryLabel => switch (_step) {
    CreateAccountStep.email => 'Send code',
    CreateAccountStep.code => 'Confirm code',
    CreateAccountStep.details => 'Create account',
  };

  bool get showBack => _step != CreateAccountStep.email;

  void togglePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  void onChanged(String _) {
    if (_errors.isEmpty) return;
    _errors = {};
    notifyListeners();
  }

  Future<void> continueStep() => switch (_step) {
    CreateAccountStep.email => _sendCode(),
    CreateAccountStep.code => _confirmCode(),
    CreateAccountStep.details => _finish(),
  };

  void back() {
    _errors = {};
    _step = _step == CreateAccountStep.details
        ? CreateAccountStep.code
        : CreateAccountStep.email;
    notifyListeners();
  }

  Future<void> resendCode() async {
    codeController.clear();
    await _sendCode();
  }

  Future<void> _sendCode() async {
    final email = emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      _fail('email', 'Enter a valid email address.');
      return;
    }
    final response = await runBusyFuture(_api.startRegistration(email));
    if (!response.success) {
      _handle(response.message!, response.field);
      return;
    }
    _requestId = response.data;
    _step = CreateAccountStep.code;
    notifyListeners();
  }

  Future<void> _confirmCode() async {
    final code = codeController.text.trim();
    if (code.isEmpty) {
      _fail('code', 'Enter the code from the email.');
      return;
    }
    final response = await runBusyFuture(
      _api.verifyRegistrationCode(_requestId!, code),
    );
    if (!response.success) {
      _handle(response.message!, response.field ?? 'code');
      return;
    }
    _token = response.data;
    _step = CreateAccountStep.details;
    notifyListeners();
  }

  Future<void> _finish() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      _fail('name', 'Enter your name.');
      return;
    }
    if (passwordController.text.length < 8) {
      _fail('password', passwordHint);
      return;
    }
    final response = await runBusyFuture(
      _api.finishRegistration(_token!, passwordController.text),
    );
    if (!response.success) {
      _handle(response.message!, response.field ?? 'password');
      return;
    }
    await _api.updateName(name);
    _snackbar.success(message: 'Welcome to Emergencyhr');
    await openAfterSignIn(
      session: _session,
      navigation: _navigation,
      next: next,
    );
  }

  void _fail(String field, String message) {
    _errors = {field: message};
    notifyListeners();
  }

  void _handle(String message, String? field) {
    if (field == null) {
      _snackbar.error(message: message);
    } else {
      _fail(field, message);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
