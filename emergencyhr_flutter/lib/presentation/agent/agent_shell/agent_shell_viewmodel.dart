import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/shell_kind.dart';

enum AgentTab { onboard, facilities }

class AgentShellViewModel extends BaseViewModel {
  AgentShellViewModel({AccessService? access, NavigationService? navigation})
    : _access = access ?? accessService,
      _navigation = navigation ?? navigationService;

  final AccessService _access;
  final NavigationService _navigation;

  bool _allowed = false;
  int _index = 0;

  bool get isReady => _allowed;
  static const title = 'Field agent';

  static const destinations = <ShellDestination>[
    (icon: Icons.add_location_alt_outlined, label: 'Onboard'),
    (icon: Icons.assignment_outlined, label: 'My hospitals'),
  ];

  int get selectedIndex => _index;
  AgentTab get currentTab => AgentTab.values[_index];

  Future<void> onReady() async {
    _allowed = await _access.ensure(ShellKind.agent, returnTo: AppRoutes.agent);
    notifyListeners();
  }

  void select(int index) {
    _index = index;
    notifyListeners();
  }

  void goHome() => _navigation.clearStackAndShow<void>(AppRoutes.home);
}
