import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/labels.dart';

typedef UserItem = ({
  int id,
  String name,
  String detail,
  bool suspended,
  String action,
});

/// Suspend and reinstate accounts, with a logged reason.
class UsersViewModel extends BaseViewModel {
  UsersViewModel({
    AdminApi? api,
    DialogService? dialogs,
    SnackbarService? snackbar,
  }) : _api = api ?? adminApi,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService;

  final AdminApi _api;
  final DialogService _dialogs;
  final SnackbarService _snackbar;

  final searchController = TextEditingController();
  Timer? _debounce;
  List<UserRow> _rows = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _rows.isNotEmpty);

  List<UserItem> get rows => [
    for (final u in _rows)
      (
        id: u.userId,
        name: Formatters.person(name: u.name, email: u.email, phone: u.phone),
        detail:
            '${Formatters.contact(email: u.email, phone: u.phone)} · '
            '${u.roles.map((r) => r.label).join(', ')}'
            '${u.suspended ? ' · Suspended' : ''}',
        suspended: u.suspended,
        action: u.suspended ? 'Reinstate' : 'Suspend',
      ),
  ];

  Future<void> load() async {
    setError(null);
    final q = searchController.text.trim();
    final response = await runBusyFuture(
      _api.users(query: q.isEmpty ? null : q),
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

  Future<void> toggle(UserItem item) async {
    final suspend = !item.suspended;
    final reason = await _dialogs.promptText(
      title: '${item.action} ${item.name}',
      label: 'Reason (logged)',
      confirmLabel: item.action,
      destructive: suspend,
    );
    if (reason == null) return;
    final response = await runBusyFuture(
      _api.setUserSuspended(item.id, suspend, reason),
    );
    if (response.success) {
      _snackbar.success(message: suspend ? 'Suspended' : 'Reinstated');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
