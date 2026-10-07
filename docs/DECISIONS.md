# Decisions

Where the build brief and the existing project disagreed, or the brief left
a choice open, the decision and why.

## Structure

1. **Existing navigation and UI services kept instead of Stacked's generated
   router and services.** The project already had its own
   `NavigationService`, `BottomSheetService` and `SnackbarService` on a
   get_it locator, with no `@StackedApp` or `stacked_generator`. The existing
   structure wins (brief section 0). Named routes plus the path URL strategy
   give every screen a web URL and deep link. `DialogService` was added in
   the same style.
2. **No repository layer.** The owner's rule is View, ViewModel, Model and
   services or APIs only. Viewmodels call `*Api` classes (wrapping the
   Serverpod client) and services directly.
3. **No logic in views** (owner's rule). Views only switch on enums or flags
   that viewmodels expose. See `FLUTTER_CONVENTIONS.md`.
4. **Samples removed rather than kept.** The brief said to keep them for a
   later cleanup; the owner asked to remove them. A backup is in
   `../emergencyhr_samples_backup_2026-10-06.zip` (outside the repository).
5. **Platform system font instead of Inter.** Loading Inter through
   google_fonts needs the network on first launch; the system font works
   offline and keeps cold start fast. The brief allows either.

## Server

6. **Email sign-in** (owner's choice, no SMS costs) using Serverpod's
   built-in email provider: register with an emailed code, then a password;
   password reset by emailed code. The Emergencyhr account is created by the
   provider's `onAfterAccountCreated` hook (and by `AuthGuard` if ever
   missing). A phone number is optional and added later in the profile; it
   is not verified, since that would need SMS. Each number can belong to one
   account. It is used for WhatsApp quick updates and reminders.
   - Staff invites can be locked to an email instead of a phone, and are
     shared by QR code, link or short code rather than SMS.
   - Field agents are promoted from existing accounts by email; they create
     their account first.
   - With no SMS provider (`smsAdapter: off`), family alerts report "Not
     sent" and offer the phone's own SMS app, and desk phones are confirmed
     by an agent's test call.
7. **`JoinRequestStatus.received`** stands for the brief's `new`, a reserved
   word in Dart.
8. **Stroke, seizure, poisoning and self-harm red flags map to
   `EmergencyType.other`** (general emergency with a doctor on duty), since
   the nine emergency types have no specific entry for them. Self-harm also
   shows crisis guidance.
9. **The model's red flag is a first-line tag** (`[[flag:type]]`) that the
   server strips while streaming. Assistant prefill is not available on
   current models, and structured output would prevent token streaming.
10. **Health Assistant model: Google Gemini 2.5 Flash** (owner's choice), with
    thinking off for fast replies and `gemini-flash-latest` as a fallback
    when it is overloaded. Gemini's safety stops are treated as refusals.
    The Anthropic adapter remains; switch with `aiProvider` in
    `app_settings.yaml`.
11. **Client-side freshness can only get worse.** The server tier is
    authoritative; the app re-labels by age so a list left open never shows
    a stale status as current.
12. **"On-shift" desk staff** has no shift data in the MVP, so reminders go to
    all desk staff of the facility, or the hospital admins if there are none.
13. **"Quiet newcomer"** is 48 hours without an update since going live,
    without excluding closed hours.
14. **Approving a claim does not verify the facility.** It makes the claimant
    the hospital admin and moves a seeded listing into onboarding; the
    facility still goes through verification and the go-live checklist.
15. **Self-serve creators become the hospital admin immediately.** Their
    listing stays hidden from the public until verified and live.
16. **Desk phone confirmation** by SMS code to the desk phone, or by a field
    agent's recorded test call.
17. **Guest emergency sessions** use a private access token returned once,
    so guests can record actions without an account.
18. **`tappedAt` from the app** is accepted as the session start only if it
    is within the last 15 minutes, so time to action includes the time spent
    choosing a type.
19. **Converting a join request** creates a listing at the area centre; the
    agent sets the exact map pin on site.
20. **Seed refresh in development.** On each development start the demo
    statuses are re-stamped so every freshness tier is always present. This
    touches only seed rows never updated by a real user.

## App

21. **Emergency goes straight to Hospitals near you** (approved design,
    `design/DESIGN_HANDOFF.md`). Location starts the moment Emergency is
    tapped and the list loads for all types. "What happened" is an optional
    filter and "Location" opens Choose your area; both refine the same
    server session through `emergency.updateSearch`, so time to action is
    still measured from the first tap. The Health Assistant red-flag card
    also opens the list for all types.
22. **Location on the web** asks the browser directly instead of checking
    permission first (older Safari cannot report it), accepts a fix up to a
    minute old for speed, and gives up after 15 seconds so an unanswered
    browser prompt never blocks the emergency flow. Every platform has the
    same 15 second limit.
23. **Directions** open Apple Maps on iOS and macOS, Google Maps elsewhere.
24. **Data export** is shown in the app with a copy button rather than saved
    as a file.
25. **Field agent drafts:** one unsent new-listing draft is kept on the
    device; a failed submission retries every 30 seconds while the form is
    open.
26. **Admin document preview:** photos open in the app; PDFs open through
    the browser or system viewer.
27. **Golden tests run on macOS only.** Pixel output differs across
    platforms, so CI skips the `golden` tag.

## Design (October 2026)

The owner approved the design in `design/` (see `DESIGN_HANDOFF.md`). Where
it differs from the original brief, the design wins:

28. **Look:** blue (#1A56DB) for everyday actions, red only for Emergency
    and Call 112, soft cards with a 1 px border and a light shadow, radius
    12 / 16 / 24. Status is always words plus colour.
29. **Font:** Plus Jakarta Sans, bundled in `assets/fonts/` (OFL licence)
    so it works offline, with tabular figures everywhere.
30. **Navigation:** public bottom tabs Home, Assistant, Profile (hidden in
    the emergency flow; Assistant and Profile are built on first open).
    Desk tabs Status, Audit log, Staff, Hospital. Agent tabs Onboard, My
    hospitals. Staff shells show a side menu from 840 px wide; Admin uses a
    drawer on phones.
31. **Unavailable status on Paused / Unverified:** the design table lists
    #EEF2F6 for offBg, every screen uses #F2F4F7. We use #F2F4F7 for badges
    and #EEF2F6 for the Accepting / Paused track.
32. **Where the design had no state** (signed-out Profile, family alert
    without contacts, practice prompt on the desk, empty admin lists) we
    reuse the closest designed pattern and the existing copy.
33. **Home location line** shows the nearest pilot area, only when location
    was already allowed. Home never triggers a location prompt.
34. **Document upload** offers Photograph (phones) and Upload. The design's
    extra "Choose a file instead" link is not shown because Upload already
    opens the file picker.
35. **Medical consent** uses the design wording: "I agree that Emergencyhr
    stores these health details, encrypted. I can delete them at any time."
36. **First-aid text** stays in `content/first_aid/` (clinician review
    pending); the design's list summaries are placeholders and are not
    copied over the content files.
37. **Accept invite** shows "Invited by" from the inviter's name
    (`InvitePreview.invitedBy`), when they gave one.

## Landing page and mobile intro (October 2026)

Source: `landing-intro/HANDOFF.md` and `landing-intro/screens/`. The prompt
pointed at `docs/design/...`; the files live in `design/` and
`landing-intro/`.

38. **Assets** live in `assets/images/intro/` and `assets/images/brand/`
    with their `2.0x/` and `3.0x/` folders. The SVG sources are kept next to
    the PNGs for future edits; the app only uses the PNGs.
39. **App icon** (`flutter_launcher_icons.yaml`): `app_icon` everywhere;
    Android adaptive icon is `app_icon_foreground` on #D92D20 with no extra
    inset, because the foreground already sits inside Android's safe zone.
    iOS corners are filled with #D92D20 so no white shows at the edges. The
    generator also writes a wrong value into the iOS project
    (`ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS =
    AppIcon`); set it back to `YES` after every run.
40. **Native splash** (`flutter_native_splash.yaml`): #D92D20 with
    `splash_logo` centred on Android and iOS; Android 12+ shows it inside
    its circle on the same red. No native splash on the web, so visitors
    see the landing page without a red flash.
41. **Addresses:** `/` is the landing page on the web and the splash on
    phones and computers; Home moved to `/home`. All links use
    `AppRoutes.home`, so nothing else changed. `/emergency/results` (named
    in the handoff) opens the same Hospitals near you page as `/emergency`.
    Deep links open only the requested page, so Back never lands on the
    landing page or splash by surprise.
42. **Splash:** the native splash covers start-up; the Flutter splash shows
    for one frame and then moves on, so it never adds waiting time.
43. **Intro seen** is saved when Welcome opens (via Skip intro, Get started
    or the last slide). Tapping Emergency on the intro does not count, so
    the intro is still there next launch. Computers (macOS, Windows, Linux)
    get the same splash and intro as phones; only the web shows the
    landing page.
44. **Intro pictures** use the supplied PNGs rather than rebuilding the
    HTML drawings in the design files.
45. **Landing links:** Join Emergencyhr goes to `/hospitals/join` everywhere
    (the footer design pointed it at the For hospitals section; the handoff
    wins). Desk sign in goes to Sign in and then the hospital desk (straight
    to the desk if already signed in). Privacy and Terms have no pages yet,
    so they show as plain text until `LandingContent.privacyUrl` and
    `termsUrl` are set. `[App Store link]`, `[Google Play link]` and
    `[Contact email]` are constants in `LandingContent`; they show as
    written and do nothing until replaced.
46. **To confirm before launch:** "Free to join during the pilot" and
    "Using Emergencyhr is free" (flagged in the handoff as assumptions).
47. **Landing at narrow widths:** buttons wrap their words instead of
    cutting them short; columns stack when there is not room for their
    design widths; the phone illustration scales down on very small
    screens. The landing page follows the device's light or dark setting
    like the rest of the app; the For hospitals band stays dark in both.
48. **Name:** the product is spelled **EmergencyHr** in everything people
    see (screens, texts and emails, the Health Assistant, permission
    prompts, home-screen name, web title). Code names stay lower case
    (`emergencyhr_flutter`, `emergencyhr_server`). The design files and older
    docs still say "Emergencyhr".
49. **App ID:** `ng.emergencyhr.app` on Android, iOS, macOS and Linux (iOS
    tests: `ng.emergencyhr.app.RunnerTests`). Checked unused on Google Play
    and the App Store on 7 October 2026. It cannot change after the first
    store release.
50. **First admin:** `adminEmails` in `config/app_settings.yaml` (staging
    and production). The listed account gets the platform admin role at
    server start or when it signs up, whichever comes later. Sign-up
    confirms the email with a code, so only the inbox owner can get it.
    The list only adds the role; removing an email does not take it away.
51. **Serverpod Cloud** (project `emergencyhr`): the web app is at
    https://emergencyhr.serverpod.space and the API at
    https://emergencyhr.api.serverpod.space. Cloud uploads only the server
    folder, so production reads first-aid cards from the web build's copy
    (`web/app/assets/assets/first_aid`, rebuilt by the pre-deploy step in
    `scloud.yaml`). Production secrets were generated fresh; a copy is in
    the local `config/passwords.yaml` (never uploaded or committed).
52. **Settings on Serverpod Cloud:** Cloud does not ship the `config/`
    folder, so `config/app_settings.yaml` is also compiled into the server
    (`lib/src/core/app_settings_embedded.dart`, made by
    `tool/embed_app_settings.dart`). The file wins when present; the
    built-in copy is used otherwise. The deploy refreshes the copy, and a
    test fails if the two differ. At start-up the server logs where its
    settings came from, the admin email count and whether the first-aid
    folder was found.
53. **Imported hospitals (October 2026):** Lagos and Ogbomoso hospitals come
    from GRID3 Nigeria health facilities (Lagos: v2.0, Nov 2024; Oyo: v3.0,
    Aug 2026), licensed CC BY 4.0, so the landing footer and each imported
    hospital's page credit GRID3. `tool/hospital_data/fetch_grid3.dart`
    keeps hospital-level facilities only (secondary and tertiary, plus
    hospitals and medical centres in Ogbomoso) and drops health posts,
    primary health centres, pharmacies, labs, diagnostic, eye, dental and
    fertility centres and anything marked not functional: 649 in Lagos, 34
    around Ogbomoso. GRID3 has no phone numbers.
54. **How they appear:** source `imported`, unverified, stage Seeded. The
    public sees them as "Unverified. Call before going." Importing the same
    file again adds nothing (each row's GRID3 id is stored in `sourceRef`),
    and rows close to an existing listing with a similar name are skipped.
    A platform admin can Verify a listing directly from the Directory after
    checking it; the public label changes only once its desk confirms a
    status.
55. **Areas:** Ogbomoso is a new pilot area (Oyo State; its Surulere LGA is
    filed under Ogbomoso to avoid confusion with Surulere, Lagos). Lagos
    hospitals inside the six pilot areas use those names; the rest use their
    LGA (for example Alimosho). The landing page now reads "Live across Lagos
    and Ogbomoso".

