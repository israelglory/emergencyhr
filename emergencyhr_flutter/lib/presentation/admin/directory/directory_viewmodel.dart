import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/route_args.dart';

typedef DirectoryItem = ({
  int id,
  String name,
  String detail,
  String badge,
  StatusTone tone,
  bool suspended,
});

class DirectoryViewModel extends BaseViewModel {
  DirectoryViewModel({
    AdminApi? api,
    NavigationService? navigation,
    DialogService? dialogs,
    SnackbarService? snackbar,
  }) : _api = api ?? adminApi,
       _navigation = navigation ?? navigationService,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService;

  final AdminApi _api;
  final NavigationService _navigation;
  final DialogService _dialogs;
  final SnackbarService _snackbar;

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
            : r.facility.onboardingStage.label,
        tone: r.suspended || r.flagged
            ? StatusTone.critical
            : StatusTone.neutral,
        suspended: r.suspended,
      ),
  ];

  Future<void> load() async {
    setError(null);
    final query = searchController.text.trim();
    final response = await runBusyFuture(
      _api.directory(query: query.isEmpty ? null : query),
    );
    if (response.success) {
      _rows = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
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
