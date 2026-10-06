import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

typedef FirstAidRow = ({String title, String summary, EmergencyType type});

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

  List<FirstAidRow> get rows => [
    for (final c in _firstAid.cards)
      if (c.type != EmergencyType.skipped)
        (title: c.title, summary: c.summary, type: c.type),
  ];

  bool get isEmpty => rows.isEmpty;

  void open(EmergencyType type) =>
      _navigation.pushNamed<void>(AppRoutes.firstAidCard(type.name));
}
