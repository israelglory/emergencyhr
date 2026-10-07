import 'dart:io';

/// Copies config/app_settings.yaml into a Dart file compiled into the
/// server, for hosts that do not ship the config folder (Serverpod Cloud).
/// Run from the server folder: `dart run tool/embed_app_settings.dart`.
/// The Serverpod Cloud deploy runs it first (see scloud.yaml).
void main() {
  final yaml = File('config/app_settings.yaml').readAsStringSync();
  if (yaml.contains("'''")) {
    stderr.writeln("app_settings.yaml must not contain three quotes (''').");
    exit(1);
  }
  File('lib/src/core/app_settings_embedded.dart').writeAsStringSync(
    '// Copy of config/app_settings.yaml compiled into the server, for hosts\n'
    '// that do not ship the config folder (Serverpod Cloud). Do not edit:\n'
    '// change config/app_settings.yaml and run\n'
    '// `dart run tool/embed_app_settings.dart` (the deploy does this).\n'
    '\n'
    "const embeddedAppSettings = r'''\n$yaml''';\n",
  );
  stdout.writeln('Embedded config/app_settings.yaml.');
}
