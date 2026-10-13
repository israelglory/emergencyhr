import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// The live EmergencyHr server on Serverpod Cloud.
const liveServerUrl = 'https://emergencyhr.api.serverpod.space/';

/// Which server the app talks to:
/// - `--dart-define=SERVER_URL=...` always wins (e.g. a phone testing a
///   server on this computer: use the computer's IP address).
/// - Android and iOS use the live server, so phone builds work anywhere.
/// - Web reads the address the server it was loaded from provides; desktop
///   reads assets/config.json (localhost while developing).
final serverUrl = _serverUrl();

Future<String> _serverUrl() async {
  const fromDefine = String.fromEnvironment('SERVER_URL');
  if (fromDefine.isNotEmpty) return fromDefine;
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    return liveServerUrl;
  }
  return getServerUrl();
}

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

Future<void> initializeClient() async {
  client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  unawaited(client.auth.initialize());
}
