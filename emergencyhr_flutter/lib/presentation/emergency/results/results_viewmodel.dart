import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/emergency_api.dart';
import '../../../data/local/emergency_cache.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/route_args.dart';
import '../presenters/result_presenter.dart';

typedef ResultRow = ({
  int id,
  String name,
  String distance,
  String eta,
  String status,
  StatusTone tone,
  List<TileMetric> metrics,
  String? capabilities,
  String? footnote,
  VoidCallback onTap,
  VoidCallback? onCall,
  VoidCallback onDirections,
});

/// Ranked hospitals with Call and Directions. Updates live, ages tick on
/// the device, and the last results are kept for poor connectivity.
class ResultsViewModel extends ReactiveViewModel {
  ResultsViewModel({
    required this.args,
    EmergencyApi? api,
    EmergencyCache? cache,
    EmergencySessionService? emergency,
    NavigationService? navigation,
    LauncherService? launcher,
    PhoneCallService? calls,
    SnackbarService? snackbar,
    DateTime Function()? now,
  }) : _api = api ?? emergencyApi,
       _cache = cache ?? emergencyCache,
       _emergency = emergency ?? emergencySession,
       _navigation = navigation ?? navigationService,
       _launcher = launcher ?? launcherService,
       _calls = calls ?? phoneCallService,
       _snackbar = snackbar ?? snackbarService,
       _now = now ?? (() => DateTime.now().toUtc());

  final EmergencyResultsArgs? args;
  final EmergencyApi _api;
  final EmergencyCache _cache;
  final EmergencySessionService _emergency;
  final NavigationService _navigation;
  final LauncherService _launcher;
  final PhoneCallService _calls;
  final SnackbarService _snackbar;
  final DateTime Function() _now;

  @override
  List<ListenableServiceMixin> get listenableServices => [_emergency];

  StreamSubscription<EmergencySearch>? _live;
  Timer? _ticker;
  Timer? _poll;
  DateTime? _offlineSavedAt;
  bool _showHidden = false;
  bool _failed = false;

  EmergencySearch? get _search => _emergency.search;

  static const title = 'Hospitals near you';

  bool get isLoading => _search == null && !_failed;
  bool get failed => _search == null && _failed;
  static const failedMessage =
      'We could not load hospitals. Check your connection, or call 112 now.';

  String get subtitle {
    final s = _search;
    if (s == null) return '';
    final area = args?.area == null ? 'you' : args!.area!;
    return '${s.emergencyType.label} · within ${s.radiusKm.round()} km of $area';
  }

  bool get isOffline => _offlineSavedAt != null;
  String get offlineNotice =>
      'You are offline. These results were saved at '
      '${Formatters.time(_offlineSavedAt ?? _now())} and may be out of date. '
      'Call before going.';

  bool get showCall112 => _search?.showCall112 ?? false;
  static const call112Notice =
      'No hospital within 25 km is confirmed as accepting. Call 112, or call '
      'a hospital below before going.';

  List<EmergencyResult> get _visible =>
      (_search?.results ?? const []).where((r) => r.rankTier != 0).toList();
  List<EmergencyResult> get _hidden =>
      (_search?.results ?? const []).where((r) => r.rankTier == 0).toList();

  bool get isEmpty => _search != null && _search!.results.isEmpty;
  static const emptyTitle = 'No hospitals found within 25 km';
  static const emptyMessage = 'Call 112 for help now.';

  List<ResultRow> get rows => [for (final r in _visible) _row(r)];

  bool get hasHidden => _hidden.isNotEmpty;
  bool get showHidden => _showHidden;
  String get hiddenToggleLabel => _showHidden
      ? 'Hide paused and under review'
      : 'Show ${Formatters.count(_hidden.length, 'hospital')} paused or under review';
  List<ResultRow> get hiddenRows =>
      _showHidden ? [for (final r in _hidden) _row(r)] : const [];

  Future<void> onReady() async {
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      notifyListeners();
    });
    final a = args;
    if (a == null) {
      // Opened directly (e.g. browser refresh): reuse the last session.
      if (_search == null) {
        await _navigation.replaceWith<void>(AppRoutes.emergency);
        return;
      }
      _subscribe();
      return;
    }
    final response = await _api.start(
      lat: a.lat,
      lng: a.lng,
      type: a.type,
      area: a.area,
      tappedAt: _emergency.tappedAt,
    );
    if (response.success) {
      _offlineSavedAt = null;
      _emergency.setSearch(response.data!);
      unawaited(_cache.save(response.data!));
      _subscribe();
    } else {
      final cached = _cache.read();
      if (cached != null) {
        _offlineSavedAt = cached.savedAt;
        _emergency.setSearch(cached.search);
      } else {
        _failed = true;
      }
    }
    notifyListeners();
  }

  Future<void> retry() async {
    _failed = false;
    notifyListeners();
    await onReady();
  }

  Future<void> refresh() async {
    final s = _search;
    if (s == null || isOffline) return retry();
    final response = await _api.refresh(s.sessionId, s.accessToken);
    if (response.success) {
      _emergency.setSearch(response.data!);
      unawaited(_cache.save(response.data!));
    }
  }

  void toggleHidden() {
    _showHidden = !_showHidden;
    notifyListeners();
  }

  void _subscribe() {
    final s = _search;
    if (s == null) return;
    _live?.cancel();
    _live = _api
        .watch(s.sessionId, s.accessToken)
        .listen(
          (next) {
            _emergency.setSearch(next);
            unawaited(_cache.save(next));
          },
          onError: (Object _) => _startPolling(),
          onDone: _startPolling,
        );
  }

  /// Fallback when the live connection drops.
  void _startPolling() {
    _poll ??= Timer.periodic(const Duration(seconds: 60), (_) => refresh());
  }

  ResultRow _row(EmergencyResult r) {
    final now = _now();
    return (
      id: r.facilityId,
      name: r.name,
      distance: ResultPresenter.distance(r),
      eta: ResultPresenter.eta(r),
      status: ResultPresenter.statusLabel(r, now),
      tone: ResultPresenter.tone(r, now),
      metrics: ResultPresenter.metrics(r),
      capabilities: ResultPresenter.capabilities(r),
      footnote: ResultPresenter.footnote(r),
      onTap: () => openDetail(r),
      onCall: r.deskPhone == null ? null : () => call(r),
      onDirections: () => directions(r),
    );
  }

  Future<void> call(EmergencyResult r) async {
    await _record(EmergencyAction.call, r);
    await _calls.callNumber(
      number: r.deskPhone!,
      title: 'Call ${r.name}',
      message: ResultPresenter.statusLabel(r, _now()),
    );
    await _navigation.pushNamed<void>(AppRoutes.emergencyAfter);
  }

  Future<void> directions(EmergencyResult r) async {
    await _record(EmergencyAction.directions, r);
    final opened = await _launcher.openDirections(
      lat: r.lat,
      lng: r.lng,
      label: r.name,
    );
    if (!opened) _snackbar.error(message: 'Could not open maps.');
    await _navigation.pushNamed<void>(AppRoutes.emergencyAfter);
  }

  Future<void> call112() async {
    await _record(EmergencyAction.call112, null);
    await _calls.callNumber(
      number: '112',
      title: 'Call 112',
      message: 'The national emergency number.',
    );
  }

  void openDetail(EmergencyResult r) =>
      _navigation.pushNamed<void>(AppRoutes.hospitalDetail(r.facilityId));

  Future<void> _record(EmergencyAction action, EmergencyResult? r) async {
    _emergency.setActed(r, action);
    final s = _search;
    if (s == null || isOffline) return;
    // Recording must never block the call.
    unawaited(
      _api.recordAction(
        s.sessionId,
        s.accessToken,
        action,
        facilityId: r?.facilityId,
      ),
    );
  }

  @override
  void dispose() {
    _live?.cancel();
    _ticker?.cancel();
    _poll?.cancel();
    super.dispose();
  }
}
