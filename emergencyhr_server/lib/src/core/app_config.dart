import 'dart:io';

import 'package:yaml/yaml.dart';

/// Which adapter an external service uses. `dev` adapters log to the console
/// so the app runs locally without paid accounts.
enum AdapterKind { dev, live }

/// App settings and feature flags from `config/app_settings.yaml`, keyed by
/// run mode. Secrets never live here; they come from `passwords.yaml`.
class AppConfig {
  AppConfig({
    this.smsAdapter = AdapterKind.dev,
    this.whatsappAdapter = AdapterKind.dev,
    this.aiAdapter = AdapterKind.dev,
    this.smsSenderId = 'Emergencyhr',
    this.aiModel = 'claude-opus-5-5',
    this.aiEffort = 'low',
    this.urbanSpeedKmh = 20,
    this.whatsappQuickUpdate = false,
    this.doctorsV2 = false,
    this.logOtpCodes = false,
    this.appBaseUrl = 'http://localhost:9998',
    this.firstAidPath = '../content/first_aid',
  });

  final AdapterKind smsAdapter;
  final AdapterKind whatsappAdapter;
  final AdapterKind aiAdapter;
  final String smsSenderId;
  final String aiModel;

  /// Thinking depth for the assistant: low, medium, high, xhigh or max.
  final String aiEffort;

  /// Average urban driving speed used to estimate travel time.
  final double urbanSpeedKmh;

  final bool whatsappQuickUpdate;
  final bool doctorsV2;

  /// Public URL of the Flutter app, used in invite links and SMS.
  final String appBaseUrl;

  /// Folder with the reviewed first-aid cards (JSON).
  final String firstAidPath;

  /// Prints OTP codes to the server log. Only ever true in development.
  final bool logOtpCodes;

  /// The active config. Replaced at startup and in tests.
  static AppConfig instance = AppConfig();

  static AppConfig load(
    String runMode, {
    String path = 'config/app_settings.yaml',
  }) {
    final file = File(path);
    if (!file.existsSync()) return AppConfig();
    final root = loadYaml(file.readAsStringSync());
    final section = root is YamlMap ? root[runMode] : null;
    if (section is! YamlMap) return AppConfig();

    AdapterKind adapter(String key) =>
        section[key] == 'live' ? AdapterKind.live : AdapterKind.dev;
    final features = section['features'];
    bool flag(String key) => features is YamlMap && features[key] == true;

    return AppConfig(
      smsAdapter: adapter('smsAdapter'),
      whatsappAdapter: adapter('whatsappAdapter'),
      aiAdapter: adapter('aiAdapter'),
      smsSenderId: section['smsSenderId']?.toString() ?? 'Emergencyhr',
      aiModel: section['aiModel']?.toString() ?? 'claude-opus-5-5',
      aiEffort: section['aiEffort']?.toString() ?? 'low',
      urbanSpeedKmh: (section['urbanSpeedKmh'] as num?)?.toDouble() ?? 20,
      whatsappQuickUpdate: flag('whatsappQuickUpdate'),
      doctorsV2: flag('doctorsV2'),
      logOtpCodes: runMode == 'development' && section['logOtpCodes'] == true,
      appBaseUrl: section['appBaseUrl']?.toString() ?? 'http://localhost:9998',
      firstAidPath:
          section['firstAidPath']?.toString() ?? '../content/first_aid',
    );
  }
}
