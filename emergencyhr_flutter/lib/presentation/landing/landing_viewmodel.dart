import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import '../../data/models/pilot_areas.dart';
import 'landing_content.dart';

/// The public web landing page at `/`. Every button leads into the app;
/// Emergency never needs an account.
class LandingViewModel extends ReactiveViewModel {
  LandingViewModel({
    this.initialSection,
    SessionService? session,
    NavigationService? navigation,
    EmergencySessionService? emergency,
    LocationService? location,
    PhoneCallService? calls,
    LauncherService? launcher,
  }) : _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _emergencyOverride = emergency,
       _locationOverride = location,
       _callsOverride = calls,
       _launcherOverride = launcher;

  /// From the address, e.g. `/#faq`.
  final LandingSection? initialSection;
  final SessionService _session;
  final NavigationService _navigation;
  final EmergencySessionService? _emergencyOverride;
  final LocationService? _locationOverride;
  final PhoneCallService? _callsOverride;
  final LauncherService? _launcherOverride;
  EmergencySessionService get _emergency =>
      _emergencyOverride ?? emergencySession;
  LocationService get _location => _locationOverride ?? locationService;
  PhoneCallService get _calls => _callsOverride ?? phoneCallService;
  LauncherService get _launcher => _launcherOverride ?? launcherService;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  final scrollController = ScrollController();

  /// Anchors for the section links.
  final sectionKeys = {
    for (final s in LandingSection.values) s: GlobalKey(debugLabel: s.name),
  };

  // Header
  bool get isSignedIn => _session.isSignedIn;
  String get accountLabel => isSignedIn ? 'Open app' : 'Sign in';

  // Pilot areas
  List<({String name, String detail})> get areas => [
    for (final a in PilotAreas.all) (name: a.name, detail: a.description ?? ''),
  ];

  // FAQ: the first answer starts open.
  final Set<int> _openFaqs = {0};
  bool isFaqOpen(int index) => _openFaqs.contains(index);

  void toggleFaq(int index) {
    _openFaqs.contains(index) ? _openFaqs.remove(index) : _openFaqs.add(index);
    notifyListeners();
  }

  // Placeholder links stay plain text until they are filled in.
  VoidCallback? get onAppStore => _linkOrNull(LandingContent.appStoreLink);
  VoidCallback? get onGooglePlay => _linkOrNull(LandingContent.googlePlayLink);
  VoidCallback? get onPrivacy => _urlOrNull(LandingContent.privacyUrl);
  VoidCallback? get onTerms => _urlOrNull(LandingContent.termsUrl);
  VoidCallback? get onContact =>
      LandingContent.isPlaceholder(LandingContent.contactEmail)
      ? null
      : () => _launcher.openUrl(
          Uri(scheme: 'mailto', path: LandingContent.contactEmail),
        );

  VoidCallback? _linkOrNull(String value) => LandingContent.isPlaceholder(value)
      ? null
      : () => _launcher.openUrl(Uri.parse(value));

  VoidCallback? _urlOrNull(String? value) =>
      value == null ? null : () => _launcher.openUrl(Uri.parse(value));

  void onReady() {
    final section = initialSection;
    if (section == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollTo(section));
  }

  Future<void> scrollTo(LandingSection section) async {
    final context = sectionKeys[section]?.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  /// Straight to Hospitals near you, no sign-in.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }

  Future<void> call112() => _calls.callNumber(
    number: '112',
    title: 'Call 112',
    message: 'The national emergency number.',
  );

  /// Sign in, or Open app for people already signed in.
  void openAccount() => _navigation.pushNamed<void>(
    isSignedIn ? AppRoutes.home : AppRoutes.signIn,
  );

  Future<void> getTheApp() => scrollTo(LandingSection.app);

  void joinHospital() => _navigation.pushNamed<void>(AppRoutes.joinHospital);

  void requestVisit() => _navigation.pushNamed<void>(AppRoutes.joinRequest);

  void deskSignIn() => _navigation.pushNamed<void>(
    isSignedIn ? AppRoutes.desk : AppRoutes.signInWithNext(AppRoutes.desk),
  );

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
