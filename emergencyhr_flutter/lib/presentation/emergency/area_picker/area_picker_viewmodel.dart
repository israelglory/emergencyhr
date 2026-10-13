import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/pilot_areas.dart';
import '../../../data/models/route_args.dart';

typedef AreaRow = ({String name, String? description, VoidCallback onTap});

/// Returned by Choose your area when the person wants to try their own
/// location again.
class UseMyLocation {
  const UseMyLocation();
}

/// Choose your area: when location is off, or to search somewhere else.
/// Returns the chosen [PilotArea], or [UseMyLocation], to Hospitals near
/// you. Never a dead end.
class AreaPickerViewModel extends BaseViewModel {
  AreaPickerViewModel({
    this.args = const AreaPickerArgs(),
    NavigationService? navigation,
    PhoneCallService? calls,
    LocationService? location,
  }) : _navigation = navigation ?? navigationService,
       _calls = calls ?? phoneCallService,
       _isWeb = (location ?? locationService).isWeb;

  final AreaPickerArgs args;
  final NavigationService _navigation;
  final PhoneCallService _calls;
  final bool _isWeb;

  final searchController = TextEditingController();

  static const title = 'Emergency';
  static const heading = 'Choose your area';
  static const _pick =
      'Pick the area you are in and we will show the nearest hospitals.';

  /// Why the location failed and how to fix it, in this person's setting.
  String get hint => switch (args.failure) {
    LocationDenied() when _isWeb =>
      'Location is blocked for this site. To allow it, click the icon at the '
          'left of the web address, turn on Location, then tap Use my '
          'location. Or pick your area below.',
    LocationDenied() =>
      'Location is off for EmergencyHr. Turn it on in your phone settings, '
          'then tap Use my location. Or pick your area below.',
    LocationUnavailable() when _isWeb =>
      'Your browser could not find your location. Check that location is on '
          'for your browser (on a Mac: System Settings, Privacy & Security, '
          'Location Services), then tap Use my location. Or pick your area '
          'below.',
    LocationUnavailable() =>
      'We could not find your location. Check that location is on, then tap '
          'Use my location. Or pick your area below.',
    _ => _pick,
  };

  static const useMyLocationLabel = 'Use my location';
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

  void choose(PilotArea area) => _navigation.pop<Object>(area);

  void useMyLocation() => _navigation.pop<Object>(const UseMyLocation());

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
