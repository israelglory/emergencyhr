# Cleanup

## Already removed

At the owner's request the invoicing sample app was removed during the
build, not left for later. A full copy is in
`../emergencyhr_samples_backup_2026-10-06.zip`, outside the repository.

Removed from `emergencyhr_flutter/lib/`:

- `presentation/`: auth (login, signup), bottom navigation with home,
  profile and report tabs, branches, customers and statements, expense,
  invoice (home, create, details, invoice and receipt previews), splash
  screen, user management.
- `screens/`: greetings and sign-in sample screens.
- `data/datasources/remote/` (Dio REST layer and its interceptors),
  `data/datasources/repo/`, the sample local storages, and `data/model/`.
- `core/`: `app_globals.dart`, `user_roles.dart`, `currency_formatter.dart`,
  `app_assets.dart`, `asset_helper.dart`, `app_state.dart`,
  `theme_manager.dart`, `image_services.dart`, and the sample widgets
  `app_bar.dart`, `app_rectangle.dart`, `done_icon.dart`.
- Packages no longer used: dio, flutter_screenutil, overlay_support,
  google_fonts, carousel_slider, persistent_bottom_nav_bar, flutter_slidable,
  cached_network_image, share_plus, flutter_svg, pdf,
  syncfusion_flutter_charts, permission_handler, uuid, path_provider,
  flutter_native_contact_picker, cupertino_icons, logger.

Removed from `emergencyhr_server/`: the greeting endpoint, model and test,
and the email sign-in endpoint.

Kept and reworked: `AppText`, `AppTextField`, `AppButton`, the navigation,
bottom sheet and snackbar services, the locator, the Hive storage base, and
the logger.

## Safe to remove now

Unused Serverpod template pages:

- `emergencyhr_server/lib/src/web/routes/root.dart`
- `emergencyhr_server/lib/src/web/widgets/built_with_serverpod_page.dart`
- `emergencyhr_server/web/templates/built_with_serverpod.html`

Keep `emergencyhr_server/web/pages/build_flutter_app.html`; the server shows
it when the web app has not been built.
