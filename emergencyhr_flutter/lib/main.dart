import 'package:emergencyhr_flutter/app.dart';
import 'package:emergencyhr_flutter/core/di/app_globals.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:flutter/material.dart';

import 'client.dart';
import 'core/di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  setupLocator();
  await LocalStorageService.init();
  await AppGlobals.instance.init();
  runApp(const MyApp());
}
