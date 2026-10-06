import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/emergency_api.dart';

/// "Status was wrong" for the hospital the user acted on.
class ReportSheetViewModel extends BaseViewModel {
  ReportSheetViewModel({
    required this.facilityId,
    required this.facilityName,
    EmergencyApi? api,
    EmergencySessionService? emergency,
    SnackbarService? snackbar,
    BottomSheetService? sheets,
  }) : _api = api ?? emergencyApi,
       _emergency = emergency ?? emergencySession,
       _snackbar = snackbar ?? snackbarService,
       _sheets = sheets ?? bottomSheetService;

  final int facilityId;
  final String facilityName;
  final EmergencyApi _api;
  final EmergencySessionService _emergency;
  final SnackbarService _snackbar;
  final BottomSheetService _sheets;

  static const reasons = [
    'Not accepting emergencies',
    'No beds',
    'No doctor on duty',
    'Phone not answered',
    'Asked for a deposit',
    'Something else',
  ];

  String? _reason;
  final detailsController = TextEditingController();

  String get title => 'What was wrong at $facilityName?';
  static const hint =
      'Reports help keep statuses honest. Three reports in a day send the '
      'hospital for review.';

  List<ChipItem<String>> get options => [
    for (final r in reasons) (label: r, value: r, selected: r == _reason),
  ];

  void select(String reason) {
    _reason = reason;
    notifyListeners();
  }

  VoidCallback? get onSubmit => _reason == null ? null : submit;

  Future<void> submit() async {
    final s = _emergency.search;
    if (s == null || _reason == null) return;
    final details = detailsController.text.trim();
    final response = await runBusyFuture(
      _api.reportWrongStatus(
        s.sessionId,
        s.accessToken,
        facilityId,
        details.isEmpty ? _reason! : '$_reason: $details',
      ),
    );
    if (response.success) {
      _snackbar.success(message: 'Thank you. We have recorded your report.');
      _sheets.dismiss<void>();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  @override
  void dispose() {
    detailsController.dispose();
    super.dispose();
  }
}
