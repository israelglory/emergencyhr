import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/cache_busting.dart';
import 'src/core/app_config.dart';
import 'src/features/admin/seed/seeder.dart';
import 'src/features/auth/phone_idp.dart';
import 'src/features/notifications/reminder_future_call.dart';
import 'src/web/routes/whatsapp_webhook_route.dart';
import 'src/generated/serverpod.dart';
import 'src/web/routes/app_config_route.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // App settings and feature flags for the current run mode.
  AppConfig.instance = AppConfig.load(pod.runMode);

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Phone number + SMS code sign-in. Codes are logged to the server
      // console in development (see config/app_settings.yaml).
      const PhoneIdpConfig(),
    ],
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // WhatsApp quick status updates (behind the whatsappQuickUpdate flag).
  pod.webServer.addRoute(WhatsAppWebhookRoute(), '/webhooks/whatsapp');

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();

  // Stale-status reminders and early-health alerts every 5 minutes. The
  // identifier replaces any schedule left from a previous start, and the
  // call itself is idempotent.
  await pod.futureCalls.cancel(ReminderFutureCall.identifier);
  await pod.futureCalls
      .callRecurring(identifier: ReminderFutureCall.identifier)
      .every(const Duration(minutes: 5))
      .reminder
      .run();

  // Development only: load the fictional Lagos pilot data into an empty
  // database, and keep the seed status ages covering every freshness tier.
  if (pod.runMode == ServerpodRunMode.development) {
    final session = await pod.createSession();
    try {
      await Seeder.run(session);
    } catch (e, st) {
      session.log(
        'Seeding failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
    } finally {
      await session.close();
    }
  }
}
