import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/pilot_areas.dart';
import '../../../data/models/route_args.dart';

typedef AreaRow = ({String name, String? description, PilotArea area});

/// When location is denied or unavailable. Never a dead end.
class AreaPickerViewModel extends BaseViewModel {
  AreaPickerViewModel({
    required this.type,
    NavigationService? navigation,
  }) : _navigation = navigation ?? navigationService;

  final EmergencyType type;
  final NavigationService _navigation;

  final searchController = TextEditingController();

  static const title = 'Choose your area';
  static const hint =
      'We could not use your location. Pick the area you are in and we will '
      'show the nearest hospitals.';

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
    for (final a in noMatches ? PilotAreas.all : _matches)
      (name: a.name, description: a.description, area: a),
  ];

  bool get noMatches => _matches.isEmpty;

  void onSearchChanged(String _) => notifyListeners();

  void choose(PilotArea area) => _navigation.replaceWith<void>(
    AppRoutes.emergencyResults,
    args: EmergencyResultsArgs(
      lat: area.lat,
      lng: area.lng,
      type: type,
      area: area.name,
    ),
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
