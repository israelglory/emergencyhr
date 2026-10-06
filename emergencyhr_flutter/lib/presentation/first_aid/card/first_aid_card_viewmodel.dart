import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../components/first_aid_content.dart';
import '../first_aid_presenter.dart';

class FirstAidCardViewModel extends BaseViewModel {
  FirstAidCardViewModel({
    required this.typeName,
    FirstAidService? firstAid,
    PhoneCallService? calls,
  }) : _firstAid = firstAid ?? firstAidService,
       _calls = calls ?? phoneCallService;

  final String typeName;
  final FirstAidService _firstAid;
  final PhoneCallService _calls;

  FirstAidCard? get _card {
    final type = EmergencyType.values
        .where((t) => t.name == typeName)
        .firstOrNull;
    return type == null ? null : _firstAid.forType(type);
  }

  bool get found => _card != null;
  FirstAidDisplay? get card =>
      _card == null ? null : FirstAidPresenter.display(_card!);

  Future<void> call112() => _calls.callNumber(number: '112', title: 'Call 112');
}
