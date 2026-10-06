import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/homepage/home_view.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/profile/profile_view.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/report/report_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:stacked/stacked.dart';

class BottomNavigationViewmodel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int value) {
    _currentIndex = value;
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  final List<Widget> _children = [
    const HomeView(),
    const ReportView(isBack: false),
    const ProfileView(),
  ];
  List<Widget> get children => _children;

  updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  resetValues() {
    _currentIndex = 0;
  }
}
