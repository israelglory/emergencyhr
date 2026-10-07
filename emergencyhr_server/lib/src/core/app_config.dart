import 'dart:io';

import 'package:yaml/yaml.dart';

import 'app_settings_embedded.dart';

/// Which adapter an external service uses. `dev` adapters log to the console
/// so the app runs locally without paid accounts. `off` means the service is
/// not set up: nothing is sent and callers are told so.
enum AdapterKind { dev, live, off }

/// Which company's model powers the Health Assistant when `aiAdapter` is
/// live.
enum AiProviderKind { gemini, anthropic }

/// App settings and feature flags from `config/app_settings.yaml`, keyed by
/// run mode. Secrets never live here; they come from `passwords.yaml`.
class AppConfig {
  AppConfig({
    this.smsAdapter = AdapterKind.dev,
    this.whatsappAdapter = AdapterKind.dev,
    this.aiAdapter = AdapterKind.dev,
    this.aiProvider = AiProviderKind.gemini,
    this.aiFallbackModels = const [],
    this.smsSenderId = 'EmergencyHr',
    this.aiModel = 'gemini-2.5-flash',
    this.aiEffort = 'low',
    this.urbanSpeedKmh = 20,
    this.whatsappQuickUpdate = false,
    this.doctorsV2 = false,
    this.logOtpCodes = false,
    this.appBaseUrl = 'http://localhost:9998',
    this.firstAidPath = '../content/first_aid',
    this.adminEmails = const [],
  });

  final AdapterKind smsAdapter;
  final AdapterKind whatsappAdapter;
  final AdapterKind aiAdapter;
  final String smsSenderId;
  final AiProviderKind aiProvider;
  final String aiModel;

  /// Tried in order when [aiModel] is overloaded or rate limited.
  final List<String> aiFallbackModels;

  /// Thinking depth for Anthropic models: low, medium, high, xhigh or max.
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

  /// Accounts with these emails (lower case) are made platform admins, so
  /// a new server has its first admin. See `AdminBootstrap`.
  final List<String> adminEmails;

  /// The active config. Replaced at startup and in tests.
  static AppConfig instance = AppConfig();

  /// Where [load] found the settings file, or null when it used defaults.
  static String? loadedFrom;

  /// Every place [load] looked, for the start-up log.
  static List<String> searched = const [];

  static AppConfig load(
    String runMode, {
    String path = 'config/app_settings.yaml',
  }) {
    // Hosts may start the server from a different working directory, so
    // also look next to the server executable.
    final scriptDir = File.fromUri(Platform.script).parent;
    final candidates = [
      File(path),
      File('${scriptDir.path}/../$path'),
      File('${scriptDir.path}/$path'),
    ];
    searched = [for (final c in candidates) c.absolute.path];
    final file = candidates.where((c) => c.existsSync()).firstOrNull;
    // Without the file (e.g. on Serverpod Cloud), use the copy compiled into
    // the server from the same file.
    loadedFrom = file?.absolute.path ?? 'the copy built into the server';
    final root = loadYaml(file?.readAsStringSync() ?? embeddedAppSettings);
    final section = root is YamlMap ? root[runMode] : null;
    if (section is! YamlMap) return AppConfig();

    AdapterKind adapter(String key) => switch (section[key]) {
      'live' => AdapterKind.live,
      'off' => AdapterKind.off,
      _ => AdapterKind.dev,
    };
    final features = section['features'];
    bool flag(String key) => features is YamlMap && features[key] == true;

    return AppConfig(
      smsAdapter: adapter('smsAdapter'),
      whatsappAdapter: adapter('whatsappAdapter'),
      aiAdapter: adapter('aiAdapter'),
      smsSenderId: section['smsSenderId']?.toString() ?? 'EmergencyHr',
      aiProvider: section['aiProvider'] == 'anthropic'
          ? AiProviderKind.anthropic
          : AiProviderKind.gemini,
      aiModel: section['aiModel']?.toString() ?? 'gemini-2.5-flash',
      aiFallbackModels: [
        for (final m in (section['aiFallbackModels'] as YamlList?) ?? const [])
          m.toString(),
      ],
      aiEffort: section['aiEffort']?.toString() ?? 'low',
      urbanSpeedKmh: (section['urbanSpeedKmh'] as num?)?.toDouble() ?? 20,
      whatsappQuickUpdate: flag('whatsappQuickUpdate'),
      doctorsV2: flag('doctorsV2'),
      logOtpCodes: runMode == 'development' && section['logOtpCodes'] == true,
      appBaseUrl: section['appBaseUrl']?.toString() ?? 'http://localhost:9998',
      firstAidPath:
          section['firstAidPath']?.toString() ?? '../content/first_aid',
      adminEmails: [
        for (final e in (section['adminEmails'] as YamlList?) ?? const [])
          e.toString().trim().toLowerCase(),
      ],
    );
  }
}
