import 'package:emergencyhr_flutter/core/constants/colors.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/bottom_navigation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:stacked/stacked.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BottomNavigationViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            bottom: false,
            top: true,
            child: PersistentTabView(
              context,
              controller: model.controller,
              screens: model.children,
              items: [
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.home),
                  title: "Home",
                  activeColorPrimary: Colors.orange,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.candlestick_chart_sharp),
                  title: "Report",
                  activeColorPrimary: Colors.orange,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.person),
                  title: "Profile",
                  activeColorPrimary: Colors.orange,
                  inactiveColorPrimary: Colors.grey,
                ),
              ],
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: false,
              stateManagement: true,
              hideNavigationBarWhenKeyboardAppears: true,
              popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
              padding: const EdgeInsets.only(top: 8),
              backgroundColor: AppColors.primaryColor,
              isVisible: true,
              animationSettings: const NavBarAnimationSettings(
                navBarItemAnimation: ItemAnimationSettings(
                  duration: Duration(milliseconds: 10),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimationSettings(
                  animateTabTransition: true,
                  duration: Duration(milliseconds: 10),
                  screenTransitionAnimationType:
                      ScreenTransitionAnimationType.slide,
                ),
              ),
              confineToSafeArea: true,
              navBarHeight: kBottomNavigationBarHeight,
              navBarStyle: NavBarStyle.style9,
            ),
          ),
        );
      },
    );
  }
}
