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
        canVerify:
            !r.suspended &&
            (r.facility.verificationStatus == VerificationStatus.seeded ||
                r.facility.verificationStatus == VerificationStatus.pending ||
                r.facility.verificationStatus == VerificationStatus.rejected),
      ),
  ];

  Future<void> load() => _load(offset: 0);

  Future<void> loadMore() => _load(offset: _rows.length);

  Future<void> _load({required int offset}) async {
    setError(null);
    final query = searchController.text.trim();
    final response = await runBusyFuture(
      _api.directory(query: query.isEmpty ? null : query, offset: offset),
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
    _debounce = Timer(const Duration(milliseconds: 350), load);
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
