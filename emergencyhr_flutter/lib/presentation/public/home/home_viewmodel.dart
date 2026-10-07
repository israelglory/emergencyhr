import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/pilot_areas.dart';
import '../../../data/models/shell_kind.dart';

typedef HomeShortcut = ({
  String title,
  String subtitle,
  IconData icon,
  VoidCallback onTap,
});

class HomeViewModel extends ReactiveViewModel {
  HomeViewModel({
    SessionService? session,
    NavigationService? navigation,
    PhoneCallService? calls,
    EmergencySessionService? emergency,
    LocationService? location,
    PublicTabsService? tabs,
  }) : _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _calls = calls ?? phoneCallService,
       _emergency = emergency ?? emergencySession,
       _location = location ?? locationService,
       _tabs = tabs ?? publicTabsService;

  final EmergencySessionService _emergency;
  final LocationService _location;
  final SessionService _session;
  final NavigationService _navigation;
  final PhoneCallService _calls;
  final PublicTabsService _tabs;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  static const appName = 'EmergencyHr';
  static const disclaimer =
      'EmergencyHr is an information and navigation service, not a medical '
      'provider. If in doubt, call 112.';
  static const joinPrompt = 'Work at a hospital? ';
  static const joinLink = 'Join EmergencyHr';

  String? _areaName;

  bool get isSignedIn => _session.isSignedIn;

  String? get _name {
    final name = _session.currentUser?.user.name?.trim();
    return name == null || name.isEmpty ? null : name;
  }

  String get greeting {
    final name = _name;
    return isSignedIn && name != null
        ? 'Hi ${name.split(' ').first}'
        : 'Welcome';
  }

  /// Two letters for the account button, e.g. "AO".
  String get initials => Formatters.initials(
    _session.currentUser?.user.name,
    _session.currentUser?.user.email,
  );

  /// The nearest pilot area, only when location was already allowed.
  String? get locationLabel => _areaName;

  List<HomeShortcut> get quickHelp => [
    (
      title: 'First aid',
      subtitle: 'Help while you wait',
      icon: Icons.medical_services_outlined,
      onTap: () => _navigation.pushNamed<void>(AppRoutes.firstAid),
    ),
    (
      title: 'Health Assistant',
      subtitle: 'Ask a health question',
      icon: Icons.chat_bubble_outline,
      onTap: () => _tabs.select(PublicTab.assistant),
    ),
    (
      title: 'Contacts',
      subtitle: 'Who we alert',
      icon: Icons.group_outlined,
      onTap: () => _tabs.select(PublicTab.profile),
    ),
  ];

  bool get showWork => work.isNotEmpty;

  List<HomeShortcut> get work => [
    for (final shell in _session.availableShells)
      if (shell != ShellKind.public)
        (
          title: shell.label,
          subtitle: switch (shell) {
            ShellKind.desk => 'Update your hospital status',
            ShellKind.agent => 'Onboard hospitals',
            ShellKind.admin => 'Verify hospitals and review reports',
            ShellKind.public => '',
          },
          icon: switch (shell) {
            ShellKind.desk => Icons.local_hospital_outlined,
            ShellKind.agent => Icons.assignment_ind_outlined,
            ShellKind.admin => Icons.verified_user_outlined,
            ShellKind.public => Icons.home_outlined,
          },
          onTap: () => _navigation.pushNamed<void>(AppRoutes.forShell(shell)),
        ),
  ];

  Future<void> onReady() async {
    final result = await _location.withoutPrompt();
    if (result is LocationFound) {
      _areaName = PilotAreas.nearest(result.lat, result.lng).name;
      notifyListeners();
    }
  }

  /// Starts the location lookup straight away and opens Hospitals near you.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }

  void signIn() => _navigation.pushNamed<void>(AppRoutes.signIn);

  void openAccount() => _tabs.select(PublicTab.profile);

  void joinAsHospital() => _navigation.pushNamed<void>(AppRoutes.joinHospital);

  Future<void> call112() => _calls.callNumber(
    number: '112',
    title: 'Call 112',
    message: 'The national emergency number.',
  );
}
