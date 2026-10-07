import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/emergency_types.dart';
import '../../../data/models/labels.dart';

typedef TypeOption = ({
  String label,
  IconData icon,
  bool selected,
  VoidCallback onTap,
});

/// What happened: an optional filter for Hospitals near you. Returns the
/// chosen type to the list; closing returns nothing.
class TypeFilterViewModel extends BaseViewModel {
  TypeFilterViewModel({required this.current, NavigationService? navigation})
    : _navigation = navigation ?? navigationService;

  final EmergencyType current;
  final NavigationService _navigation;

  static const title = 'What happened?';
  static const hint =
      'Optional. Pick one and we will put hospitals that can treat it first.';
  static const allTitle = 'All types';
  static const allSubtitle =
      'Every hospital near you, nearest and confirmed first';

  bool get allSelected => current == EmergencyType.skipped;

  List<TypeOption> get options => [
    for (final t in EmergencyTypes.picker)
      (
        label: t.label,
        icon: _icon(t),
        selected: t == current,
        onTap: () => choose(t),
      ),
  ];

  void choose(EmergencyType type) => _navigation.pop<EmergencyType>(type);

  void showAll() => choose(EmergencyType.skipped);

  void close() => _navigation.pop<EmergencyType>();

  static IconData _icon(EmergencyType t) => switch (t) {
    EmergencyType.roadAccident => Icons.car_crash_outlined,
    EmergencyType.severeBleeding => Icons.water_drop_outlined,
    EmergencyType.burns => Icons.local_fire_department_outlined,
    EmergencyType.chestPain => Icons.monitor_heart_outlined,
    EmergencyType.pregnancy => Icons.pregnant_woman_outlined,
    EmergencyType.child => Icons.child_care_outlined,
    EmergencyType.unconscious => Icons.airline_seat_flat_outlined,
    EmergencyType.breathingDifficulty => Icons.air_outlined,
    EmergencyType.other => Icons.help_outline,
    EmergencyType.skipped => Icons.list_outlined,
  };
}
