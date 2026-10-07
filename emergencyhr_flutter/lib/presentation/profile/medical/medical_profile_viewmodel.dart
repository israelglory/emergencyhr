import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/profile_api.dart';

/// Optional medical details, saved only after an explicit consent step.
class MedicalProfileViewModel extends BaseViewModel {
  MedicalProfileViewModel({
    ProfileApi? api,
    SnackbarService? snackbar,
    DialogService? dialogs,
    NavigationService? navigation,
  }) : _api = api ?? profileApi,
       _snackbar = snackbar ?? snackbarService,
       _dialogs = dialogs ?? dialogService,
       _navigation = navigation ?? navigationService;

  final ProfileApi _api;
  final SnackbarService _snackbar;
  final DialogService _dialogs;
  final NavigationService _navigation;

  final bloodGroupController = TextEditingController();
  final allergiesController = TextEditingController();
  final conditionsController = TextEditingController();
  final medicationsController = TextEditingController();

  MedicalProfileData? _data;
  bool _consentTicked = false;

  static const title = 'Medical details';
  static const consentText =
      'I agree that Emergencyhr stores these health details, encrypted. I can '
      'delete them at any time.';
  static const explainer =
      'Optional. These details are not shared with hospitals or family '
      'automatically.';

  bool get isLoading => _data == null && !hasError;
  String? get errorMessage => modelError?.toString();
  bool get hasSaved => _data?.consentAt != null;
  bool get consentTicked => _consentTicked;
  String get consentLabel => hasSaved
      ? 'Consent given ${Formatters.date(_data!.consentAt!)}'
      : 'Consent needed before saving';
  VoidCallback? get onSave => _consentTicked ? save : null;

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.medical());
    if (!response.success) {
      setError(response.message);
      notifyListeners();
      return;
    }
    _data = response.data;
    bloodGroupController.text = _data!.bloodGroup ?? '';
    allergiesController.text = _data!.allergies ?? '';
    conditionsController.text = _data!.conditions ?? '';
    medicationsController.text = _data!.medications ?? '';
    _consentTicked = hasSaved;
    notifyListeners();
  }

  void setConsent(bool? value) {
    _consentTicked = value ?? false;
    notifyListeners();
  }

  Future<void> save() async {
    String? v(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();
    final response = await runBusyFuture(
      _api.saveMedical(
        MedicalProfileData(
          bloodGroup: v(bloodGroupController),
          allergies: v(allergiesController),
          conditions: v(conditionsController),
          medications: v(medicationsController),
        ),
        consent: _consentTicked,
      ),
    );
    if (response.success) {
      _data = response.data;
      _snackbar.success(message: 'Medical details saved');
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  Future<void> delete() async {
    final ok = await _dialogs.confirm(
      title: 'Delete medical details?',
      message: 'This removes them from Emergencyhr permanently.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok) return;
    final response = await runBusyFuture(_api.deleteMedical());
    if (response.success) {
      _snackbar.success(message: 'Medical details deleted');
      _navigation.pop<void>();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  @override
  void dispose() {
    bloodGroupController.dispose();
    allergiesController.dispose();
    conditionsController.dispose();
    medicationsController.dispose();
    super.dispose();
  }
}
