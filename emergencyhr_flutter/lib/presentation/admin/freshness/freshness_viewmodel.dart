import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/freshness.dart';

typedef FreshnessItem = ({
  int id,
  String name,
  String area,
  String age,
  StatusTone tone,
  String detail,
});

/// Every live facility with its last update age, stalest first.
class FreshnessViewModel extends BaseViewModel {
  FreshnessViewModel({AdminApi? api, NavigationService? navigation})
    : _api = api ?? adminApi,
      _navigation = navigation ?? navigationService;

  final AdminApi _api;
  final NavigationService _navigation;
  List<FreshnessRow> _rows = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _rows.isNotEmpty);

  List<FreshnessItem> get rows {
    final now = DateTime.now().toUtc();
    return [
      for (final r in _rows)
        () {
          final at = r.lastUpdateAt;
          final minutes = at == null ? null : now.difference(at).inMinutes;
          return (
            id: r.facility.id,
            name: r.facility.name,
            area: r.facility.area,
            age: Freshness.staffAge(at, now),
            tone: minutes == null || minutes > Freshness.staleMinutes
                ? StatusTone.critical
                : minutes > Freshness.freshMinutes
                ? StatusTone.warning
                : StatusTone.positive,
            detail: [
              r.facility.area,
              if (r.accepting != null) r.accepting! ? 'Accepting' : 'Paused',
              r.openNow ? 'Open now' : 'Closed now',
            ].join(' · '),
          );
        }(),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.freshness());
    if (response.success) {
      _rows = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  void open(int id) => _navigation.pushNamed<void>(AppRoutes.agentFacility(id));
}
