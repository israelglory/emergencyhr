# Architecture

Emergencyhr answers one question in under two minutes: which hospital near
me can receive this patient right now?

## Packages

```
emergencyhr/
  emergencyhr_server/   Serverpod 4 server (PostgreSQL)
  emergencyhr_client/   generated client (never edit)
  emergencyhr_flutter/  one Flutter app for Android, iOS, web, macOS, Windows, Linux
  content/first_aid/    first-aid cards (JSON), read by server and bundled in the app
  docs/
```

## Server

Organised by feature under `lib/src/features/`. Each feature holds its
`models/*.spy.yaml`, endpoints, services and pure `logic/`.

| Feature | Responsibility |
| --- | --- |
| `auth` | Phone + SMS code sign-in (`PhoneIdp` on Serverpod auth core, JWT sessions), `AppUser`, roles, OTP challenges. |
| `profile` | Emergency contacts, encrypted medical profile, family alerts, data export and deletion, first-aid cards. |
| `facilities` | Listings, duplicate detection, profiles, documents (private storage), desk phone confirmation. |
| `status` | Live availability, audit log, freshness rules, WhatsApp quick update. |
| `onboarding` | Stages, go-live checklist, verification, invites, staff, claims, join requests. |
| `emergency` | Ranking, results stream, emergency sessions, wrong-status reports. |
| `assistant` | Health Assistant: red-flag rules, AI adapters, encrypted chat history. |
| `notifications` | SMS and WhatsApp adapters, notification log, stale reminders (future call). |
| `admin` | Queues, pipeline, directory, dashboards, suspensions, metrics, development seed data. |
| `doctors` | V2 schema only (profiles, availability, consultations, payments, payouts). |

Shared code in `lib/src/core/`: `AuthGuard` (the one authorization API),
typed `Errors`, `Validate`, `Clock`, `AppConfig`, `FieldCrypto`, `AuditLog`,
geo helpers.

### Rules

- **Thin endpoints.** Each method authenticates, authorizes with
  `AuthGuard`, validates, calls one service and returns. Every endpoint
  states who may call it. Deny by default.
- **Pure logic.** Ranking, freshness tiers, capability matching, duplicate
  detection, stage rules, the go-live checklist, opening hours and red-flag
  rules have no database access and are covered by fast unit tests.
- **Typed errors.** `NotAuthorizedException`, `ValidationException`,
  `NotFoundException`, `ConflictException`, `InvalidStateException`,
  `RateLimitedException`, each with a stable `AppErrorCode` and user-facing
  text.
- **Time.** Everything stored in UTC. Africa/Lagos (UTC+1) only for display
  and opening hours. `Clock` is injectable for tests.
- **Transactions** for multi-row writes (status + audit log, onboarding,
  claims, invites).
- **External services behind interfaces** with a live adapter and a dev
  adapter that logs: `SmsGateway` (Termii), `WhatsAppGateway` (Meta Cloud
  API), `AiService` (Anthropic), `RoutingService` (straight-line estimate).
  Chosen by `config/app_settings.yaml`.

## Key flows

### Emergency (no account needed)

1. Tapping Emergency starts the location lookup at once; it runs while the
   user picks an optional type. No location means the area picker, never a
   dead end.
2. `emergency.start` ranks facilities within 10 km (25 km if Tier 1 is
   empty) and creates an `EmergencySession` with a private access token.
3. Ranking (`emergency/logic/ranking.dart`):
   - Tier 1: live, accepting, confirmed within 30 min, full capability match.
   - Tier 2: confirmed 31 to 120 min ago with a match, or fresh with a
     partial match.
   - Tier 3: unverified, older than 120 min, not live, or no match.
   - Hidden: paused or flagged.
   - Within a tier: preferred unit (burns), then travel time, then beds.
4. `emergency.watch` streams a re-ranked list whenever a listed facility's
   status changes (`facility-status` channel). The app falls back to polling
   if the socket drops. Ages tick on the device and only ever downgrade.
5. Call or Directions records the action (time to action is the north star
   metric), then shows family alert, first aid and the report option.
6. The last results are cached on the device for poor connectivity.

### Status and trust

Only staff of a facility can set its status. Every change is logged with the
user and time. Three wrong-status reports in 24 hours flag a facility, which
hides it from Tier 1 until an admin reviews it. Stale data is never shown as
accepting.

### Onboarding

Stages: seeded, contacted, visited, staffTrained, verified, live (plus
paused and declined). `verified` is reached only by a platform admin
approving a submission (never the submitter). `live` is set automatically
when the go-live checklist is complete: verified, hospital admin accepted,
desk staff active, capabilities and hours, desk phone confirmed, training
done, first real status. Field agents onboard on site; hospitals self-serve
by searching first, then claiming or creating (duplicates are blocked by
name similarity plus distance).

### Health Assistant

Signed-in only. Two red-flag layers: deterministic rules on the user's
message (run before the model) and a structured flag line the model writes
first, which the server strips. Either one shows "Find emergency care now",
which opens the Emergency flow with the type filled in. Messages are
encrypted at rest and deletable.

### Reminders

A recurring future call (every 5 minutes, idempotent) texts desk staff when a
live facility's status is over 60 minutes old during opening hours (at most
once per hour per facility) and alerts the field agent when a facility in its
first 14 days goes 48 hours without an update.

## Flutter app

Stacked MVVM with a get_it locator. See `FLUTTER_CONVENTIONS.md`.
Four sections chosen by role: Public (everyone), Hospital desk, Field agent,
Admin. Guests land on Public; the Emergency button is first on the home
screen.

## Security and privacy

- Authorization on every endpoint, server side.
- OTP and invite tokens stored only as HMAC hashes; codes expire in 5 minutes,
  invites in 72 hours; rate limits on OTP, chat, reports, join requests,
  family alerts and invite acceptance.
- Medical profiles and chat messages encrypted with AES-256-GCM
  (`dataEncryptionKey`).
- Medical data saved only after an explicit consent step; users can export
  and delete their data.
- Logs never contain health data or message content.
