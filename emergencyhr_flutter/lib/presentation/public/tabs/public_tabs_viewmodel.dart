import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

/// Home, Assistant and Profile behind one bottom tab bar.
class PublicTabsViewModel extends ReactiveViewModel {
  PublicTabsViewModel({
    required PublicTab initial,
    PublicTabsService? tabs,
    NavigationService? navigation,
  }) : _tabs = tabs ?? publicTabsService,
       _navigation = navigation ?? navigationService {
    _tabs.select(initial);
    _opened.add(initial);
  }

  final PublicTabsService _tabs;
  final NavigationService _navigation;

  @override
  List<ListenableServiceMixin> get listenableServices => [_tabs];

  static const List<TabBarItem> items = [
    (icon: Icons.home_outlined, label: 'Home'),
    (icon: Icons.chat_bubble_outline, label: 'Assistant'),
    (icon: Icons.person_outline, label: 'Profile'),
  ];

  final _opened = <PublicTab>{};

  int get index => _tabs.tab.index;

  /// Tabs are built the first time they are opened, then kept.
  bool isOpened(PublicTab tab) => _opened.contains(tab) || _tabs.tab == tab;

  @override
  void notifyListeners() {
    _opened.add(_tabs.tab);
    super.notifyListeners();
  }

  void select(int i) {
    final tab = PublicTab.values[i];
    _tabs.select(tab);
    _navigation.updateUrl(tab.path);
  }
}
