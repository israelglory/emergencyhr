import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/route_args.dart';
import 'import_sheet/import_sheet_view.dart';

typedef DirectoryItem = ({
  int id,
  String name,
  String detail,
  String badge,
  StatusTone tone,
  bool suspended,
  bool canVerify,
  bool selected,
});

class DirectoryViewModel extends BaseViewModel {
  DirectoryViewModel({
    AdminApi? api,
    NavigationService? navigation,
    DialogService? dialogs,
    SnackbarService? snackbar,
    BottomSheetService? sheets,
  }) : _api = api ?? adminApi,
       _navigation = navigation ?? navigationService,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService,
       _sheetsOverride = sheets;

  final AdminApi _api;
  final NavigationService _navigation;
  final DialogService _dialogs;
  final SnackbarService _snackbar;
  final BottomSheetService? _sheetsOverride;
  BottomSheetService get _sheets => _sheetsOverride ?? bottomSheetService;

  /// Matches the server's page size.
  static const pageSize = 50;
  bool _hasMore = false;
  bool get hasMore => _hasMore;

  final searchController = TextEditingController();
  Timer? _debounce;
  List<DirectoryRow> _rows = const [];

  // Filters
  static const allAreas = 'All areas';
  static const showAll = 'All hospitals';
  static const showUnverified = 'Unverified only';
  List<String> _areas = const [];
  String? _area;
  bool _unverifiedOnly = false;

  List<({String value, String label})> get areaOptions => [
    for (final a in [allAreas, ..._areas]) (value: a, label: a),
  ];
  String get area => _area ?? allAreas;
  List<({String value, String label})> get showOptions => const [
    (value: showAll, label: showAll),
    (value: showUnverified, label: showUnverified),
  ];
  String get show => _unverifiedOnly ? showUnverified : showAll;

  // Bulk verify
  final Set<int> _selected = {};
  bool _selectingAll = false;
  ({int done, int total})? _progress;

  bool get hasSelection => _selected.isNotEmpty;
  bool get isBulkRunning => _progress != null;
  bool get isSelectingAll => _selectingAll;
  String get selectionLabel => '${_selected.length} selected';
  String get verifySelectedLabel => 'Verify ${_selected.length}';
  String? get progressLabel {
    final p = _progress;
    return p == null ? null : 'Verifying ${p.done} of ${p.total}…';
  }

  static const selectAllLabel = 'Select all to verify';

  bool get isLoading => isBusy && _rows.isEmpty;
  String? get errorMessage => modelError?.toString();
  ViewState get state => viewStateOf(
    busy: isBusy,
    hasError: hasError,
    hasData: _rows.isNotEmpty,
  );

  List<DirectoryItem> get rows => [
    for (final r in _rows)
      (
        id: r.facility.id,
        name: r.facility.name,
        detail: '${r.address} · ${r.facility.area}',
        badge: r.suspended
            ? 'Suspended'
            : r.flagged
            ? 'Under review'
            : r.facility.verificationStatus == VerificationStatus.seeded
            ? 'Unverified'
            : r.facility.onboardingStage.label,
        tone: r.suspended || r.flagged
            ? StatusTone.critical
            : r.facility.onboardingStage == OnboardingStage.live
            ? StatusTone.positive
            : StatusTone.neutral,
        suspended: r.suspended,
        canVerify: _canVerify(r),
        selected: _selected.contains(r.facility.id),
      ),
  ];

  static bool _canVerify(DirectoryRow r) =>
      !r.suspended &&
      (r.facility.verificationStatus == VerificationStatus.seeded ||
          r.facility.verificationStatus == VerificationStatus.pending ||
          r.facility.verificationStatus == VerificationStatus.rejected);

  String? get _query {
    final q = searchController.text.trim();
    return q.isEmpty ? null : q;
  }

  Future<void> onReady() async {
    await load();
    final areas = await _api.directoryAreas();
    if (areas.success) {
      _areas = areas.data!;
      notifyListeners();
    }
  }

  Future<void> load() => _load(offset: 0);

  void setArea(String? value) {
    _area = value == null || value == allAreas ? null : value;
    _selected.clear();
    load();
  }

  void setShow(String? value) {
    _unverifiedOnly = value == showUnverified;
    _selected.clear();
    load();
  }

  void toggle(int id) {
    _selected.contains(id) ? _selected.remove(id) : _selected.add(id);
    notifyListeners();
  }

  /// The row's tick box, locked while a bulk Verify runs.
  ValueChanged<bool?>? onToggle(int id) =>
      isBulkRunning ? null : (_) => toggle(id);

  void clearSelection() {
    _selected.clear();
    notifyListeners();
  }

  /// Selects every listing matching the search and filters that can still
  /// be verified, not only the rows loaded so far.
  Future<void> selectAllVerifiable() async {
    _selectingAll = true;
    notifyListeners();
    final response = await _api.directoryVerifiableIds(
      query: _query,
      area: _area,
    );
    _selectingAll = false;
    if (response.success) {
      _selected
        ..clear()
        ..addAll(response.data!);
      if (_selected.isEmpty) {
        _snackbar.info(message: 'Nothing to verify here.');
      }
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  /// Verifies the selection in batches the server accepts, then reports.
  Future<void> verifySelected() async {
    final ids = _selected.toList();
    if (ids.isEmpty) return;
    final ok = await _dialogs.confirm(
      title: 'Verify ${Formatters.count(ids.length, 'hospital')}?',
      message:
          'Only verify hospitals you have checked, for example on a list you '
          'trust or by phone. The public still sees "Unverified. Call before '
          'going." until each desk confirms a status.',
      confirmLabel: 'Verify',
    );
    if (!ok) return;
    var verified = 0;
    var already = 0;
    final skipped = <String>[];
    String? failure;
    _progress = (done: 0, total: ids.length);
    notifyListeners();
    for (var i = 0; i < ids.length; i += AdminApi.verifyBatchSize) {
      final batch = ids.sublist(
        i,
        (i + AdminApi.verifyBatchSize).clamp(0, ids.length),
      );
      final response = await _api.verifyListings(batch);
      if (!response.success) {
        failure = response.message;
        break;
      }
      final r = response.data!;
      verified += r.verified;
      already += r.alreadyVerified;
      skipped.addAll(r.skipped);
      _selected.removeAll(batch);
      _progress = (done: i + batch.length, total: ids.length);
      notifyListeners();
    }
    _progress = null;
    final parts = [
      '$verified verified',
      if (already > 0) '$already already verified',
      if (skipped.isNotEmpty) '${skipped.length} skipped',
    ];
    if (failure != null) {
      _snackbar.error(message: '${parts.join(', ')}. Stopped: $failure');
    } else {
      _snackbar.success(message: parts.join(', '));
    }
    await load();
  }

  Future<void> loadMore() => _load(offset: _rows.length);

  Future<void> _load({required int offset}) async {
    setError(null);
    final response = await runBusyFuture(
      _api.directory(
        query: _query,
        area: _area,
        unverifiedOnly: _unverifiedOnly,
        offset: offset,
      ),
    );
    if (response.success) {
      final page = response.data!;
      _rows = offset == 0 ? page : [..._rows, ...page];
      _hasMore = page.length == pageSize;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  /// Hospitals from an open dataset, as unverified listings.
  Future<void> importHospitals() async {
    final imported = await _sheets.show<bool>(const ImportSheetView());
    if (imported == true) await load();
  }

  /// Marks a listing verified after the admin has checked it.
  Future<void> verify(DirectoryItem item) async {
    final ok = await _dialogs.confirm(
      title: 'Verify ${item.name}?',
      message:
          'Only verify a hospital you have checked, for example by phone or '
          'a visit. The public still sees "Unverified. Call before going." '
          'until its desk confirms a status.',
      confirmLabel: 'Verify',
    );
    if (!ok) return;
    final response = await runBusyFuture(_api.verifyListing(item.id));
    if (response.success) {
      _snackbar.success(message: 'Verified');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  void onSearchChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _selected.clear();
      load();
    });
  }

  void open(int id) => _navigation.pushNamed<void>(AppRoutes.agentFacility(id));

  Future<void> createListing() async {
    await _navigation.pushNamed<bool>(
      AppRoutes.facilityNew,
      args: const FacilityEditorArgs(),
    );
    await load();
  }

  Future<void> toggleSuspended(DirectoryItem item) async {
    final suspend = !item.suspended;
    final reason = await _dialogs.promptText(
      title: 'Enter a reason',
      message: suspend
          ? 'Suspending ${item.name} hides it from the public.'
          : 'Reinstating ${item.name} shows it to the public again.',
      confirmLabel: suspend ? 'Suspend' : 'Reinstate',
      destructive: suspend,
    );
    if (reason == null) return;
    final response = await runBusyFuture(
      _api.setFacilitySuspended(item.id, suspend, reason),
    );
    if (response.success) {
      _snackbar.success(message: suspend ? 'Suspended' : 'Reinstated');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  String suspendLabel(DirectoryItem item) =>
      item.suspended ? 'Reinstate' : 'Suspend';

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
