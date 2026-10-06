import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';

typedef MetricTile = ({String label, String value, String note});

class MetricsViewModel extends BaseViewModel {
  MetricsViewModel({AdminApi? api}) : _api = api ?? adminApi;

  final AdminApi _api;
  PlatformMetrics? _m;

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _m != null);

  String get period => 'Last ${_m?.periodDays ?? 30} days';

  List<MetricTile> get tiles {
    final m = _m;
    if (m == null) return const [];
    String pct(double v) => '${(v * 100).round()}%';
    final median = m.medianSecondsToAction;
    return [
      (
        label: 'Median time to action',
        value: median == null
            ? 'No data'
            : median < 120
            ? '$median s'
            : '${(median / 60).toStringAsFixed(1)} min',
        note:
            'From tapping Emergency to calling or getting directions. '
            'Target under 2 minutes.',
      ),
      (
        label: 'Emergency sessions',
        value: '${m.sessions}',
        note: '${m.actedSessions} led to a call or directions.',
      ),
      (
        label: 'Status under 60 min old',
        value: pct(m.freshUnder60Share),
        note: 'Share of ${m.liveFacilities} live hospitals.',
      ),
      (
        label: 'Empty result rate',
        value: pct(m.emptyResultRate),
        note: 'Sessions with no accepting hospital within 25 km.',
      ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.metrics());
    if (response.success) {
      _m = response.data;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }
}
