import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/shell_kind.dart';

enum AdminTab {
  verification('Verification', Icons.verified_outlined),
  pipeline('Pipeline', Icons.view_kanban_outlined),
  directory('Directory', Icons.local_hospital_outlined),
  freshness('Freshness', Icons.schedule),
  reports('Reports', Icons.flag_outlined),
  claims('Claims', Icons.how_to_reg_outlined),
  joins('Join requests', Icons.mail_outline),
  agents('Field agents', Icons.badge_outlined),
  newHospitals('New hospitals', Icons.fiber_new_outlined),
  metrics('Metrics', Icons.insights_outlined),
  users('Accounts', Icons.manage_accounts_outlined);

  const AdminTab(this.label, this.icon);
  final String label;
  final IconData icon;
}

class AdminShellViewModel extends BaseViewModel {
  AdminShellViewModel({AccessService? access, NavigationService? navigation})
    : _access = access ?? accessService,
      _navigation = navigation ?? navigationService;

  final AccessService _access;
  final NavigationService _navigation;

  bool _allowed = false;
  int _index = 0;

  bool get isReady => _allowed;
  static const title = 'Admin';
  int get selectedIndex => _index;
  AdminTab get currentTab => AdminTab.values[_index];
  String get subtitle => currentTab.label;

  List<ShellDestination> get destinations => [
    for (final t in AdminTab.values) (icon: t.icon, label: t.label),
  ];

  Future<void> onReady() async {
    _allowed = await _access.ensure(ShellKind.admin, returnTo: AppRoutes.admin);
    notifyListeners();
  }

  void select(int index) {
    _index = index;
    notifyListeners();
  }

  void goHome() => _navigation.clearStackAndShow<void>(AppRoutes.home);
}
