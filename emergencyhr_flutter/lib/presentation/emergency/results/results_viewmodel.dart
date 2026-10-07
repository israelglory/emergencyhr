import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/api_response.dart';
import '../../../data/api/emergency_api.dart';
import '../../../data/local/emergency_cache.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/pilot_areas.dart';
import '../../../data/models/route_args.dart';
import '../presenters/result_presenter.dart';

typedef ResultRow = ({
  int id,
  String name,
  String distance,
  String status,
  StatusTone tone,
  List<TileMetric> metrics,
  List<String> capabilities,
  String? footnote,
  VoidCallback onTap,
  VoidCallback? onCall,
  VoidCallback onDirections,
});

enum ResultsState { loading, failed, empty, results, nothingAccepting }

/// Hospitals near you. Opens straight from Emergency with the device
/// location and all types; Location and What happened refine the same
/// session. Updates live, ages tick on the device, and the last results are
/// kept for poor connectivity.
class ResultsViewModel extends ReactiveViewModel {
  ResultsViewModel({
    this.args,
    EmergencyApi? api,
    EmergencyCache? cache,
    EmergencySessionService? emergency,
    LocationService? location,
    NavigationService? navigation,
    LauncherService? launcher,
    PhoneCallService? calls,
    SnackbarService? snackbar,
    DateTime Function()? now,
  }) : _api = api ?? emergencyApi,
       _cache = cache ?? emergencyCache,
       _emergency = emergency ?? emergencySession,
       _location = location ?? locationService,
       _navigation = navigation ?? navigationService,
       _launcher = launcher ?? launcherService,
       _calls = calls ?? phoneCallService,
       _snackbar = snackbar ?? snackbarService,
       _now = now ?? (() => DateTime.now().toUtc());

  /// Set when the place is already known (tests, deep links).
  final EmergencyResultsArgs? args;
  final EmergencyApi _api;
  final EmergencyCache _cache;
  final EmergencySessionService _emergency;
  final LocationService _location;
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
  double? _lat;
  double? _lng;

  /// Repeats the last load after a failure.
  Future<void> Function()? _lastLoad;

  EmergencySearch? get _search => _emergency.search;

  static const title = 'Hospitals near you';

  // Header
  String get locationValue => _emergency.area ?? 'Near you';
  String get typeValue => _emergency.type == EmergencyType.skipped
      ? 'All types'
      : _emergency.type.label;
  bool get typeSelected => _emergency.type != EmergencyType.skipped;

  ResultsState get state {
    final s = _search;
    if (s == null) return _failed ? ResultsState.failed : ResultsState.loading;
    if (s.results.isEmpty) return ResultsState.empty;
    return s.showCall112 ? ResultsState.nothingAccepting : ResultsState.results;
  }

  static const loadingLabel = 'Finding hospitals that can take you';
  static const failedTitle = 'We could not load hospitals';
  static const failedMessage = 'Check your connection, or call 112 now.';
  static const emptyTitle = 'No hospitals found within 25 km';
  static const emptyMessage = 'Call 112 for help now.';
  static const call112Notice =
      'No hospital within 25 km is confirmed as accepting. Call 112, or call '
      'a hospital below before going.';

  /// "6 hospitals within 10 km, sorted by who can take you now".
  String get summary {
    final s = _search;
    if (s == null) return '';
    return '${Formatters.count(_visible.length, 'hospital')} within '
        '${s.radiusKm.round()} km, sorted by who can take you now';
  }

  bool get isOffline => _offlineSavedAt != null;
  String get offlineNotice =>
      'You are offline. These results were saved at '
      '${Formatters.time(_offlineSavedAt ?? _now())} and may be out of date. '
      'Call before going.';

  List<EmergencyResult> get _all => _search?.results ?? const [];
  List<EmergencyResult> get _visible =>
      _all.where((r) => r.rankTier != 0).toList();
  List<EmergencyResult> get _hidden =>
      _all.where((r) => r.rankTier == 0).toList();

  List<ResultRow> get rows => [for (final r in _visible) _row(r)];

  bool get hasHidden => _hidden.isNotEmpty;
  bool get showHidden => _showHidden;
  String get hiddenToggleLabel => _showHidden
      ? 'Hide paused and under review'
      : 'Show ${Formatters.count(_hidden.length, 'hospital')} paused or '
            'under review';
  List<ResultRow> get hiddenRows =>
      _showHidden ? [for (final r in _hidden) _row(r)] : const [];

  /// Accepting first, then paused and under review when shown.
  List<ResultRow> get allRows => [...rows, ...hiddenRows];

  Future<void> onReady() async {
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      notifyListeners();
    });
    // Back on an open list (e.g. from Next steps on the web).
    if (_search != null && args == null) {
      _subscribe();
      return;
    }
    final a = args;
    if (a != null) {
      _emergency.setType(a.type);
      _emergency.setArea(a.area);
      return _load(() => _start(a.lat, a.lng));
    }
    final pending = _emergency.pendingLocation ?? _beginFresh();
    final result = await pending;
    if (result is LocationFound) {
      return _load(() => _start(result.lat, result.lng));
    }
    // No location: the area picker. Leaving it without an area goes back.
    final area = await _navigation.pushNamed<PilotArea>(
      AppRoutes.emergencyArea,
    );
    if (area == null) {
      _navigation.back(fallbackRoute: AppRoutes.home);
      return;
    }
    _emergency.setArea(area.name);
    await _load(() => _start(area.lat, area.lng));
  }

  Future<Object?> _beginFresh() {
    final pending = _location.current();
    _emergency.begin(pending);
    return pending;
  }

  Future<void> retry() async {
    final load = _lastLoad;
    if (load == null) return onReady();
    await _load(load);
  }

  Future<void> _load(Future<void> Function() load) async {
    _lastLoad = load;
    _failed = false;
    unawaited(_live?.cancel());
    if (_search != null) _emergency.clearSearch();
    notifyListeners();
    await load();
    notifyListeners();
  }

  Future<void> _start(double lat, double lng) async {
    _lat = lat;
    _lng = lng;
    final response = await _api.start(
      lat: lat,
      lng: lng,
      type: _emergency.type,
      area: _emergency.area,
      tappedAt: _emergency.tappedAt,
    );
    _apply(response);
  }

  void _apply(ApiResponse<EmergencySearch> response) {
    if (response.success) {
      _offlineSavedAt = null;
      _emergency.setSearch(response.data!);
      unawaited(_cache.save(response.data!));
      _subscribe();
      return;
    }
    final cached = _cache.read();
    if (cached != null) {
      _offlineSavedAt = cached.savedAt;
      _emergency.setSearch(cached.search);
    } else {
      _failed = true;
    }
  }

  /// Opens What happened. A new choice re-ranks the same session.
  Future<void> chooseType() async {
    final type = await _navigation.pushNamed<EmergencyType>(
      AppRoutes.emergencyType,
      args: _emergency.type,
    );
    if (type == null || type == _emergency.type) return;
    _emergency.setType(type);
    await _refine();
  }

  /// Opens Choose your area.
  Future<void> chooseArea() async {
    final area = await _navigation.pushNamed<PilotArea>(
      AppRoutes.emergencyArea,
    );
    if (area == null) return;
    _emergency.setArea(area.name);
    await _refine(place: area);
  }

  Future<void> _refine({PilotArea? place}) async {
    final s = _search;
    final lat = place?.lat ?? _lat;
    final lng = place?.lng ?? _lng;
    if (s == null || isOffline) {
      if (lat == null || lng == null) return retry();
      return _load(() => _start(lat, lng));
    }
    await _load(() async {
      final response = await _api.updateSearch(
        s.sessionId,
        s.accessToken,
        _emergency.type,
        place: place == null
            ? null
            : (lat: place.lat, lng: place.lng, area: place.name),
      );
      if (place != null) {
        _lat = place.lat;
        _lng = place.lng;
      }
      _apply(response);
    });
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

  void back() => _navigation.back(fallbackRoute: AppRoutes.home);

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
      title: 'Call this number',
      message: '${r.name}, emergency desk',
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
