import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

class NotFoundViewModel extends BaseViewModel {
  NotFoundViewModel({
    NavigationService? navigation,
    EmergencySessionService? emergency,
    LocationService? location,
  }) : _navigation = navigation ?? navigationService,
       _emergency = emergency ?? emergencySession,
       _location = location ?? locationService;

  final NavigationService _navigation;
  final EmergencySessionService _emergency;
  final LocationService _location;

  static const code = '404';
  static const title = 'Page not found';
  static const message = 'This page does not exist or has moved.';

  void goHome() => _navigation.clearStackAndShow<void>(AppRoutes.home);

  /// Straight to Hospitals near you, like the Home Emergency button.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.clearStackAndShow<void>(AppRoutes.home);
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }
}
