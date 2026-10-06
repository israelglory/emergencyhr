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
- prints SMS codes, invites, reminders and WhatsApp messages to the server
  log instead of sending them,
- uses the development Health Assistant (no API key needed).

### Demo accounts

Sign in with these numbers. The 6-digit code appears in the server log as
`[DEV SMS] to +234...: 123456 is your Emergencyhr code`.

| Role | Phone |
| --- | --- |
| Platform admin | 0800 000 0001 |
| Field agent (Ikeja, Yaba, Ikorodu) | 0800 000 0002 |
| Field agent (Surulere, Lekki, Victoria Island) | 0800 000 0003 |
| Hospital admin, Seed Hospital 01 | 0800 000 0004 |
| Hospital admin, Seed Hospital 02 | 0800 000 0005 |
| Desk staff, Seed Hospital 01 / 02 / 03 | 0800 000 0006 / 0007 / 0008 |
| Public user (has a pending claim) | 0800 000 0010 |

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
| `smsAdapter`, `whatsappAdapter`, `aiAdapter` | `dev` logs, `live` calls the provider. |
| `smsSenderId` | Termii sender ID. |
| `aiModel`, `aiEffort` | Health Assistant model (default `claude-opus-5-5`) and effort (`low`). |
| `urbanSpeedKmh` | Average urban speed for travel time estimates. |
| `appBaseUrl` | Public URL of the web app, used in invite links. |
| `firstAidPath` | Folder with the first-aid cards. |
| `features.whatsappQuickUpdate`, `features.doctorsV2` | Feature flags. |

### Secrets (`config/passwords.yaml` or `SERVERPOD_PASSWORD_<name>` env vars)

| Name | Needed for |
| --- | --- |
| `database`, `serviceSecret` | Serverpod. |
| `jwtHmacSha512PrivateKey`, `jwtRefreshTokenHashPepper` | Sign-in sessions. |
| `otpHashPepper` | Hashing SMS codes, invite and emergency session tokens. Random string. |
| `dataEncryptionKey` | Encrypting medical profiles and chat. 32 random bytes, base64. Losing it makes that data unreadable; rotate with a migration. |
| `termiiApiKey` | Live SMS. |
| `whatsappAccessToken`, `whatsappPhoneNumberId` | Live WhatsApp messages. |
| `whatsappAppSecret`, `whatsappVerifyToken` | WhatsApp webhook verification. |
| `anthropicApiKey` | Live Health Assistant. |

Generate random values with `openssl rand -base64 32`.

### WhatsApp quick update

Point the Meta webhook at `https://<web server host>/webhooks/whatsapp`, set
the verify token to `whatsappVerifyToken`, subscribe to `messages`, and turn
on `features.whatsappQuickUpdate`. Staff text `A` (accepting), `P` (paused)
or `C` (still accurate) from their registered number.

## Deploy

### Serverpod Cloud

1. `scloud launch` from the repository root and follow the prompts.
2. Set the secrets above with `scloud password set <name> <value>`.
3. Set `appBaseUrl` for production in `config/app_settings.yaml`.
4. Copy `content/first_aid/` next to the server or set `firstAidPath`.
5. `scloud deploy`. Migrations apply on deploy.

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
