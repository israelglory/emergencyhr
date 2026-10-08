import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/core/routes/app_router.dart';
import 'package:emergencyhr_flutter/data/api/emergency_api.dart';
import 'package:emergencyhr_flutter/data/api/facility_api.dart';
import 'package:emergencyhr_flutter/data/api/profile_api.dart';
import 'package:emergencyhr_flutter/data/api/status_api.dart';
import 'package:emergencyhr_flutter/data/api/telegram_api.dart';
import 'package:emergencyhr_flutter/data/local/emergency_cache.dart';
import 'package:emergencyhr_flutter/data/local/intro_storage.dart';
import 'package:emergencyhr_flutter/data/models/shell_kind.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

/// Stand-ins registered in the locator so real views can be pumped.
class TestServices {
  final emergencyApi = MockEmergencyApi();
  final statusApi = MockStatusApi();
  final telegramApi = MockTelegramApi();
  final facilityApi = MockFacilityApi();
  final profileApi = MockProfileApi();
  final cache = MockEmergencyCache();
  final session = MockSessionService();
  final location = MockLocationService();
  final calls = MockPhoneCallService();
  final launcher = MockLauncherService();
  final firstAid = MockFirstAidService();
  final intro = MockIntroStorage();
  final navigation = NavigationService();
  final snackbar = SnackbarService();
}

Future<TestServices> setUpTestLocator() async {
  await locator.reset();
  final s = TestServices();
  locator
    ..registerSingleton<NavigationService>(s.navigation)
    ..registerSingleton<SnackbarService>(s.snackbar)
    ..registerSingleton<BottomSheetService>(BottomSheetService(s.navigation))
    ..registerSingleton<DialogService>(DialogService(s.navigation))
    ..registerSingleton<LauncherService>(s.launcher)
    ..registerSingleton<PhoneCallService>(s.calls)
    ..registerSingleton<LocationService>(s.location)
    ..registerSingleton<EmergencyApi>(s.emergencyApi)
    ..registerSingleton<StatusApi>(s.statusApi)
    ..registerSingleton<TelegramApi>(s.telegramApi)
    ..registerSingleton<FacilityApi>(s.facilityApi)
    ..registerSingleton<ProfileApi>(s.profileApi)
    ..registerSingleton<EmergencyCache>(s.cache)
    ..registerSingleton<FirstAidService>(s.firstAid)
    ..registerSingleton<IntroStorage>(s.intro)
    ..registerSingleton<EmergencySessionService>(EmergencySessionService())
    ..registerSingleton<PublicTabsService>(PublicTabsService())
    ..registerSingleton<SessionService>(s.session);

  when(() => s.session.isSignedIn).thenReturn(false);
  when(() => s.session.currentUser).thenReturn(null);
  when(
    () => s.location.withoutPrompt(),
  ).thenAnswer((_) async => const LocationDenied());
  when(() => s.session.availableShells).thenReturn([ShellKind.public]);
  when(() => s.cache.save(any())).thenAnswer((_) async {});
  when(() => s.cache.read()).thenReturn(null);
  when(() => s.launcher.canComposeSms).thenReturn(false);
  when(() => s.intro.introSeen).thenReturn(false);
  when(() => s.intro.markIntroSeen()).thenAnswer((_) async {});
  when(
    () => s.statusApi.auditLog(
      any(),
      limit: any(named: 'limit'),
      offset: any(named: 'offset'),
    ),
  ).thenAnswer((_) async => ok(<AuditEntry>[]));
  when(() => s.launcher.canDialDirectly).thenReturn(true);
  when(() => s.telegramApi.connection()).thenAnswer(
    (_) async => ok(TelegramConnection(enabled: false, connected: false)),
  );
  when(() => s.firstAid.forType(any())).thenReturn(
    FirstAidCard(
      type: EmergencyType.roadAccident,
      title: 'Road accident',
      summary: 'Keep yourself safe first.',
      doSteps: ['Make sure the scene is safe.', 'Call 112.'],
      dontSteps: ['Do not move them if the neck is hurt.'],
      version: 1,
    ),
  );
  return s;
}

/// The real app shell: theme, router, navigator and snackbar keys.
Widget testApp({
  String initialRoute = AppRoutes.home,
  Brightness brightness = Brightness.light,
}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    navigatorKey: navigationService.navigatorKey,
    scaffoldMessengerKey: snackbarService.scaffoldMessengerKey,
    initialRoute: initialRoute,
    onGenerateInitialRoutes: AppRouter.onGenerateInitialRoutes,
    onGenerateRoute: AppRouter.onGenerateRoute,
  );
}

/// Wraps a single widget with the app theme.
Widget themed(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: brightness == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme,
    home: Scaffold(body: child),
  );
}
