import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

typedef FirstAidRow = ({String title, String summary, VoidCallback onTap});

class FirstAidListViewModel extends BaseViewModel {
  FirstAidListViewModel({
    FirstAidService? firstAid,
    NavigationService? navigation,
  }) : _firstAid = firstAid ?? firstAidService,
       _navigation = navigation ?? navigationService;

  final FirstAidService _firstAid;
  final NavigationService _navigation;

  static const title = 'First aid';
  static const disclaimer =
      'General first-aid guidance only. It does not replace a doctor. If in '
      'doubt, call 112.';

  /// Cards in the order of the design: the nine emergency types.
  List<FirstAidRow> get rows {
    final byType = {for (final c in _firstAid.cards) c.type: c};
    return [
      for (final t in _order)
        if (byType[t] case final c?)
          (title: c.title, summary: c.summary, onTap: () => open(c.type)),
    ];
  }

  static const _order = [
    EmergencyType.roadAccident,
    EmergencyType.severeBleeding,
    EmergencyType.burns,
    EmergencyType.chestPain,
    EmergencyType.pregnancy,
    EmergencyType.child,
    EmergencyType.unconscious,
    EmergencyType.breathingDifficulty,
    EmergencyType.other,
  ];

  bool get isEmpty => rows.isEmpty;

  void open(EmergencyType type) =>
      _navigation.pushNamed<void>(AppRoutes.firstAidCard(type.name));
}
