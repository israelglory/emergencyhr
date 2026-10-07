import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/pilot_areas.dart';

class AgentFormViewModel extends BaseViewModel {
  AgentFormViewModel({
    this.userId,
    List<String> areas = const [],
    AdminApi? api,
    BottomSheetService? sheets,
    SnackbarService? snackbar,
  }) : _api = api ?? adminApi,
       _sheets = sheets ?? bottomSheetService,
       _snackbar = snackbar ?? snackbarService {
    _areas.addAll(areas);
  }

  /// Null when adding a new agent.
  final int? userId;
  final AdminApi _api;
  final BottomSheetService _sheets;
  final SnackbarService _snackbar;

  final emailController = TextEditingController();
  final Set<String> _areas = {};

  bool get isNew => userId == null;
  static const addExplainer =
      'They need an EmergencyHr account first. Ask them to create one, then '
      'enter its email here.';
  String get title => isNew ? 'Add field agent' : 'Agent areas';

  List<ChipItem<String>> get areaOptions => [
    for (final a in PilotAreas.names)
      (label: a, value: a, selected: _areas.contains(a)),
  ];

  void toggleArea(String area) {
    _areas.contains(area) ? _areas.remove(area) : _areas.add(area);
    notifyListeners();
  }

  Future<void> save() async {
    final response = isNew
        ? await runBusyFuture(
            _api.addAgent(emailController.text.trim(), _areas.toList()),
          )
        : await runBusyFuture(_api.setAgentAreas(userId!, _areas.toList()));
    if (response.success) {
      _sheets.dismiss<bool>(true);
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
