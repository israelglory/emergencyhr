import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/facility_api.dart';
import '../../../data/api/status_api.dart';
import '../../../data/models/freshness.dart';
import '../../../data/models/labels.dart';

/// The desk's status screen. A full update must take under 30 seconds and
/// work one-handed.
class StatusViewModel extends BaseViewModel {
  StatusViewModel({
    required this.facilityId,
    this.startInPractice = false,
    StatusApi? statusApi,
    FacilityApi? facilities,
    SnackbarService? snackbar,
    DateTime Function()? now,
  }) : _api = statusApi ?? locator<StatusApi>(),
       _facilities = facilities ?? locator<FacilityApi>(),
       _snackbar = snackbar ?? snackbarService,
       _now = now ?? (() => DateTime.now().toUtc());

  final int facilityId;
  final bool startInPractice;
  final StatusApi _api;
  final FacilityApi _facilities;
  final SnackbarService _snackbar;
  final DateTime Function() _now;
  Timer? _ticker;

  FacilityDetail? _detail;
  FacilityStatus? _saved;

  bool _accepting = true;
  int _erBeds = 0;
  int _icuBeds = 0;
  bool _doctorOnDuty = true;
  bool _depositRequired = false;
  bool _practice = false;

  static const _saveKey = 'save';
  static const _confirmKey = 'confirm';

  // Load state
  bool get isLoading => _detail == null && !hasError;
  String? get errorMessage => modelError?.toString();

  // Draft values
  bool get accepting => _accepting;
  int get erBeds => _erBeds;
  int get icuBeds => _icuBeds;
  bool get doctorOnDuty => _doctorOnDuty;
  bool get depositRequired => _depositRequired;
  String get doctorLabel => Formatters.yesNo(_doctorOnDuty);
  String get depositLabel => Formatters.yesNo(_depositRequired);

  bool get isPractice => _practice;
  bool get isSaving => busy(_saveKey);
  bool get isConfirming => busy(_confirmKey);

  String get facilityName => _detail?.facility.name ?? '';

  bool get _isLive => _detail?.facility.onboardingStage == OnboardingStage.live;
  bool get _trainingDone => _detail?.facility.trainingCompletedAt != null;

  /// Not public yet: explain why.
  bool get showNotLiveNotice => !_practice && _detail != null && !_isLive;
  String get notLiveNotice =>
      'Not public yet (${_detail?.facility.onboardingStage.label}). Your '
      'updates are saved and appear once the hospital is verified and live.';

  bool get showPracticePrompt =>
      !_practice && _detail != null && !_trainingDone;
  static const practicePrompt =
      'Do one practice update first. The public never sees practice updates.';
  static const practiceNotice = 'Practice mode. The public will not see this.';

  String get ageLabel => _practice
      ? 'Practice update'
      : Freshness.staffAge(_saved?.updatedAt, _now());

  StatusTone get ageTone {
    final updated = _saved?.updatedAt;
    if (_practice || updated == null) return StatusTone.neutral;
    final minutes = _now().difference(updated).inMinutes;
    if (minutes > Freshness.staleMinutes) return StatusTone.critical;
    if (minutes > Freshness.freshMinutes) return StatusTone.warning;
    return StatusTone.positive;
  }

  bool get hasChanges {
    final s = _saved;
    if (s == null) return true;
    return s.accepting != _accepting ||
        s.erBedsFree != _erBeds ||
        s.icuBedsFree != _icuBeds ||
        s.doctorOnDuty != _doctorOnDuty ||
        s.depositRequired != _depositRequired;
  }

  String get saveLabel => _practice ? 'Send practice update' : 'Save update';

  /// "Still accurate" refreshes the time without changes.
  bool get canConfirm => !_practice && _saved != null && !hasChanges;
  VoidCallback? get onConfirm => canConfirm ? confirmStillAccurate : null;

  VoidCallback? get decrementEr =>
      _erBeds > 0 ? () => _setEr(_erBeds - 1) : null;
  VoidCallback get incrementEr =>
      () => _setEr(_erBeds + 1);
  VoidCallback? get decrementIcu =>
      _icuBeds > 0 ? () => _setIcu(_icuBeds - 1) : null;
  VoidCallback get incrementIcu =>
      () => _setIcu(_icuBeds + 1);

  Future<void> onReady() async {
    _practice = startInPractice;
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      notifyListeners();
    });
    await load();
  }

  Future<void> load() async {
    setError(null);
    notifyListeners();
    final detail = await runBusyFuture(_facilities.detail(facilityId));
    if (!detail.success) {
      setError(detail.message);
      notifyListeners();
      return;
    }
    _detail = detail.data;
    _applySaved(detail.data!.status);
    notifyListeners();
  }

  void setAccepting(bool value) {
    _accepting = value;
    notifyListeners();
  }

  void setDoctorOnDuty(bool value) {
    _doctorOnDuty = value;
    notifyListeners();
  }

  void setDepositRequired(bool value) {
    _depositRequired = value;
    notifyListeners();
  }

  void startPractice() {
    _practice = true;
    notifyListeners();
  }

  void stopPractice() {
    _practice = false;
    _applySaved(_saved);
    notifyListeners();
  }

  Future<void> save() async {
    final input = StatusInput(
      accepting: _accepting,
      erBedsFree: _erBeds,
      icuBedsFree: _icuBeds,
      doctorOnDuty: _doctorOnDuty,
      depositRequired: _depositRequired,
    );
    if (_practice) {
      final response = await runBusyFuture(
        _api.practice(facilityId, input),
        busyObject: _saveKey,
      );
      if (!response.success) {
        _snackbar.error(message: response.message!);
        return;
      }
      _snackbar.success(message: 'Practice done. Training is recorded.');
      _practice = false;
      await load();
      return;
    }
    final response = await runBusyFuture(
      _api.update(facilityId, input),
      busyObject: _saveKey,
    );
    if (response.success) {
      _applySaved(response.data);
      _snackbar.success(message: 'Status updated');
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  Future<void> confirmStillAccurate() async {
    final response = await runBusyFuture(
      _api.confirm(facilityId),
      busyObject: _confirmKey,
    );
    if (response.success) {
      _applySaved(response.data);
      _snackbar.success(message: 'Confirmed. Thank you.');
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  void _setEr(int value) {
    _erBeds = value;
    notifyListeners();
  }

  void _setIcu(int value) {
    _icuBeds = value;
    notifyListeners();
  }

  void _applySaved(FacilityStatus? status) {
    _saved = status;
    if (status == null) return;
    _accepting = status.accepting;
    _erBeds = status.erBedsFree;
    _icuBeds = status.icuBedsFree;
    _doctorOnDuty = status.doctorOnDuty;
    _depositRequired = status.depositRequired;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
