import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'client.dart';
import 'core/di/locator.dart';
import 'data/local/base/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Future.wait([LocalStorageService.init(), initializeClient()]);
  await setupLocator();
  // Loads the signed-in user in the background so the Emergency button is
  // on screen immediately.
  unawaited(sessionService.init());
  unawaited(firstAidService.init());
  runApp(const MyApp());
}
