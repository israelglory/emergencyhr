import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/onboarding_api.dart';
import '../../../data/models/pilot_areas.dart';

/// The short "we are interested" form. No account needed.
class JoinRequestViewModel extends BaseViewModel {
  JoinRequestViewModel({
    OnboardingApi? api,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? locator<OnboardingApi>(),
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  final OnboardingApi _api;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  final hospitalController = TextEditingController();
  final contactController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  String _area = PilotAreas.names.first;
  Map<String, String> _errors = {};
  bool _sent = false;

  static const title = 'Join request';
  static const intro =
      'Leave your details and an Emergencyhr field agent will contact you to '
      'arrange a visit.';
  static const sentTitle = 'Request sent';
  static const sentMessage = 'Thank you. A field agent will call you soon.';

  bool get sent => _sent;
  String get area => _area;
  List<String> get areaOptions => PilotAreas.names;
  String? errorFor(String field) => _errors[field];

  void setArea(String? value) {
    if (value == null) return;
    _area = value;
    notifyListeners();
  }

  Future<void> submit() async {
    final errors = <String, String>{};
    if (hospitalController.text.trim().length < 3) {
      errors['hospitalName'] = 'Enter the hospital name.';
    }
    if (contactController.text.trim().isEmpty) {
      errors['contactName'] = 'Enter your name.';
    }
    if (phoneController.text.replaceAll(RegExp(r'\D'), '').length < 10) {
      errors['phone'] = 'Enter a valid phone number.';
    }
    _errors = errors;
    if (errors.isNotEmpty) {
      notifyListeners();
      return;
    }
    final message = messageController.text.trim();
    final response = await runBusyFuture(
      _api.submitJoinRequest(
        hospitalName: hospitalController.text.trim(),
        contactName: contactController.text.trim(),
        phone: phoneController.text.trim(),
        area: _area,
        message: message.isEmpty ? null : message,
      ),
    );
    if (response.success) {
      _sent = true;
    } else if (response.field != null) {
      _errors = {response.field!: response.message!};
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  void done() => _navigation.clearStackAndShow<void>(AppRoutes.home);

  @override
  void dispose() {
    hospitalController.dispose();
    contactController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
