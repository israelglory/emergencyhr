import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/presentation/auth/login/login_view.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/bottom_navigation_view.dart';
import 'package:stacked/stacked.dart';

class SplashScreenVM extends BaseViewModel {
  Future<void> initializeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final isAuthenticated =
        appGlobals.token != null && appGlobals.token!.isNotEmpty;
    if (!isAuthenticated) {
      navigationService.pushReplacement(const LoginView());
    } else {
      authRepo.getCurrentUser();
      navigationService.pushReplacement(const BottomNavigationView());
    }
  }
}
