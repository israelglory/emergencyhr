import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';

typedef MetricTile = ({
  String label,
  String value,
  String note,
  StatusTone tone,
});

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
            : median < 60
            ? '$median s'
            : '${median ~/ 60} min ${median % 60} s',
        note: 'Target under 2 min',
        tone: median != null && median < 120
            ? StatusTone.positive
            : StatusTone.warning,
      ),
      (
        label: 'Emergency sessions',
        value: '${m.sessions}',
        note: '${m.actedSessions} led to a call or directions',
        tone: StatusTone.neutral,
      ),
      (
        label: 'Live hospitals under 60 min old',
        value: pct(m.freshUnder60Share),
        note: 'Target 70%',
        tone: m.freshUnder60Share >= 0.7
            ? StatusTone.positive
            : StatusTone.warning,
      ),
      (
        label: 'Empty result rate',
        value: pct(m.emptyResultRate),
        note: 'Target under 10%',
        tone: m.emptyResultRate < 0.1
            ? StatusTone.positive
            : StatusTone.warning,
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
