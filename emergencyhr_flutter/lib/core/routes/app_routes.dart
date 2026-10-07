import '../../data/models/shell_kind.dart';

/// Every screen's URL. Routes work as web URLs and deep links.
abstract final class AppRoutes {
  // Public
  static const home = '/';
  static const emergency = '/emergency';
  static const emergencyArea = '/emergency/area';
  static const emergencyType = '/emergency/type';
  static const emergencyResults = '/emergency/results';
  static const emergencyAfter = '/emergency/next';
  static const hospital = '/hospitals'; // /hospitals/:id
  static const firstAid = '/first-aid'; // /first-aid/:type
  static const assistant = '/assistant';
  static const profile = '/profile';
  static const medicalProfile = '/profile/medical';
  static const joinHospital = '/hospitals/join';
  static const joinRequest = '/hospitals/join/request';
  static const claimBase = '/hospitals/join/claim'; // /hospitals/join/claim/:id

  // Facility management (agents, hospital admins, platform admins)
  static const facilityNew = '/facilities/new';
  static const facilities =
      '/facilities'; // /facilities/:id/{edit,staff,practice}

  // Auth
  static const signIn = '/sign-in';
  static const createAccount = '/sign-in/create';
  static const resetPassword = '/sign-in/reset';
  static const acceptInvite = '/invite'; // /invite/:code

  // Shells
  static const desk = '/desk';
  static const agent = '/agent';
  static const admin = '/admin';

  // Debug only
  static const design = '/design';

  static String hospitalDetail(int id) => '$hospital/$id';
  static String claim(int id) => '$claimBase/$id';
  static String facilityEdit(int id) => '$facilities/$id/edit';
  static String facilityStaff(int id) => '$facilities/$id/staff';
  static String facilityPractice(int id) => '$facilities/$id/practice';
  static String agentFacility(int id) => '$agent/facilities/$id';
  static String firstAidCard(String type) => '$firstAid/$type';
  static String invite(String code) => '$acceptInvite/$code';

  static String signInWithNext(String next) => withNext(signIn, next);

  /// Adds the page to return to after signing in.
  static String withNext(String path, String? next) => next == null
      ? path
      : Uri(path: path, queryParameters: {'next': next}).toString();

  static String forShell(ShellKind shell) => switch (shell) {
    ShellKind.public => home,
    ShellKind.desk => desk,
    ShellKind.agent => agent,
    ShellKind.admin => admin,
  };
}
