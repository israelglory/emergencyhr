import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/onboarding_api.dart';
import '../../../data/models/labels.dart';

typedef AgentFacilityRow = ({
  int id,
  String name,
  String detail,
  String progress,
  StatusTone progressTone,
  String? nextAction,
});

class AgentFacilitiesViewModel extends BaseViewModel {
  AgentFacilitiesViewModel({
    OnboardingApi? api,
    NavigationService? navigation,
  }) : _api = api ?? locator<OnboardingApi>(),
       _navigation = navigation ?? navigationService;

  final OnboardingApi _api;
  final NavigationService _navigation;

  List<AgentFacility> _items = const [];

  String? get errorMessage => modelError?.toString();
  bool get isLoading => isBusy && _items.isEmpty;
  bool get isEmpty => !isBusy && !hasError && _items.isEmpty;

  List<AgentFacilityRow> get rows {
    final sorted = [..._items]
      ..sort((a, b) {
        final an = a.nextActionAt ?? DateTime.utc(9999);
        final bn = b.nextActionAt ?? DateTime.utc(9999);
        return an.compareTo(bn);
      });
    return [
      for (final i in sorted)
        (
          id: i.facility.id,
          name: i.facility.name,
          detail:
              '${i.facility.area} · ${i.facility.onboardingStage.label}'
              '${i.submitted ? ' · submitted' : ''}',
          progress: '${i.checklistDone}/${i.checklistTotal} checklist',
          progressTone: i.checklistDone == i.checklistTotal
              ? StatusTone.positive
              : StatusTone.neutral,
          nextAction: i.nextActionAt == null
              ? null
              : 'Next action ${Formatters.date(i.nextActionAt!)}',
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.myFacilities());
    if (response.success) {
      _items = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> open(int id) async {
    await _navigation.pushNamed<void>(AppRoutes.agentFacility(id));
    await load();
  }
}
