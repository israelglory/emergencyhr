import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/auth_api.dart';
import '../../../data/models/route_args.dart';

class VerifyCodeViewModel extends BaseViewModel {
  VerifyCodeViewModel({
    required this.args,
    AuthApi? api,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? authApi,
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  /// Null when the page was opened directly (e.g. browser refresh).
  final VerifyCodeArgs? args;
  final AuthApi _api;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  final codeController = TextEditingController();
  Timer? _ticker;
  late DateTime _resendAt = args?.request.resendAvailableAt ?? DateTime.now();
  late String _phone = args?.request.phone ?? '';

  String? _codeError;
  String? get codeError => _codeError;

  static const heading = 'Enter the code';

  String get sentToLabel =>
      'We sent a 6-digit code to ${Formatters.phone(_phone)}. '
      'It expires in 5 minutes.';

  int get _secondsLeft {
    final left = _resendAt.difference(DateTime.now().toUtc()).inSeconds;
    return left < 0 ? 0 : left;
  }

  bool get canResend => _secondsLeft == 0 && !busy(_resendKey);
  VoidCallback? get onResend => canResend ? resend : null;
  String get resendLabel =>
      canResend ? 'Resend code' : 'Resend code in $_secondsLeft s';

  static const _resendKey = 'resend';

  void onReady() {
    if (args == null) {
      _navigation.replaceWith<void>(AppRoutes.signIn);
      return;
    }
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft >= 0) notifyListeners();
    });
  }

  void onCodeChanged(String value) {
    if (_codeError != null) {
      _codeError = null;
      notifyListeners();
    }
    if (value.length == 6 && !isBusy) verify();
  }

  Future<void> verify() async {
    final code = codeController.text.trim();
    if (code.length != 6) {
      _codeError = 'Enter all 6 digits.';
      notifyListeners();
      return;
    }
    final response = await runBusyFuture(_api.verifyCode(_phone, code));
    if (!response.success) {
      _codeError = response.message;
      if (response.errorCode == AppErrorCode.otpInvalid) codeController.clear();
      notifyListeners();
      return;
    }
    await runBusyFuture(_session.refresh());
    final destination =
        args?.next ?? AppRoutes.forShell(_session.preferredShell);
    await _navigation.clearStackAndShow<void>(destination);
  }

  Future<void> resend() async {
    if (!canResend) return;
    final response = await runBusyFuture(
      _api.requestCode(_phone),
      busyObject: _resendKey,
    );
    if (response.success) {
      _resendAt = response.data!.resendAvailableAt;
      _phone = response.data!.phone;
      codeController.clear();
      _snackbar.success(message: 'New code sent');
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    codeController.dispose();
    super.dispose();
  }
}
