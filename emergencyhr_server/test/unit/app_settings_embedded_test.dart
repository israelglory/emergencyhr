import 'dart:io';

import 'package:emergencyhr_server/src/core/app_config.dart';
import 'package:emergencyhr_server/src/core/app_settings_embedded.dart';
import 'package:test/test.dart';

void main() {
  test('The built-in settings copy matches config/app_settings.yaml. If this '
      'fails, run `dart run tool/embed_app_settings.dart`.', () {
    final file = File('config/app_settings.yaml').readAsStringSync();
    expect(embeddedAppSettings, file);
  });

  test('Given no settings file, then production uses the built-in copy', () {
    final config = AppConfig.load('production', path: 'config/missing.yaml');
    expect(AppConfig.loadedFrom, 'the copy built into the server');
    expect(config.adminEmails, isNotEmpty);
    expect(config.aiAdapter, AdapterKind.live);
    expect(config.firstAidPath, 'web/app/assets/assets/first_aid');
  });
}
