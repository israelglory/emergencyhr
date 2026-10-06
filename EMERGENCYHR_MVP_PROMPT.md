# Build the Emergencyhr MVP (Serverpod + Flutter, all platforms)

You are a senior Flutter and Dart backend engineer. Build the complete, production-quality MVP of **Emergencyhr**, end to end: Serverpod backend, PostgreSQL schema and migrations, generated client, and one Flutter app that runs on Android, iOS, web, macOS, Windows and Linux.

Work in the phases listed at the end. After each phase, run the app and the tests, fix what fails, and summarise what you built before moving on. Do not stop at scaffolding or leave TODOs in place of features that are in scope.

---

## 0. Before you write any code: learn the existing Flutter project

A Flutter project already exists. It is set up with the **Stacked architecture (MVVM)** and has a deliberate folder structure, many sample views/viewmodels/services, and shared widgets. Do not create a new Flutter project and do not restructure the existing one.

1. Read the whole Flutter project first: `pubspec.yaml`, `analysis_options.yaml`, the Stacked app definition (the `@StackedApp` file, typically `lib/app/app.dart`), generated locator/router/dialog/bottom-sheet files, every folder under `lib/`, and every sample.
2. Write `docs/FLUTTER_CONVENTIONS.md` summarising what you learned: folder layout, naming (files, classes, viewmodels, services), how views and viewmodels are paired, how services are registered and injected, how navigation, dialogs and bottom sheets are triggered, how errors and loading (`busy`) states are handled, how the theme and shared widgets are used, and how tests are written. Every later decision must follow this document.
3. Treat the samples as the reference implementation of the house style. Copy their patterns, not just their syntax.
4. **Do not delete the samples.** At the end of the build, list in `docs/CLEANUP.md` every sample file that is safe to remove, so the owner can delete them in one pass.
5. If the existing structure conflicts with anything in this prompt, the existing structure wins. Record the conflict and your resolution in `docs/DECISIONS.md`.

---

## 1. Product in one paragraph

In a Nigerian emergency, people lose 30 to 60+ minutes driving between hospitals that are full, have no doctor, or cannot handle the case. Emergencyhr answers one question in under 2 minutes: **which hospital near me can receive this patient right now?** Hospitals publish live availability (accepting or paused, beds, doctor on duty, capabilities). The public taps one Emergency button, sees hospitals ranked by fitness and freshness, and calls or navigates in one tap. A Medical AI assistant answers general health questions and routes red-flag cases into the emergency flow.

Tagline: "When every minute matters, Emergencyhr tells you where to go."

The single most important thing in this product is the emergency flow. If you have to trade quality anywhere, never trade it there.

---

## 2. Tech stack and ground rules

- **Backend:** Serverpod (latest stable release; check pub.dev and serverpod.dev docs for the current version and API before writing code, do not rely on memory for Serverpod APIs). PostgreSQL. Redis only if needed.
- **Client:** the existing Flutter project, all platforms: Android, iOS, web, macOS, Windows, Linux.
- **Architecture:** Stacked MVVM as already set up (`stacked`). Use Stacked's router, locator, `NavigationService`, `DialogService`, `BottomSheetService` and `SnackbarService`. Do not introduce Riverpod, Bloc, Provider-based state, go_router, get_it calls outside the generated locator, or any second architecture.
- **Language:** Dart everywhere. Null safety, the project's existing lint rules (tighten, never loosen), zero analyzer warnings.
- Use Serverpod's generated models, ORM, migrations, endpoints, streams and future calls. Do not hand-roll a REST layer.
- Every external service (SMS, WhatsApp, AI model, maps/routing, file storage) sits behind a Dart interface with a real adapter and a development adapter (logs to console). Selection is by config, never by code edits.
- Secrets live in Serverpod's `passwords.yaml` / environment, never in the repo.
- If the docs show a better Serverpod-native way than what this prompt describes, use the native way and note it in your phase summary.

### 2.1 Flutter rules (Stacked MVVM)

- **Views are dumb.** A view only lays out widgets and forwards user actions to its viewmodel. No business logic, no API calls, no navigation logic inside widgets.
- **ViewModels** own screen state and call services. Pick the right base class (`BaseViewModel`, `FutureViewModel`, `StreamViewModel`, `ReactiveViewModel`, `MultipleFutureViewModel`) as the samples do. Use `runBusyFuture` / `setBusy` / `setError` for loading and error states instead of ad hoc booleans.
- **Services** hold all I/O and shared state: `ApiService` (wraps the generated Serverpod client), `AuthService`, `LocationService`, `EmergencyService`, `FacilityService`, `AssistantService`, `ConnectivityService`, `CacheService`, `LauncherService` (calls, maps, SMS composer). Register them in the `@StackedApp` definition and regenerate with `stacked_generator` / `build_runner`. Live data (facility status streams, session changes) is exposed reactively so viewmodels update without manual refresh.
- **Navigation, dialogs, bottom sheets and snackbars** go through Stacked services and are registered in the app definition. Routes must work as web URLs and deep links.
- **Shared widgets come first.** The project already has shared widgets such as `AppText`, `AppTextField` and others. Before building any UI, list every existing shared widget in `FLUTTER_CONVENTIONS.md` and use them everywhere: no raw `Text` or `TextField` where `AppText` / `AppTextField` exist. If a needed component is missing (status badge, hospital list tile, stepper, primary/danger buttons, empty state, error state), create it as a new shared widget in the same folder and style as the existing ones, then reuse it.
- **Theme:** extend the project's existing theme and constants with the tokens in section 7. Do not create a parallel theme.
- If the Stacked CLI is part of the setup, use it (`stacked create view`, `stacked create service`, etc.) so generated files match the project.
- Tests follow the sample tests: viewmodel unit tests with mocked services (the project's mocking approach), plus widget and golden tests for key views.

### 2.2 Serverpod rules (good practice)

- **Thin endpoints.** An endpoint method only authenticates, authorizes, validates input, calls one service method, and maps the result. All business logic lives in plain Dart service classes that are unit-testable without a running server.
- **Feature folders.** Organise the server by domain, not by file type: `lib/src/features/{auth,facilities,status,emergency,assistant,notifications,admin,doctors}/` each holding its `*.spy.yaml` models, endpoint, service(s) and tests. Shared helpers (auth guards, validation, clock, config) live in `lib/src/core/`.
- **Pure core logic.** Ranking, freshness tiers, capability mapping and red-flag rules are pure functions with no database access, covered by fast unit tests.
- **Authorization helpers.** One central guard API (for example `requireRole(session, Role.deskStaff, facilityId: id)`) used by every endpoint. Deny by default; each endpoint explicitly states who may call it.
- **Typed errors.** Define serializable exception models (e.g. `NotAuthorizedException`, `ValidationException`, `NotFoundException`, `RateLimitedException`) with stable error codes the client maps to user-facing messages. Never leak stack traces or raw database errors.
- **Validation.** Validate every input on the server (phone format, coordinates in range, bed counts non-negative, enum values, string lengths) even if the client validates too.
- **Database.** All schema changes through Serverpod migrations, committed to the repo. Indexes on facility location, `FacilityStatus.updatedAt`, `RoleAssignment(userId, facilityId)`, and report lookups. Use transactions for multi-row writes (status change + audit log, onboarding). Avoid N+1 queries: use includes/joins or batched queries for the results list. Paginate every admin list.
- **Time.** Store and compare everything in UTC; convert to Africa/Lagos only for display and opening-hours logic. Inject a `Clock` so freshness and reminder logic is testable.
- **Streams and future calls.** Facility status changes publish through Serverpod's messaging/stream mechanism; future calls are idempotent (safe to run twice) and reschedule themselves correctly after restarts.
- **Configuration.** Environment-specific settings in Serverpod's config files (`development.yaml`, `staging.yaml`, `production.yaml`), secrets in `passwords.yaml` or env vars, feature flags (WhatsApp quick update, V2 doctors) in config.
- **Observability.** Use Serverpod's logging with structured context (endpoint, userId, facilityId, sessionId), no health data in logs. Health check endpoint for deployments.
- **Rate limiting** on OTP, AI chat and report endpoints.
- **Tests.** Unit tests for services and pure logic; integration tests with Serverpod's test tools against a real test database for every endpoint, including authorization failures.

### Repository layout

```
emergencyhr/
  emergencyhr_server/     # Serverpod server (feature folders, see 2.2)
  emergencyhr_client/     # generated client (do not edit by hand)
  <existing Flutter app>/ # the existing Stacked project; keep its name and structure
  content/first_aid/      # reviewed first-aid card content (JSON or YAML)
  docs/                   # FLUTTER_CONVENTIONS.md, ARCHITECTURE.md, RUNBOOK.md, DECISIONS.md, CLEANUP.md
```

If the Serverpod server and client do not exist yet, create them with `serverpod create` and wire the existing Flutter app to the generated client. If they exist, follow their structure.

---

## 3. Users and roles

One account per person, identified by phone number. Roles are attached to the account; they are not separate account types. One person can hold several roles.

| Role | Scope | Can |
| --- | --- | --- |
| Guest (no account) | Anyone | Use Emergency, see hospitals, call, get directions, read first-aid cards |
| Public user | Signed in | Guest abilities plus AI assistant, family alert, emergency contacts, medical profile, report wrong status |
| Hospital admin | One facility | Manage facility profile, capabilities, staff; update status |
| Hospital desk staff | One facility | Update status only |
| Doctor | Own profile | **V2 only.** Create the schema and role now, build no UI |
| Field agent | Assigned facilities | Emergencyhr staff who onboard hospitals on site: create or edit facilities, capture documents, invite hospital admins and desk staff, run training mode, move facilities through the onboarding pipeline. Cannot approve verification |
| Platform admin | Everything | Verify hospitals, manage directory and field agents, review reports and claims, suspend accounts |

Authorization is enforced **server-side on every endpoint**. The client hiding a button is not security.

**Auth:** phone number + OTP (6 digits, 5 minute expiry, rate limited per phone and per IP). Implement it on top of Serverpod's current auth/session system; check the docs for the right extension point. OTP delivery goes through the SMS interface. Hospital staff are invited by phone number and sign in the same way.

---

## 4. Data model

Create all entities below now, including the V2 ones (empty, behind a feature flag), so the doctor launch needs no migration. Use Serverpod model files, proper indexes (especially on facility location and status `updated_at`), and foreign keys.

| Entity | Key fields |
| --- | --- |
| User | id, phone (unique), name, createdAt |
| RoleAssignment | userId, role (enum: public, hospitalAdmin, deskStaff, fieldAgent, doctor, platformAdmin), facilityId (nullable) |
| OtpChallenge | phone, codeHash, expiresAt, attempts |
| EmergencyContact | userId, name, phone, channel (sms, whatsapp) |
| MedicalProfile | userId, bloodGroup, allergies, conditions, medications, consentAt |
| Facility | id, name, type (public, private, mission), address, lat, lng, deskPhone, verificationStatus (seeded, pending, verified, rejected, suspended), onboardingStage (see 6.6), source (seeded, fieldAgent, selfSignup, claim), liveAt (nullable), openingHours |
| FacilityCapability | facilityId, capability (enum: generalEmergency, trauma, obstetrics, paediatrics, cardiac, burns, icu, theatre, bloodBank, oxygen, ambulance) |
| OnboardingRecord | facilityId, stage, assignedAgentUserId, notes, nextActionAt, updatedAt |
| OnboardingEvent | facilityId, fromStage, toStage, byUserId, note, at |
| FacilityInvite | facilityId, role (hospitalAdmin, deskStaff), phone (nullable), tokenHash, shortCode, createdByUserId, expiresAt, usedAt, revokedAt |
| ClaimRequest | facilityId, userId, contactName, documents, deskPhoneVerified, status (pending, approved, rejected), reviewedByUserId, reason |
| JoinRequest | hospitalName, contactName, phone, area, message, status (new, contacted, converted, closed), facilityId (nullable) |
| FacilityStatus | facilityId, accepting, erBedsFree, icuBedsFree, doctorOnDuty, depositRequired, updatedByUserId, updatedAt |
| StatusChangeLog | facilityId, userId, oldValue (json), newValue (json), at |
| EmergencySession | id, userId (nullable), lat, lng, emergencyType, resultsShown (json), action (call, directions, call112, none), facilityId, startedAt, actedAt |
| StatusReport | sessionId, facilityId, reason, createdAt |
| AiConversation / AiMessage | userId, role, content, redFlagDetected, createdAt |
| DoctorProfile (V2) | userId, mdcnNumber, licenceExpiry, specialty, feeNgn, sessionMinutes, facilityId (nullable), verificationStatus |
| DoctorAvailability (V2) | doctorId, weekday, start, end, onlineNow |
| Consultation (V2) | userId, doctorId, status, feeNgn, startedAt, endedAt, note |
| Payment (V2) | consultationId, amountNgn, providerRef, status (held, released, refunded) |
| Payout (V2) | doctorId, amountNgn, commissionNgn, status, providerRef |

`EmergencySession` powers the north star metric: time from `startedAt` to `actedAt`.

---

## 5. Core logic

### 5.1 Freshness and trust model

Only verified hospital staff can set availability. Every status shows its age. Stale data is never shown as current.

| Age of last confirmation | Label | Effect |
| --- | --- | --- |
| 0 to 30 min | "Confirmed X min ago" | Ranked normally |
| 31 to 120 min | "Last confirmed X min ago. Call ahead." | Ranked below fresh |
| Over 120 min, or never | "Unverified. Call before going." | Shown last, **never** labelled Accepting |
| Paused | "Not accepting new emergencies" | Hidden by default, shown on tap |

Three "status was wrong" reports for one facility within 24 hours flag it for admin review and hide it from Tier 1 until reviewed.

### 5.2 Ranking

Implement as a pure, unit-tested Dart function on the server.

1. **Tier 1:** accepting, confirmed within 30 min, matches the required capability.
2. **Tier 2:** accepting and confirmed 31 to 120 min ago, or fresh with partial capability match.
3. **Tier 3:** unverified or older than 120 min.
4. **Hidden by default:** paused or flagged.

Inside a tier: sort by estimated travel time, then by beds free. Search radius 10 km, widening to 25 km if Tier 1 is empty. For MVP, estimate travel time from haversine distance with a configurable urban speed factor, behind a `RoutingService` interface so a real routing API can replace it.

Capability mapping:

| Emergency type | Required capability |
| --- | --- |
| roadAccident, severeBleeding | trauma |
| burns | trauma (burns preferred) |
| chestPain | cardiac, or generalEmergency with doctor on duty |
| pregnancy | obstetrics |
| child | paediatrics |
| unconscious, breathingDifficulty, other, skipped | generalEmergency with doctor on duty |

### 5.3 Real time

Use Serverpod streams so an open results list updates within 5 seconds when any listed facility changes status. Ages ("4 min ago") tick client-side without refetching.

### 5.4 Stale reminders

Use Serverpod future calls. When a verified facility's status passes 60 minutes old during its opening hours, notify on-shift desk staff (WhatsApp, SMS fallback). Do not spam: at most one reminder per facility per 60 minutes.

---

## 6. Features by surface

One Flutter app (the existing Stacked project), three shells chosen by role after sign-in, each its own set of Stacked views and viewmodels (plus a **Field Agent** shell for onboarding, see 6.6): **Public**, **Hospital Desk**, **Admin**. Guests land in Public. The Desk and Admin shells must be excellent on web and desktop (wide layouts) and still usable on a phone.

### 6.1 Public: Emergency flow (P0, no sign-in required)

1. Home screen: one large Emergency button, visible without scrolling on every screen size. Secondary entries below it: AI Assistant, First Aid, Profile.
2. Tap Emergency: request location once. If permission is denied or the platform has no reliable location (some desktop targets), show an area picker (search plus a list of pilot areas) instead. Never dead-end.
3. Optional emergency type picker with a clearly visible "Skip". Nine options from section 5.2.
4. Results within 3 seconds: for each facility show name, distance, ETA, status label with freshness, ER beds, ICU beds, doctor on duty, key capabilities, deposit required.
5. Each result: **Call** and **Directions**.
   - Call: `tel:` on mobile. On web and desktop, show the number large with a copy button and a `tel:` link (some desktops route it to a phone app).
   - Directions: open Google Maps (or Apple Maps on iOS/macOS) via URL with the destination coordinates.
6. If no accepting facility within 25 km: a prominent "Call 112" action plus the nearest facilities labelled "Call before going".
7. After Call or Directions: offer **Notify family** (signed-in users with contacts) and show the first-aid cards for the chosen type.
8. Record every step in `EmergencySession`.
9. Cache the last results and all first-aid cards locally for poor connectivity.

### 6.2 Public: other P0/P1 features

- **Notify family:** SMS/WhatsApp to up to 3 contacts: "[Name] may be having a medical emergency and is heading to [Hospital]. Location: [maps link]. Sent via Emergencyhr." If the server send fails, fall back to the device's native SMS composer where the platform supports it.
- **First-aid cards:** loaded from `content/first_aid/`, one card per emergency type, max 6 steps, "Do" and "Don't" sections. Seed with clearly marked draft content and a `reviewedBy` field that is empty until a clinician signs off; show "Draft content" in debug builds only.
- **Report wrong status:** available on a facility for 24 hours after the user acted on it.
- **Profile:** name, emergency contacts, optional medical profile saved only after an explicit consent step.
- **Hospital detail page:** address, phones, capabilities, opening hours.

### 6.3 Public: Medical AI assistant (P0, signed in)

- Server endpoint calls the AI provider through an `AiService` interface; model name and API key from config. Stream tokens to the client.
- Two layers of red-flag detection: a deterministic server-side rules list (chest pain, heavy bleeding, difficulty breathing, unconscious, stroke signs, seizure, pregnancy bleeding, suicidal statements, etc.) **and** a structured flag returned by the model. Either one triggers an in-chat "Find emergency care now" action that opens the Emergency flow with the type pre-filled.
- System prompt rules: general information and first-aid guidance only; never diagnose, prescribe or give medication doses; say when to see a doctor; first-aid answers must come from the reviewed first-aid content passed in as context.
- Persistent short disclaimer and an always-visible Emergency button on the chat screen.
- Users can delete their conversations.
- Ship a red-flag test set (at least 40 prompts with expected escalate / do not escalate) and a test that runs the rules layer against it.

### 6.4 Hospital Desk shell (P0)

- **Self-serve onboarding:** follows the self-serve path in 6.6 (search and claim first, create only if no match). Facility details, map pin, desk phone, capabilities, registration document upload (Serverpod file storage), named contact. Status stays hidden from the public until verified and live.
- **Status screen** (the most important hospital screen): one large Accepting / Paused toggle, steppers for ER and ICU beds, doctor on duty switch, deposit required switch, a big "Still accurate" button that refreshes the timestamp, and the current age of the status. A full update must take under 30 seconds and work one-handed on a phone.
- **Staff:** facility admin invites desk staff by phone, removes them.
- **Audit log:** every change with staff name and time.
- **WhatsApp quick update (P1, behind a flag):** webhook endpoint accepting short codes (A = accepting, P = pause, C = confirm) from registered staff numbers.

### 6.5 Admin shell (P0, web/desktop first)

- Verification queue with documents, approve, reject with reason.
- Directory management: create and edit seeded facilities.
- Onboarding pipeline board (see 6.6), claim requests queue, join requests inbox, field agent management (invite, assign areas or facilities, deactivate).
- Freshness dashboard: every facility with last update age, stalest first.
- Reports queue with auto-flagged facilities.
- Suspend and reinstate accounts and facilities with a logged reason.
- Metrics page: median time-to-action, share of facilities with status under 60 min old, empty-result rate.

---

### 6.6 Hospital onboarding (P0 unless marked)

Most pilot hospitals will be onboarded **in person by an Emergencyhr field agent** at the hospital's emergency desk. Self-serve signup exists as a secondary path. Both paths must end in the same go-live checklist, and neither may create duplicate facilities.

**Onboarding stages** (`Facility.onboardingStage`, every change written to `OnboardingEvent`):

`seeded` → `contacted` → `visited` → `staffTrained` → `verified` → `live`, plus `paused` and `declined` as exits. Only `live` facilities can appear as Accepting (Tier 1 or 2). Everything before `live` is shown publicly as "Unverified. Call before going." if it has a seeded listing, or not at all if it has none.

**Path A: field onboarding (agent's phone, Field Agent shell)**

Target: a full on-site onboarding in under 20 minutes on a phone.

1. Agent opens "Onboard a hospital", taps "I'm at the hospital": the app takes the agent's current location and lists seeded or existing facilities within 300 m. Agent picks the match, or creates a new facility only after the duplicate check (name similarity plus distance) shows no match.
2. Confirm or correct name, type, address, map pin (default: agent's current location), opening hours, desk phone, capabilities.
3. Photograph the registration document and the named contact's details (camera on mobile, file picker on web and desktop).
4. Invite the hospital admin by phone: they receive an SMS invite, and the agent can also show a QR code on screen. The hospital admin signs in with OTP on their own phone right there and accepts the invite.
5. Hospital admin (or agent on their behalf, with the admin present) invites at least one desk staff member the same way.
6. **Training mode:** desk staff complete a guided practice status update that is clearly labelled "Practice" and never shown to the public. The flow records that training was completed.
7. Agent submits for verification with notes. A platform admin approves (agents can never approve their own submissions). For the pilot, the platform admin can review from the same day's queue.
8. Once verified, the facility goes `live` automatically when the go-live checklist is complete.

Agent drafts are saved locally so a dropped connection mid-visit loses nothing; submission retries when back online.

**Path B: self-serve (hospital, any platform)**

1. Public web page `/hospitals/join` and an entry in the app: "Are you a hospital? Join Emergencyhr".
2. The hospital searches for its name first. If a listing exists, it starts a **claim**; otherwise it creates a new facility (same duplicate check as Path A).
3. A claim requires the registration document and OTP verification of the listed desk phone where possible. Claims go to the platform admin claims queue. Approved claims transfer the listing, keeping its history.
4. A lighter alternative for hospitals not ready to sign up: a short join request form (name, contact, phone, area), which lands in the admin join requests inbox and can be converted into an assigned field visit.

**Invites and QR codes**

- Invites are single-use, expire after 72 hours, can be revoked, and are tied to a facility and a role. Store only token hashes.
- Each live facility has a printable desk poster (PDF, generated server-side) with a QR code that lets new desk staff request to join that facility; the facility admin approves them. (P1)

**Go-live checklist** (computed server-side, shown to agent, hospital admin and platform admin):

- [ ] Verified by a platform admin
- [ ] At least one hospital admin has accepted their invite
- [ ] At least one desk staff account active
- [ ] Capabilities and opening hours set
- [ ] Desk phone confirmed (OTP or recorded test call by the agent)
- [ ] Training mode completed
- [ ] First real status update submitted

When every item is done, set `onboardingStage = live` and `liveAt`. If a requirement later breaks (for example, the last desk staff is removed), notify the hospital admin and the assigned agent.

**Onboarding pipeline (Admin shell)**

- Board or table of all facilities by stage, filterable by area and assigned agent, with notes, next action date and checklist progress.
- Counts per stage against the pilot target (25 to 40 live facilities).
- Bulk assign seeded facilities to agents.

**Early health (P0)**

- "New hospitals" view: facilities live for under 14 days with their status update count and last update age.
- Flag any facility live under 14 days that has gone 48 hours without an update during opening hours; notify the assigned agent so they can follow up while the habit is forming.

## 7. Design system

The design must look like a calm, serious medical utility built by a professional product team. It must **not** look AI-generated or "vibe coded".

**Do:**
- Neutral base: near-white background, near-black text, grey scale for structure. Full dark theme with the same rules.
- **One** emergency red, used only for the Emergency button, Call 112, and critical states. Status colours: green (confirmed accepting), amber (stale), grey (unverified / paused). Status is always text plus colour, never colour alone.
- One typeface (Inter or the platform system font), a strict type scale (e.g. 32 / 24 / 18 / 16 / 14 / 12), clear weight hierarchy.
- 8-point spacing grid, consistent radii (8 for controls, 12 for containers), thin 1px dividers instead of heavy shadows.
- Data-dense, scannable lists for hospitals, like a well-made transit or banking app. Numbers aligned, labels short.
- Large tap targets (min 48px), high contrast (WCAG AA), works at 200% text size, keyboard navigation and focus states on web and desktop.
- Responsive breakpoints: compact (< 600), medium (600 to 1024), expanded (> 1024). Desk and Admin use a side navigation rail and two-pane layouts when expanded.
- Real, plain, specific copy everywhere ("Accepting emergencies. Confirmed 4 min ago."). Empty, loading and error states designed for every screen.
- Line icons from one family only (Material Symbols Outlined or Lucide).

**Do not:**
- No gradients, glassmorphism, neon, purple/blue "AI" palettes, glowing borders, or decorative blobs.
- No emoji anywhere in the UI.
- No sparkle or magic-wand icons for the AI assistant. Call it "Health Assistant".
- No cards inside cards, no oversized drop shadows, no bouncing or decorative animations. Motion only for state changes, under 200ms, and respect reduced-motion settings.
- No lorem ipsum, no placeholder stock illustrations, no marketing fluff on functional screens.
- No em dashes in UI copy.

Put all tokens (colours, type, spacing, radii) into the project's existing theme and constants, and make the shared widgets (`AppText`, `AppTextField` and the rest) read from them. Add a hidden `/design` route in debug builds that renders every shared widget and state for review.

---

## 8. Platform specifics

| Concern | Android / iOS | Web | macOS / Windows / Linux |
| --- | --- | --- | --- |
| Location | geolocator | browser geolocation | geolocator where supported, otherwise area picker |
| Call | `tel:` | `tel:` link + copy number | number + copy, `tel:` where handled |
| Directions | maps app URL | new tab to Google Maps | default browser to Google Maps |
| Local cache | the project's existing storage package, or drift/Hive if none | web-compatible equivalent | same as mobile |
| Notifications (P1) | FCM / APNs | none in MVP | none in MVP |

Use conditional imports or platform checks behind small service classes; never scatter `kIsWeb` checks through UI code. Confirm the web build works with Serverpod's client (including streams) and configure CORS correctly.

---

## 9. Security, privacy, compliance

- Nigeria Data Protection Act 2023 in mind: minimum data, explicit consent before saving health data, user can export and delete their data.
- Health data and AI conversations encrypted at rest (field-level for MedicalProfile) and always over TLS.
- Rate limit OTP, AI chat, and report endpoints.
- Every status change and admin action logged with actor and time.
- In-app copy states Emergencyhr is an information and navigation service, not a medical provider, and points to 112 when in doubt.

---

## 10. Seed data and environments

- A seed script that creates a pilot area in Lagos with 30 fictional facilities (names clearly fictional, e.g. "Seed Hospital 01, Ikeja"), realistic coordinates, mixed capabilities and status ages covering every freshness tier, plus a platform admin, two field agents, two hospital admins, and desk staff. Spread the facilities across every onboarding stage, include one pending claim, two join requests, and one live facility that has gone quiet in its first week.
- `docker compose` for Postgres (and Redis if used) for local development.
- Dev adapters for SMS, WhatsApp and AI so the whole app runs locally with no paid accounts; OTP codes print to the server log in dev.
- Deployment notes in `docs/RUNBOOK.md` for Serverpod Cloud and for self-hosted Docker, plus Flutter web hosting.

---

## 11. Testing and quality bar

- Server unit tests: ranking, freshness tiers, capability mapping, red-flag rules, duplicate facility detection, go-live checklist, onboarding stage transitions (no skipping to `live`, agents cannot self-approve), invite expiry and single use, claim transfer, authorization on every endpoint (a desk user of facility A cannot touch facility B; a public user cannot set status).
- Server integration tests using Serverpod's test tools against a real test database.
- Flutter viewmodel unit tests (mocked services) for every viewmodel in the emergency flow, status screen and assistant.
- Flutter widget tests for the emergency flow, status screen, and empty/error states; golden tests for key screens in light and dark, compact and expanded.
- One integration test that walks: guest taps Emergency, picks Road accident, sees a Tier 1 trauma hospital first, taps Call, sees first-aid cards.
- Performance check: emergency results under 3 seconds with seed data; cold start to Emergency button under 2 seconds on a mid-range Android device (document how you measured).
- CI config (GitHub Actions) running analysis, tests, and builds for android, web, and one desktop target.

---

## 12. Build order

Work through these phases in order. Each phase ends with a running app, passing tests, and a short summary.

1. **Foundation:** study the Flutter project and write `FLUTTER_CONVENTIONS.md` (section 0), Serverpod project with feature folders, Docker dev setup, all models and migrations (including V2), typed exceptions and auth guards, theme tokens plus missing shared widgets and the `/design` route, Stacked routes for the three shells.
2. **Auth and roles:** phone OTP, sessions, role assignment, server-side authorization helpers with tests.
3. **Facilities, onboarding and status:** onboarding stages and pipeline, field agent flow, self-serve signup and claims, join requests, invites, training mode, go-live checklist, verification, status screen, audit log, seed script.
4. **Emergency flow:** location and area picker, type picker, ranking endpoint, results list with streams, call and directions per platform, 112 fallback, EmergencySession tracking, offline cache.
5. **Family alert, first-aid cards, profile, wrong-status reports.**
6. **Health Assistant:** streaming chat, red-flag rules and test set, escalation into the emergency flow.
7. **Admin shell:** verification queue, directory, freshness dashboard, reports, metrics.
8. **Reminders and WhatsApp:** future-call stale reminders, WhatsApp quick update behind a flag.
9. **Hardening:** accessibility pass, dark mode, every empty/error state, performance checks, golden tests, CI, RUNBOOK and ARCHITECTURE docs.

## 13. Definition of done

- All P0 features work on Android, iOS, web, and at least macOS or Windows, verified by running them.
- A guest can go from app launch to calling a confirmed accepting hospital in four taps or fewer.
- A field agent can take a seeded hospital from `visited` to submitted-for-verification in under 20 minutes on a phone, and the facility goes `live` automatically once the checklist is complete.
- Self-serve signup cannot create a duplicate of an existing listing.
- No stale or unverified facility is ever displayed as Accepting (covered by tests).
- Zero analyzer warnings, all tests green, no TODOs in in-scope features.
- Every view uses the shared widgets and Stacked patterns described in `FLUTTER_CONVENTIONS.md`; no business logic in views; no endpoint contains business logic.
- `docs/CLEANUP.md` lists the sample files that can now be deleted.
- The UI follows section 7 exactly; review every screen on `/design` and in the app against the Do / Do not lists before declaring done.

## 14. Out of scope (do not build)

Doctor UI, consultations, payments and payouts (schema only), hospital pre-alerts, ambulance dispatch, EMR integrations, insurance, crowdsourced availability. Users can only report a status as wrong; they never set it.

When something in this prompt is ambiguous, choose the option that makes the emergency flow faster and more trustworthy, record the decision in `docs/DECISIONS.md`, and keep going.
