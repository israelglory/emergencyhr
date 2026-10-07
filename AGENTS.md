# Emergencyhr (Flutter & Serverpod)

Emergencyhr tells people in a Nigerian emergency which hospital near them can
receive a patient right now. Hospitals publish live availability; the public
taps one Emergency button and sees hospitals ranked by fitness and freshness,
then calls or navigates in one tap. A Health Assistant answers general health
questions and routes red-flag cases into the emergency flow.

The product spec is `EMERGENCYHR_MVP_PROMPT.md`. Read these before changing
code:

- `docs/ARCHITECTURE.md`: server features, key flows, security.
- `docs/FLUTTER_CONVENTIONS.md`: app structure and rules. **No logic in
  views**: views only lay out widgets; everything else is in the viewmodel.
  Layers are View, ViewModel, Model, and APIs/services. No repository layer.
- `docs/DECISIONS.md`: choices made where the spec was open.
- `docs/RUNBOOK.md`: running, demo accounts, secrets, deployment.

Key places:

- Server features: `emergencyhr_server/lib/src/features/<feature>/` (models,
  endpoints, services, pure `logic/`). Shared helpers in `lib/src/core/`.
  Every endpoint authorizes with `AuthGuard` and stays thin.
- App: `emergencyhr_flutter/lib/presentation/<feature>/<screen>/` view and
  viewmodel pairs; APIs in `lib/data/api/`; services in `lib/core/services/`;
  shared widgets in `lib/core/widgets/`; routes in `lib/core/routes/`.
- First-aid cards: `content/first_aid/` (copied to
  `emergencyhr_flutter/assets/first_aid/`; CI checks they match).
- App settings and feature flags: `emergencyhr_server/config/app_settings.yaml`.
  After editing it, run `dart run tool/embed_app_settings.dart` in the
  server package (a test checks the built-in copy matches).

People sign in with email and password. In development, email codes print to
the server log and demo data is seeded automatically (accounts and the demo
password are in `docs/RUNBOOK.md`).

## Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

The user starts the server and Flutter app with `Serverpod App Studio`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start `Serverpod App Studio`. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the web browser.

`Serverpod App Studio` is an app that runs `serverpod start` in the background for the user. The user is not technically savvy, so explain everything in layman terms. NEVER ask the user to run command line tools. The user only knows the `Serverpod App Studio`.

In `Serverpod App Studio` the user can:

- Start the backend and the app.
- Do a hard restart.

If you cannot access the `serverpod` and `dart` MCP servers, STOP and tell the user how to enable them.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `emergencyhr_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package, `flutter test` in the Flutter package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `emergencyhr_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.
