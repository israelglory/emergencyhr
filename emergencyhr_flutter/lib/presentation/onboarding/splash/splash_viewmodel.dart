import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/local/intro_storage.dart';

/// Startup on phones and computers: first launch goes to the intro, later
/// launches and signed-in people go straight to Home.
class SplashViewModel extends BaseViewModel {
  SplashViewModel({
    SessionService? session,
    IntroStorage? intro,
    NavigationService? navigation,
  }) : _session = session ?? sessionService,
       _intro = intro ?? introStorage,
       _navigation = navigation ?? navigationService;

  final SessionService _session;
  final IntroStorage _intro;
  final NavigationService _navigation;

  static const appName = 'EmergencyHr';
  static const tagline = 'When every minute matters';

  String get nextRoute => _session.isSignedIn || _intro.introSeen
      ? AppRoutes.home
      : AppRoutes.intro;

  /// Moves on as soon as the first frame is up; the native splash already
  /// covered the start-up work.
  void onReady() => WidgetsBinding.instance.addPostFrameCallback(
    (_) => _navigation.clearStackAndShow<void>(nextRoute),
  );
}
