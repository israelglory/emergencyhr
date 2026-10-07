import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

typedef IntroSlide = ({String image, String title, String body});

/// Three first-launch slides. Emergency is always one tap away.
class IntroViewModel extends BaseViewModel {
  IntroViewModel({
    NavigationService? navigation,
    EmergencySessionService? emergency,
    LocationService? location,
  }) : _navigation = navigation ?? navigationService,
       _emergencyOverride = emergency,
       _locationOverride = location;

  final NavigationService _navigation;
  final EmergencySessionService? _emergencyOverride;
  final LocationService? _locationOverride;
  EmergencySessionService get _emergency =>
      _emergencyOverride ?? emergencySession;
  LocationService get _location => _locationOverride ?? locationService;

  final pageController = PageController();

  static const slides = <IntroSlide>[
    (
      image: AppAssets.intro1,
      title: 'Find a hospital that can take you',
      body:
          'Tap Emergency and see nearby hospitals with free beds and a doctor '
          'on duty, confirmed by the hospital itself.',
    ),
    (
      image: AppAssets.intro2,
      title: 'Know how fresh the information is',
      body:
          'Every hospital status shows when it was last confirmed. If it is '
          'not recent, we tell you to call first.',
    ),
    (
      image: AppAssets.intro3,
      title: 'Help on the way',
      body:
          'Text your family where you are going, follow simple first aid '
          'steps, and ask the Health Assistant a question.',
    ),
  ];

  int _page = 0;
  int get page => _page;
  bool get isLast => _page == slides.length - 1;
  String get primaryLabel => isLast ? 'Get started' : 'Next';

  void onPageChanged(int index) {
    _page = index;
    notifyListeners();
  }

  /// Next slide, or Welcome from the last one.
  Future<void> next() async {
    if (isLast) return getStarted();
    if (pageController.hasClients) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else {
      onPageChanged(_page + 1);
    }
  }

  Future<void> getStarted() => _navigation.pushNamed<void>(AppRoutes.welcome);

  Future<void> skip() => getStarted();

  /// Straight to Hospitals near you, no sign-in.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
