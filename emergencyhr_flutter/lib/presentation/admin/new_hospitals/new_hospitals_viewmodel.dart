import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';

typedef NewHospitalItem = ({
  int id,
  String name,
  String detail,
  String badge,
  StatusTone tone,
});

/// Facilities in their first 14 days live, so agents can follow up while
/// the update habit forms.
class NewHospitalsViewModel extends BaseViewModel {
  NewHospitalsViewModel({AdminApi? api, NavigationService? navigation})
    : _api = api ?? adminApi,
      _navigation = navigation ?? navigationService;

  final AdminApi _api;
  final NavigationService _navigation;
  List<NewHospitalRow> _rows = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _rows.isNotEmpty);

  List<NewHospitalItem> get rows {
    final now = DateTime.now().toUtc();
    return [
      for (final r in _rows)
        (
          id: r.facility.id,
          name: r.facility.name,
          detail: [
            'Live ${Formatters.ago(r.liveAt, now)}',
            Formatters.count(r.statusUpdates, 'update'),
            r.lastUpdateAt == null
                ? 'never updated'
                : 'last ${Formatters.ago(r.lastUpdateAt!, now)}',
            if (r.agentName != null) 'agent ${r.agentName}',
          ].join(' · '),
          badge: r.quiet ? 'Quiet 48 h. Follow up' : 'Updating',
          tone: r.quiet ? StatusTone.critical : StatusTone.positive,
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.newHospitals());
    if (response.success) {
      _rows = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  void open(int id) => _navigation.pushNamed<void>(AppRoutes.agentFacility(id));
}
