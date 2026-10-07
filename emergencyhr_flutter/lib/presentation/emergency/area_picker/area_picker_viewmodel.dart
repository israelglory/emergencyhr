import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/pilot_areas.dart';

typedef AreaRow = ({String name, String? description, VoidCallback onTap});

/// Choose your area: when location is off, or to search somewhere else.
/// Returns the chosen area to Hospitals near you. Never a dead end.
class AreaPickerViewModel extends BaseViewModel {
  AreaPickerViewModel({NavigationService? navigation, PhoneCallService? calls})
    : _navigation = navigation ?? navigationService,
      _calls = calls ?? phoneCallService;

  final NavigationService _navigation;
  final PhoneCallService _calls;

  final searchController = TextEditingController();

  static const title = 'Emergency';
  static const heading = 'Choose your area';
  static const hint =
      'We could not use your location. Pick the area you are in and we will '
      'show the nearest hospitals.';
  static const noMatchHint =
      'No match for your search? Pick the closest area. We still list every '
      'pilot area.';

  List<PilotArea> get _matches {
    final q = searchController.text.trim().toLowerCase();
    return [
      for (final a in PilotAreas.all)
        if (q.isEmpty ||
            a.name.toLowerCase().contains(q) ||
            (a.description ?? '').toLowerCase().contains(q))
          a,
    ];
  }

  /// Falls back to every area so there is always something to pick.
  List<AreaRow> get areas => [
    for (final a in _matches.isEmpty ? PilotAreas.all : _matches)
      (name: a.name, description: a.description, onTap: () => choose(a)),
  ];

  void onSearchChanged(String _) => notifyListeners();

  void choose(PilotArea area) => _navigation.pop<PilotArea>(area);

  Future<void> call112() => _calls.callNumber(
    number: '112',
    title: 'Call 112',
    message: 'The national emergency number.',
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
