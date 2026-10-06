import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/emergency_types.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/route_args.dart';

typedef TypeOption = ({String label, IconData icon, EmergencyType type});

enum LocationState { finding, found, unavailable }

/// Optional emergency type, picked while the location is found.
class EmergencyStartViewModel extends BaseViewModel {
  EmergencyStartViewModel({
    this.presetType,
    EmergencySessionService? emergency,
    LocationService? location,
    NavigationService? navigation,
    PhoneCallService? calls,
  }) : _emergency = emergency ?? emergencySession,
       _location = location ?? locationService,
       _navigation = navigation ?? navigationService,
       _calls = calls ?? phoneCallService;

  /// Set when another screen already knows the type (Health Assistant).
  final EmergencyType? presetType;
  final EmergencySessionService _emergency;
  final LocationService _location;
  final NavigationService _navigation;
  final PhoneCallService _calls;

  LocationState _locationState = LocationState.finding;
  LocationResult? _result;
  bool _waitingToContinue = false;

  static const title = 'Emergency';
  static const heading = 'What happened?';
  static const hint =
      'Optional. It helps us pick a hospital that can treat it.';

  bool get isWaiting => _waitingToContinue;

  String get locationLabel => switch (_locationState) {
    LocationState.finding => 'Finding your location',
    LocationState.found => 'Location found',
    LocationState.unavailable =>
      'Location is off. You will choose your area next.',
  };

  StatusTone get locationTone => switch (_locationState) {
    LocationState.finding => StatusTone.neutral,
    LocationState.found => StatusTone.positive,
    LocationState.unavailable => StatusTone.warning,
  };

  IconData get locationIcon => switch (_locationState) {
    LocationState.finding => Icons.location_searching,
    LocationState.found => Icons.my_location,
    LocationState.unavailable => Icons.location_off_outlined,
  };

  List<TypeOption> get options => [
    for (final t in EmergencyTypes.picker)
      (label: t.label, icon: _icon(t), type: t),
  ];

  Future<void> onReady() async {
    final pending = _emergency.pendingLocation ?? _beginFresh();
    final result = await pending;
    _result = result is LocationResult ? result : const LocationUnavailable();
    _locationState = _result is LocationFound
        ? LocationState.found
        : LocationState.unavailable;
    notifyListeners();
    if (presetType != null) await choose(presetType!);
  }

  Future<Object?> _beginFresh() {
    final pending = _location.current();
    _emergency.begin(pending);
    return pending;
  }

  Future<void> skip() => choose(EmergencyType.skipped);

  Future<void> choose(EmergencyType type) async {
    _emergency.setType(type);
    if (_result == null) {
      _waitingToContinue = true;
      notifyListeners();
      final result = await _emergency.pendingLocation;
      _result = result is LocationResult ? result : const LocationUnavailable();
      _waitingToContinue = false;
      notifyListeners();
    }
    switch (_result) {
      case LocationFound(:final lat, :final lng):
        await _navigation.pushNamed<void>(
          AppRoutes.emergencyResults,
          args: EmergencyResultsArgs(lat: lat, lng: lng, type: type),
        );
      default:
        await _navigation.pushNamed<void>(AppRoutes.emergencyArea, args: type);
    }
  }

  void chooseArea() => _navigation.pushNamed<void>(
    AppRoutes.emergencyArea,
    args: EmergencyType.skipped,
  );

  Future<void> call112() => _calls.callNumber(
    number: '112',
    title: 'Call 112',
    message: 'The national emergency number.',
  );

  static IconData _icon(EmergencyType t) => switch (t) {
    EmergencyType.roadAccident => Icons.car_crash_outlined,
    EmergencyType.severeBleeding => Icons.bloodtype_outlined,
    EmergencyType.burns => Icons.local_fire_department_outlined,
    EmergencyType.chestPain => Icons.monitor_heart_outlined,
    EmergencyType.pregnancy => Icons.pregnant_woman_outlined,
    EmergencyType.child => Icons.child_care_outlined,
    EmergencyType.unconscious => Icons.airline_seat_flat_outlined,
    EmergencyType.breathingDifficulty => Icons.air_outlined,
    EmergencyType.other => Icons.help_outline,
    EmergencyType.skipped => Icons.skip_next_outlined,
  };
}
