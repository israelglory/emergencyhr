import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';

/// Debug-only catalogue of every shared widget and state.
class DesignViewModel extends BaseViewModel {
  DesignViewModel({SnackbarService? snackbar})
    : _snackbar = snackbar ?? snackbarService;

  final SnackbarService _snackbar;

  bool _dark = false;
  bool get dark => _dark;
  ThemeData get theme => _dark ? AppTheme.darkTheme : AppTheme.lightTheme;
  String get themeLabel => _dark ? 'Dark theme' : 'Light theme';

  int _beds = 3;
  int get beds => _beds;
  bool _accepting = true;
  bool get accepting => _accepting;
  String get acceptingLabel => _accepting ? 'Accepting' : 'Paused';
  final fieldController = TextEditingController();

  static const sampleMetrics = [
    (label: 'ER beds', value: '3'),
    (label: 'ICU beds', value: '1'),
    (label: 'Doctor', value: 'On duty'),
    (label: 'Deposit', value: 'Required'),
  ];

  static const tones = [
    ('Accepting emergencies. Confirmed 4 min ago.', StatusTone.positive),
    ('Last confirmed 52 min ago. Call ahead.', StatusTone.warning),
    ('Unverified. Call before going.', StatusTone.neutral),
    ('Not accepting new emergencies', StatusTone.neutral),
    ('Flagged for review', StatusTone.critical),
  ];

  void toggleTheme(bool value) {
    _dark = value;
    notifyListeners();
  }

  void increment() {
    _beds++;
    notifyListeners();
  }

  void decrement() {
    if (_beds == 0) return;
    _beds--;
    notifyListeners();
  }

  void setAccepting(bool value) {
    _accepting = value;
    notifyListeners();
  }

  void tap() => _snackbar.info(message: 'Tapped');

  @override
  void dispose() {
    fieldController.dispose();
    super.dispose();
  }
}
