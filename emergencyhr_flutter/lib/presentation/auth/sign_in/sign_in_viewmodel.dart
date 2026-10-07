import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/auth_api.dart';
import '../auth_navigation.dart';

class SignInViewModel extends BaseViewModel {
  SignInViewModel({
    this.next,
    AuthApi? api,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
    EmergencySessionService? emergency,
    LocationService? location,
  }) : _emergencyOverride = emergency,
       _locationOverride = location,
       _api = api ?? authApi,
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  /// Route to open after sign-in, e.g. from a guarded page.
  final String? next;
  final AuthApi _api;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;
  final EmergencySessionService? _emergencyOverride;
  final LocationService? _locationOverride;
  EmergencySessionService get _emergency =>
      _emergencyOverride ?? emergencySession;
  LocationService get _location => _locationOverride ?? locationService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, String> _errors = {};
  bool _hidePassword = true;

  static const title = 'Sign in';
  static const heading = 'Sign in to Emergencyhr';
  static const explainer = 'You do not need an account to use Emergency.';
  static const newHere = 'New to Emergencyhr?';

  String? errorFor(String field) => _errors[field];
  bool get hidePassword => _hidePassword;
  IconData get passwordIcon =>
      _hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  String get passwordToggleLabel =>
      _hidePassword ? 'Show password' : 'Hide password';

  void togglePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  void onChanged(String _) {
    if (_errors.isEmpty) return;
    _errors = {};
    notifyListeners();
  }

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final errors = <String, String>{};
    if (!email.contains('@')) errors['email'] = 'Enter your email address.';
    if (passwordController.text.isEmpty) {
      errors['password'] = 'Enter your password.';
    }
    _errors = errors;
    if (errors.isNotEmpty) {
      notifyListeners();
      return;
    }
    final response = await runBusyFuture(
      _api.signIn(email, passwordController.text),
    );
    if (!response.success) {
      if (response.field != null) {
        _errors = {response.field!: response.message!};
        notifyListeners();
      } else {
        _snackbar.error(message: response.message!);
      }
      return;
    }
    await openAfterSignIn(
      session: _session,
      navigation: _navigation,
      next: next,
    );
  }

  /// Straight to Hospitals near you, no account needed.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }

  void createAccount() => _navigation.pushNamed<void>(
    AppRoutes.withNext(AppRoutes.createAccount, next),
  );

  void forgotPassword() => _navigation.pushNamed<void>(
    AppRoutes.resetPassword,
    args: emailController.text.trim(),
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
