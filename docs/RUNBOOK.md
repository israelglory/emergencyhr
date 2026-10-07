# Runbook

## Run it locally

Open **Serverpod App Studio** and press Start. It runs the database, the
server and the Flutter web app, and reloads them when files change. After
adding packages or changing native settings, use **Hard restart**.

- App (web): http://localhost:9998
- API server: http://localhost:8080
- Web server: http://localhost:8082

In development the server:

- applies database migrations on start,
- loads fictional Lagos pilot data into an empty database and re-stamps the
  demo status ages on every start, so every freshness tier is present,
- prints email verification codes, SMS messages, reminders and WhatsApp
  messages to the server log instead of sending them,
- uses Gemini for the Health Assistant (`geminiApiKey` in
  `config/passwords.yaml`). Set `aiAdapter: dev` for a fixed test answer
  without an API key.

### Demo accounts

Sign in with these emails. Every demo account uses the password
**Emergency123!**.

| Role | Email |
| --- | --- |
| Platform admin | admin@emergencyhr.test |
| Field agent (Ikeja, Yaba, Ikorodu) | agent.ikeja@emergencyhr.test |
| Field agent (Surulere, Lekki, Victoria Island) | agent.lekki@emergencyhr.test |
| Hospital admin, Seed Hospital 01 | admin01@emergencyhr.test |
| Hospital admin, Seed Hospital 02 | admin02@emergencyhr.test |
| Desk staff, Seed Hospital 01 / 02 / 03 | desk01@ / desk02@ / desk03@emergencyhr.test |
| Public user (has a pending claim) | public@emergencyhr.test |

New accounts can be created in the app. In development the email
verification code is printed in the server log instead of being emailed.

The seed has 30 facilities across every onboarding stage and freshness tier,
one flagged facility (Seed Hospital 13), one quiet newcomer (Seed Hospital
14), one pending claim and two join requests. To reseed, empty the database
(App Studio: reset database) and start again.

## Tests

```
cd emergencyhr_server && dart test        # embedded PostgreSQL, no Docker
cd emergencyhr_flutter && flutter test    # includes golden images on macOS
```

CI (`.github/workflows/`) runs analysis with `--fatal-infos`, formatting,
both test suites (goldens excluded), and builds for Android, web and Linux.

## Configuration

`emergencyhr_server/config/app_settings.yaml`, per run mode:

| Key | Meaning |
| --- | --- |
| `smsAdapter`, `whatsappAdapter`, `aiAdapter` | `dev` logs, `live` calls the provider, `off` sends nothing and tells the user (staging and production use `off` for SMS and WhatsApp until accounts exist). |
| `smsSenderId` | Termii sender ID. |
| `aiProvider` | `gemini` (default) or `anthropic`. |
| `aiModel`, `aiFallbackModels` | Health Assistant model (default `gemini-2.5-flash`) and models to try when it is overloaded (`gemini-flash-latest`). |
| `aiEffort` | Thinking effort for Anthropic models only. |
| `urbanSpeedKmh` | Average urban speed for travel time estimates. |
| `appBaseUrl` | Public URL of the web app, used in invite links. |
| `firstAidPath` | Folder with the first-aid cards. |
| `adminEmails` | Accounts made platform admins (staging and production), so a new server has its first admin. Only adds the role. |
| `features.whatsappQuickUpdate`, `features.doctorsV2` | Feature flags. |

### Secrets (`config/passwords.yaml` or `SERVERPOD_PASSWORD_<name>` env vars)

| Name | Needed for |
| --- | --- |
| `database`, `serviceSecret` | Serverpod. |
| `jwtHmacSha512PrivateKey`, `jwtRefreshTokenHashPepper` | Sign-in sessions. |
| `emailSecretHashPepper` | Email sign-in (hashing codes and passwords). Random string. |
| `otpHashPepper` | Hashing desk-phone codes, invite and emergency session tokens. Random string. |
| `dataEncryptionKey` | Encrypting medical profiles and chat. 32 random bytes, base64. Losing it makes that data unreadable; rotate with a migration. |
| `termiiApiKey` | Live SMS. |
| `whatsappAccessToken`, `whatsappPhoneNumberId` | Live WhatsApp messages. |
| `whatsappAppSecret`, `whatsappVerifyToken` | WhatsApp webhook verification. |
| `geminiApiKey` | Live Health Assistant with Gemini (set for development). Use a paid (billing enabled) key before real users: on the free tier Google may use prompts to improve its products. |
| `anthropicApiKey` | Live Health Assistant with Anthropic, if `aiProvider: anthropic`. |

Generate random values with `openssl rand -base64 32`.

### WhatsApp quick update

Point the Meta webhook at `https://<web server host>/webhooks/whatsapp`, set
the verify token to `whatsappVerifyToken`, subscribe to `messages`, and turn
on `features.whatsappQuickUpdate`. Staff text `A` (accepting), `P` (paused)
or `C` (still accurate) from their registered number.

## Deploy

### Sign-in emails

Sign-in uses email and password with an emailed code at registration and
for password resets. On **Serverpod Cloud** these emails are sent by
Serverpod at no extra cost. A self-hosted server must replace
`ServerpodCloudEmailIdpConfig` in `lib/server.dart` with
`EmailIdpConfigFromPasswords` and provide `sendRegistrationVerificationCode`
and `sendPasswordResetVerificationCode` callbacks for its own email provider.

### Serverpod Cloud

Live project: `emergencyhr`. Web app https://emergencyhr.serverpod.space,
API https://emergencyhr.api.serverpod.space.

1. Sign in once: `scloud auth login`. The repository is already linked
   (`emergencyhr_server/scloud.yaml`).
2. From the repository root: `scloud deploy`. The pre-deploy steps in
   `scloud.yaml` run `serverpod generate` and build the Flutter web app into
   `emergencyhr_server/web/app`, which the server hosts. Migrations apply on
   start.
3. Secrets: Serverpod Cloud manages the database, service and sign-in keys.
   The app's own secrets (`otpHashPepper`, `dataEncryptionKey`,
   `geminiApiKey`) were set with `scloud password set <name> --from-file
   <file>`; copies are in the local `config/passwords.yaml` under
   `production`. Keep a safe copy of `dataEncryptionKey`.
4. Production reads first-aid cards from `web/app/assets/assets/first_aid`
   (`firstAidPath`), because only the server folder is uploaded.
   Cloud does not ship `config/` either: settings come from the copy built
   into the server. After editing `config/app_settings.yaml` locally, run
   `dart run tool/embed_app_settings.dart` in `emergencyhr_server` (the
   deploy also does it). Check the start-up log line "App settings loaded
   from ..." after each deploy.
5. Future calls are off on the Cloud project, so the 5-minute reminders are
   not scheduled (the server logs a warning and carries on). They only send
   SMS and WhatsApp, which are off in production.
6. Own domain: `scloud domain attach`, then set `appBaseUrl` in
   `config/app_settings.yaml` and deploy again.

### Self-hosted Docker

1. Build the server image from `emergencyhr_server/` (the generated
   `Dockerfile`), including `content/first_aid` in the image and setting
   `firstAidPath` accordingly.
2. Run PostgreSQL 16 (see `docker-compose.yaml` for development settings).
3. Provide `config/production.yaml` and secrets as
   `SERVERPOD_PASSWORD_<name>` environment variables.
4. Start with `--mode production --apply-migrations`.
5. Put TLS in front (Caddy, nginx or a load balancer). Set `allowedOrigins`
   and `authCookie` in `production.yaml` when serving the web app from a
   different origin.

### Flutter web hosting

Serve the web app over **HTTPS**. Browsers only share location with secure
pages (and `localhost` during development). On plain HTTP every visitor goes
straight to the area picker.

The server can serve the web app: `flutter build web` output in
`emergencyhr_server/web/app` is served at `/` (App Studio's build script
does this). Or host `build/web` on any static host and set
`SERVER_URL` with `--dart-define=SERVER_URL=https://api.example.com/`.

## Performance checks

- **Results in under 3 seconds.** Ranking uses one bounding-box query plus
  two batched queries (statuses, capabilities), no per-facility queries.
  Measure with the server log's request duration for `emergency.start`, or
  in Serverpod Insights, against the seed data.
- **Cold start to Emergency button under 2 seconds.** The home screen does
  not wait for the network: the signed-in user loads in the background.
  Measure on a mid-range Android phone with
  `flutter run --profile --trace-startup` and read `timeToFirstFrameMicros`
  in `build/start_up_info.json`.

Neither target has been measured on a device yet.

## App icon and launch screen

The images live in `emergencyhr_flutter/assets/images/brand/`. After
changing them, regenerate from the `emergencyhr_flutter` folder:

- `dart run flutter_launcher_icons` (settings in `flutter_launcher_icons.yaml`).
  Afterwards set `ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS`
  back to `YES` in `ios/Runner.xcodeproj/project.pbxproj`; the tool writes a
  wrong value there.
- `dart run flutter_native_splash:create` (settings in
  `flutter_native_splash.yaml`).

Reinstall the app on the phone to see a new icon or launch screen.

## Importing hospitals

1. Refresh the data (optional): in `emergencyhr_server`, run
   `dart run tool/hospital_data/fetch_grid3.dart`. It writes
   `tool/hospital_data/lagos_hospitals.csv` and `ogbomoso_hospitals.csv`.
2. In the app, Admin, Directory, Import hospitals: choose a CSV file. The
   preview shows how many will be added, already imported, possible
   duplicates and unusable rows. Then Import.
3. Imported hospitals are unverified. Verify each in the Directory once
   checked. Importing the same file again is safe.

CSV columns: `source_ref,name,type,address,area,lat,lng` (type is public,
private or mission). Other sources work too if they use these columns and a
stable `source_ref`; credit the source as its licence requires.

