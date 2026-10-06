import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
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
  }) : _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _calls = calls ?? phoneCallService,
       _emergency = emergency ?? emergencySession,
       _location = location ?? locationService;

  final EmergencySessionService _emergency;
  final LocationService _location;
  final SessionService _session;
  final NavigationService _navigation;
  final PhoneCallService _calls;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  static const disclaimer =
      'Emergencyhr is an information and navigation service, not a medical '
      'provider. If in doubt, call 112.';

  String get accountActionLabel => _session.isSignedIn ? 'Account' : 'Sign in';

  IconData get accountActionIcon => _session.isSignedIn
      ? Icons.account_circle_outlined
      : Icons.login_outlined;

  List<HomeShortcut> get shortcuts => [
    (
      title: 'Health Assistant',
      subtitle: 'Ask a general health question',
      icon: Icons.chat_bubble_outline,
      onTap: () => _navigation.pushNamed<void>(AppRoutes.assistant),
    ),
    (
      title: 'First aid',
      subtitle: 'Step-by-step help while you wait',
      icon: Icons.medical_services_outlined,
      onTap: () => _navigation.pushNamed<void>(AppRoutes.firstAid),
    ),
    (
      title: 'Profile',
      subtitle: 'Emergency contacts and medical details',
      icon: Icons.person_outline,
      onTap: () => _navigation.pushNamed<void>(AppRoutes.profile),
    ),
  ];

  bool get showWorkShortcuts => workShortcuts.isNotEmpty;

  List<HomeShortcut> get workShortcuts => [
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
            ShellKind.admin => Icons.admin_panel_settings_outlined,
            ShellKind.public => Icons.home_outlined,
          },
          onTap: () => _navigation.pushNamed<void>(AppRoutes.forShell(shell)),
        ),
  ];

  /// Starts the location lookup straight away, so it runs while the user
  /// picks the emergency type.
  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }

  void openAccount() => _navigation.pushNamed<void>(
    _session.isSignedIn ? AppRoutes.profile : AppRoutes.signIn,
  );

  void joinAsHospital() => _navigation.pushNamed<void>(AppRoutes.joinHospital);

  Future<void> call112() => _calls.callNumber(
    number: '112',
    title: 'Call 112',
    message: 'The national emergency number.',
  );
}
