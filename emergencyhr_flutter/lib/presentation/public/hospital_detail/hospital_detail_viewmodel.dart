import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/emergency_api.dart';
import '../../../data/models/freshness.dart';
import '../../../data/models/labels.dart';

class HospitalDetailViewModel extends BaseViewModel {
  HospitalDetailViewModel({
    required this.facilityId,
    EmergencyApi? api,
    EmergencySessionService? emergency,
    PhoneCallService? calls,
    LauncherService? launcher,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? emergencyApi,
       _emergency = emergency ?? emergencySession,
       _calls = calls ?? phoneCallService,
       _launcher = launcher ?? launcherService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  final int facilityId;
  final EmergencyApi _api;
  final EmergencySessionService _emergency;
  final PhoneCallService _calls;
  final LauncherService _launcher;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  PublicFacility? _f;

  bool get isLoading => _f == null && !hasError;
  String? get errorMessage => modelError?.toString();

  String get name => _f?.name ?? '';
  String get typeLabel => _f?.type.label ?? '';
  String get address => '${_f?.address ?? ''}, ${_f?.area ?? ''}';

  String get phoneLabel => _f?.deskPhone == null
      ? 'No phone listed'
      : Formatters.phone(_f!.deskPhone!);
  bool get canCall => _f?.deskPhone != null;
  VoidCallback? get onCall => canCall ? call : null;

  DateTime get _now => DateTime.now().toUtc();
  FreshnessTier get _tier => Freshness.tierAt(
    serverTier: _f?.freshness ?? FreshnessTier.unverified,
    updatedAt: _f?.status?.updatedAt,
    now: _now,
  );
  String get statusLabel => Freshness.label(_tier, _f?.status?.updatedAt, _now);
  StatusTone get statusTone => switch (_tier) {
    FreshnessTier.fresh => StatusTone.positive,
    FreshnessTier.stale => StatusTone.warning,
    _ => StatusTone.neutral,
  };

  List<TileMetric> get figures {
    final s = _f?.status;
    if (s == null) return const [];
    return [
      TileMetric('ER beds free', '${s.erBedsFree}'),
      TileMetric('ICU beds free', '${s.icuBedsFree}'),
      TileMetric('Doctor on duty', Formatters.yesNo(s.doctorOnDuty)),
      TileMetric('Deposit required', Formatters.yesNo(s.depositRequired)),
    ];
  }

  List<String> get capabilities => [
    for (final c in _f?.capabilities ?? const <Capability>[]) c.label,
  ];
  bool get hasCapabilities => capabilities.isNotEmpty;

  /// One line per opening period, joined for the contact card.
  String get openingHoursLabel => openingHours.join('\n');

  List<String> get openingHours {
    final h = _f?.openingHours;
    if (h == null) return const ['Not provided. Call before going.'];
    if (h.alwaysOpen) return const ['Open 24 hours, every day'];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String t(int m) =>
        '${(m ~/ 60 % 24).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
    return [
      for (final p in h.periods)
        '${days[p.weekday - 1]}  ${t(p.openMinute)} to ${t(p.closeMinute)}',
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.facility(facilityId));
    if (response.success) {
      _f = response.data;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> call() async {
    final f = _f;
    if (f?.deskPhone == null) return;
    _recordIfInSession(EmergencyAction.call);
    await _calls.callNumber(
      number: f!.deskPhone!,
      title: 'Call this number',
      message: '${f.name}, emergency desk',
    );
  }

  Future<void> directions() async {
    final f = _f;
    if (f == null) return;
    _recordIfInSession(EmergencyAction.directions);
    if (!await _launcher.openDirections(
      lat: f.lat,
      lng: f.lng,
      label: f.name,
    )) {
      _snackbar.error(message: 'Could not open maps.');
    }
  }

  void back() => _navigation.back(fallbackRoute: AppRoutes.home);

  void _recordIfInSession(EmergencyAction action) {
    final s = _emergency.search;
    final result = s?.results
        .where((r) => r.facilityId == facilityId)
        .firstOrNull;
    if (s == null || result == null) return;
    _emergency.setActed(result, action);
    unawaited(
      _api.recordAction(
        s.sessionId,
        s.accessToken,
        action,
        facilityId: facilityId,
      ),
    );
  }
}
