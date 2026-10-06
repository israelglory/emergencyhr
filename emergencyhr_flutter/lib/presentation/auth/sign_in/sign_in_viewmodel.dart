import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/auth_api.dart';
import '../../../data/models/route_args.dart';

class SignInViewModel extends BaseViewModel {
  SignInViewModel({
    this.next,
    AuthApi? api,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? authApi,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  /// Route to open after sign-in, e.g. from a guarded page.
  final String? next;
  final AuthApi _api;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  final phoneController = TextEditingController();

  String? _phoneError;
  String? get phoneError => _phoneError;

  static const title = 'Sign in';
  static const heading = 'Enter your phone number';
  static const explainer =
      'We will text you a 6-digit code. You do not need an account to use '
      'Emergency.';

  void onPhoneChanged(String _) {
    if (_phoneError == null) return;
    _phoneError = null;
    notifyListeners();
  }

  Future<void> sendCode() async {
    final phone = phoneController.text.trim();
    if (phone.replaceAll(RegExp(r'\D'), '').length < 10) {
      _phoneError = 'Enter a valid phone number, for example 0803 123 4567.';
      notifyListeners();
      return;
    }
    final response = await runBusyFuture(_api.requestCode(phone));
    if (response.success) {
      await _navigation.pushNamed<void>(
        AppRoutes.verifyCode,
        args: VerifyCodeArgs(request: response.data!, next: next),
      );
    } else if (response.field == 'phone') {
      _phoneError = response.message;
      notifyListeners();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
