import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';

typedef ReportItem = ({
  int id,
  String name,
  String detail,
  String badge,
  StatusTone tone,
});

/// Wrong-status reports, auto-flagged facilities first.
class ReportsViewModel extends BaseViewModel {
  ReportsViewModel({
    AdminApi? api,
    DialogService? dialogs,
    SnackbarService? snackbar,
    NavigationService? navigation,
  }) : _api = api ?? adminApi,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService,
       _navigation = navigation ?? navigationService;

  final AdminApi _api;
  final DialogService _dialogs;
  final SnackbarService _snackbar;
  final NavigationService _navigation;
  List<ReportRow> _rows = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _rows.isNotEmpty);

  List<ReportItem> get rows {
    final now = DateTime.now().toUtc();
    return [
      for (final r in _rows)
        (
          id: r.facility.id,
          name: r.facility.name,
          detail:
              '"${r.latestReason}" · ${Formatters.ago(r.latestAt, now)} · '
              '${Formatters.count(r.openReports, 'open report')}',
          badge: r.flagged ? 'Flagged, hidden from Tier 1' : 'Reported',
          tone: r.flagged ? StatusTone.critical : StatusTone.warning,
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.reports());
    if (response.success) {
      _rows = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  void open(int id) => _navigation.pushNamed<void>(AppRoutes.agentFacility(id));

  Future<void> markReviewed(ReportItem item) async {
    final ok = await _dialogs.confirm(
      title: 'Mark ${item.name} reviewed?',
      message:
          'Clears the reports and lifts the flag, so the hospital can rank in '
          'Tier 1 again.',
      confirmLabel: 'Mark reviewed',
    );
    if (!ok) return;
    final response = await runBusyFuture(_api.reviewReports(item.id));
    if (response.success) {
      _snackbar.success(message: 'Reviewed');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }
}
