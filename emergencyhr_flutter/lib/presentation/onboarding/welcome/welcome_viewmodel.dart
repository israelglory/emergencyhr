import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/local/intro_storage.dart';

/// End of the intro: create an account, sign in, or skip to Home.
class WelcomeViewModel extends BaseViewModel {
  WelcomeViewModel({
    NavigationService? navigation,
    IntroStorage? intro,
    EmergencySessionService? emergency,
    LocationService? location,
  }) : _navigation = navigation ?? navigationService,
       _introOverride = intro,
       _emergencyOverride = emergency,
       _locationOverride = location;

  final NavigationService _navigation;
  final IntroStorage? _introOverride;
  final EmergencySessionService? _emergencyOverride;
  final LocationService? _locationOverride;
  IntroStorage get _intro => _introOverride ?? introStorage;
  EmergencySessionService get _emergency =>
      _emergencyOverride ?? emergencySession;
  LocationService get _location => _locationOverride ?? locationService;

  static const title = 'Welcome to EmergencyHr';
  static const subtitle = 'An account lets you do more when it matters.';
  static const benefits = [
    'Alert up to three family members in one tap',
    'Use the Health Assistant',
    'Save medical details, only if you choose',
  ];
  static const emergencyNote = 'Emergency always works without an account.';

  /// Reaching Welcome means the intro has been seen.
  Future<void> onReady() => _intro.markIntroSeen();

  void createAccount() => _navigation.pushNamed<void>(AppRoutes.createAccount);

  void signIn() => _navigation.pushNamed<void>(AppRoutes.signIn);

  void skip() => _navigation.clearStackAndShow<void>(AppRoutes.home);

  /// Straight to Hospitals near you, no sign-in.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }
}
