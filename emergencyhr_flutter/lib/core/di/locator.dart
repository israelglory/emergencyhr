import 'package:get_it/get_it.dart';

import '../../data/api/admin_api.dart';
import '../../data/api/assistant_api.dart';
import '../../data/api/auth_api.dart';
import '../../data/api/emergency_api.dart';
import '../../data/local/emergency_cache.dart';
import '../../data/local/intro_storage.dart';
import '../../data/api/facility_api.dart';
import '../../data/api/onboarding_api.dart';
import '../../data/api/profile_api.dart';
import '../../data/api/staff_api.dart';
import '../../data/api/status_api.dart';
import '../../data/api/telegram_api.dart';
import '../services/services.dart';

final locator = GetIt.instance;

/// Registers every service and API. Viewmodels take their dependencies as
/// optional constructor arguments that default to these, so tests can pass
/// mocks.
Future<void> setupLocator() async {
  // UI services
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator.registerLazySingleton<BottomSheetService>(
    () => BottomSheetService(locator()),
  );
  locator.registerLazySingleton<DialogService>(() => DialogService(locator()));
  locator.registerLazySingleton<LauncherService>(() => LauncherService());
  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerLazySingleton<FilePickService>(() => FilePickService());
  locator.registerLazySingleton<PhoneCallService>(
    () => PhoneCallService(locator(), locator(), locator()),
  );

  // APIs (wrap the generated Serverpod client)
  locator.registerLazySingleton<AuthApi>(() => AuthApi());
  locator.registerLazySingleton<AdminApi>(() => AdminApi());
  locator.registerLazySingleton<AssistantApi>(() => AssistantApi());
  locator.registerLazySingleton<FacilityApi>(() => FacilityApi());
  locator.registerLazySingleton<EmergencyApi>(() => EmergencyApi());
  locator.registerLazySingleton<StatusApi>(() => StatusApi());
  locator.registerLazySingleton<TelegramApi>(() => TelegramApi());
  locator.registerLazySingleton<StaffApi>(() => StaffApi());
  locator.registerLazySingleton<OnboardingApi>(() => OnboardingApi());
  locator.registerLazySingleton<ProfileApi>(() => ProfileApi());

  // Local cache
  locator.registerLazySingleton<EmergencyCache>(() => EmergencyCache());
  locator.registerLazySingleton<IntroStorage>(() => IntroStorage());

  locator.registerLazySingleton<FirstAidService>(
    () => FirstAidService(locator()),
  );

  // App state
  locator.registerLazySingleton<EmergencySessionService>(
    () => EmergencySessionService(),
  );
  locator.registerLazySingleton<PublicTabsService>(() => PublicTabsService());
  locator.registerLazySingleton<SessionService>(
    () => SessionService(locator()),
  );
  locator.registerLazySingleton<AccessService>(
    () => AccessService(locator(), locator(), locator()),
  );
}

// UI services
NavigationService get navigationService => locator<NavigationService>();
PublicTabsService get publicTabsService => locator<PublicTabsService>();
SnackbarService get snackbarService => locator<SnackbarService>();
BottomSheetService get bottomSheetService => locator<BottomSheetService>();
DialogService get dialogService => locator<DialogService>();
LauncherService get launcherService => locator<LauncherService>();
PhoneCallService get phoneCallService => locator<PhoneCallService>();
LocationService get locationService => locator<LocationService>();
FilePickService get filePickService => locator<FilePickService>();

// APIs
AuthApi get authApi => locator<AuthApi>();
AdminApi get adminApi => locator<AdminApi>();
AssistantApi get assistantApi => locator<AssistantApi>();
FacilityApi get facilityApi => locator<FacilityApi>();
StatusApi get statusApi => locator<StatusApi>();
StaffApi get staffApi => locator<StaffApi>();
OnboardingApi get onboardingApi => locator<OnboardingApi>();

EmergencyApi get emergencyApi => locator<EmergencyApi>();
EmergencyCache get emergencyCache => locator<EmergencyCache>();
IntroStorage get introStorage => locator<IntroStorage>();
ProfileApi get profileApi => locator<ProfileApi>();
FirstAidService get firstAidService => locator<FirstAidService>();

// App state
EmergencySessionService get emergencySession =>
    locator<EmergencySessionService>();
SessionService get sessionService => locator<SessionService>();
AccessService get accessService => locator<AccessService>();
