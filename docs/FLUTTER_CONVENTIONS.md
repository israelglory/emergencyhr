# Flutter conventions

How the Emergencyhr Flutter app (`emergencyhr_flutter/`) is built. Every
change follows this document.

## The one rule

**No logic in views.** A view lays out widgets and forwards taps to its
viewmodel. Labels, colours chosen by state, visibility, validation,
navigation, dialogs, formatting and API calls all live in the viewmodel.

A view may:

- read getters on its viewmodel and pass them to widgets,
- `switch` on an enum the viewmodel exposes (for example `ViewState` or
  `DeskTab`) to pick which widget to show,
- use `if (model.someFlag)` to include or leave out a widget,
- choose a layout from the window size (`WindowSize.of(context)`).

A view may not compute strings, compare data, call services, or decide
whether a button is enabled. Expose `VoidCallback? onX` from the viewmodel
instead (null means disabled).

## Layers

| Layer | Folder | Holds |
| --- | --- | --- |
| View | `lib/presentation/<feature>/<screen>/<screen>_view.dart` | Layout only. `ViewModelBuilder` + shared widgets. |
| ViewModel | `lib/presentation/<feature>/<screen>/<screen>_viewmodel.dart` | Screen state and behaviour. Extends Stacked `BaseViewModel` or `ReactiveViewModel`. |
| Model | `lib/data/models/` and the generated `emergencyhr_client` | Data shapes, route arguments, enum labels, client-side rules such as `Freshness`. |
| API | `lib/data/api/<area>_api.dart` | One class per server area. Wraps the generated Serverpod client and returns `ApiResponse<T>`. |
| Service | `lib/core/services/` | Shared app services: navigation, dialogs, sheets, snackbars, session, location, launcher, phone calls, files, first aid, emergency flow state. |
| Local storage | `lib/data/local/` | Hive-backed caches (emergency results, drafts, first-aid cards). |

There is no repository layer. Viewmodels call APIs and services directly.

## Folder layout

```
lib/
  main.dart, app.dart, client.dart, driver.dart
  core/
    constants/   colour tokens (colors.dart), spacing, radii, sizes, breakpoints (dimens.dart)
    theme/       AppTheme (light and dark), AppPalette ThemeExtension (context.palette)
    widgets/     shared widgets, exported by widgets.dart
    routes/      AppRoutes (URLs) and AppRouter (URL -> view)
    di/          locator.dart (get_it registrations and getters)
    services/    app services, exported by services.dart
    utilities/   formatters, error messages, logger, window size, ViewState
  data/
    api/         Serverpod client wrappers + ApiResponse
    local/       Hive storage
    models/      client-side models, labels, route args, pilot areas
  presentation/
    public/ emergency/ first_aid/ assistant/ profile/ auth/ join/
    desk/ facility/ agent/ admin/ design/ common/
```

Import `core/cores.dart` for constants, theme, widgets, services, routes,
utilities and the locator.

## Naming

- Files: `snake_case`. Screen pairs are `<name>_view.dart` and
  `<name>_viewmodel.dart` in the same folder.
- Classes: `<Name>View` and `<Name>ViewModel`. Sheets: `<Name>SheetView` or
  `<Name>Sheet`. Small layout-only pieces used by one feature live in a
  `components/` folder next to the screen.
- Display row types are Dart records declared at the top of the viewmodel,
  for example `typedef ResultRow = (...)`.
- Presenters (`*_presenter.dart`) hold display mapping shared by several
  viewmodels, for example `ResultPresenter`.

## Pairing views and viewmodels

```dart
ViewModelBuilder<StatusViewModel>.reactive(
  viewModelBuilder: () => StatusViewModel(facilityId: facilityId),
  onViewModelReady: (model) => model.onReady(),
  builder: (context, model, _) => ...,
)
```

- Use `.reactive` when the screen changes; `.nonReactive` for static screens.
- Load data in `onReady()` or `load()`, called from `onViewModelReady`.
- Viewmodels that depend on shared state (signed-in user, emergency flow)
  extend `ReactiveViewModel` and list the services in `listenableServices`.

## Dependency injection

All registrations are in `lib/core/di/locator.dart`. Each service has a
top-level getter (`navigationService`, `emergencyApi`, ...). Viewmodels take
their dependencies as optional constructor parameters that default to those
getters:

```dart
StatusViewModel({StatusApi? statusApi}) : _api = statusApi ?? locator<StatusApi>();
```

Tests pass mocks through the constructor, or register mocks in the locator
with `setUpTestLocator()` (see `test/helpers/test_app.dart`). Never call
`GetIt` anywhere else.

## Loading and errors

- Use `runBusyFuture(future)` for loading. Use `busyObject:` keys for actions
  that need their own spinner (`busy(_saveKey)`).
- Use `setError(message)` for a screen that failed to load. Expose
  `String? get errorMessage => modelError?.toString();`.
- List and data screens expose `ViewState get state` built with
  `viewStateOf(...)` and the view switches on it:
  `loading -> LoadingState`, `error -> ErrorState`, `empty -> EmptyState`,
  `ready -> content`.
- Action failures show `snackbarService.error(message: response.message!)`.
  Field errors (`response.field`) go next to the field instead.

APIs never throw. `ApiResponse.guard` turns every error into a failed
response with plain copy from `ErrorMessages` (server errors carry an
`AppErrorCode` and user-facing text; network errors become the offline
message).

## Navigation, dialogs, sheets, snackbars

All are triggered from viewmodels through services:

- `navigationService.pushNamed(AppRoutes.x, args: ...)`, `replaceWith`,
  `clearStackAndShow`, `back(fallbackRoute: ...)`, `popUntilOrShow`.
- `dialogService.confirm(...)`, `promptText(...)`, `pickTime`, `pickDate`,
  `show(widget)`.
- `bottomSheetService.show<T>(SheetView(...))` and `dismiss<T>(result)`.
- `snackbarService.success / error / info`.
- `phoneCallService.callNumber(...)`: the dialler on phones, a large number
  with copy and `tel:` link on web and desktop.

Every screen has a URL in `AppRoutes`. `AppRouter` maps URLs to views, so
routes work as web URLs and deep links. Route arguments are typed classes in
`data/models/route_args.dart`; screens opened without arguments (for example
after a browser refresh) recover or redirect.

Staff shells check access in their viewmodel with
`accessService.ensure(ShellKind.x, returnTo: ...)`. The server enforces access
on every endpoint regardless.

## Shared widgets

Use these before writing new UI. No raw `Text` or `TextField`.

| Widget | Use |
| --- | --- |
| `AppText` (`.display`, `.headline`, `.title`, `.subtitle`, `.small`, `.label`, `.caption`) | All text. `tone:` for semantic colour, `numeric: true` for aligned figures. |
| `AppTextField` | All inputs. Label above the field. `large: true` for codes and phone numbers. |
| `AppButton` (`.secondary`, `.danger`, `.text`) | All buttons. `danger` (emergency red) only for Emergency, Call 112 and critical acts. `onPressed: null` disables. |
| `EmergencyButton` | The single large Emergency button. |
| `StatusBadge` + `StatusTone` | Status as text plus colour. Green accepting, amber stale, grey unverified or paused, red critical. |
| `HospitalListTile` | A hospital row with metrics, Call and Directions. |
| `SegmentedToggle` | Large two-way choice (Accepting / Paused). |
| `AppCountStepper` | Minus / value / plus with 48px targets. |
| `AppSwitchTile` | Full-row switch with a value label. |
| `ChoiceTile` | Large selectable row for pickers and menus. |
| `ChipGroup` | Multi or single select chips. |
| `AppCard` | 1px border, radius 12, no shadow. Never nest cards. |
| `SectionHeader`, `KeyValueRow`, `ChecklistView`, `NoticeBanner` | Structure and inline notices. |
| `EmptyState`, `ErrorState`, `LoadingState`, `AppLoader` | Every empty, error and loading state. |
| `AppPage` | Standard screen: app bar, readable max width, pinned bottom action. |
| `AppShell`, `ShellPageFrame` | Desk, Agent and Admin shells: side rail when expanded, bottom bar or drawer on phones. |
| `CallNumberSheet` | Number shown large with copy and dial (used by `PhoneCallService`). |

The debug-only `/design` route renders every widget and state in light and
dark for review.

## Theme and tokens

- Colours: `AppColors` raw tokens, read through `context.palette`
  (`AppPalette` ThemeExtension) so light and dark follow the same rules.
- Type scale 32 / 24 / 18 / 16 / 14 / 12 via `AppText` variants. Platform
  system font.
- Spacing on an 8-point grid: `AppSpacing.x1` (8) to `x8` (64), `half` (4)
  for tight gaps only.
- Radii: `AppRadius.control` 8, `AppRadius.container` 12.
- Tap targets at least 48px (`AppSizes.tapTarget`).
- Breakpoints: compact < 600, medium 600 to 1024, expanded > 1024
  (`WindowSize`).
- Icons: Material outlined icons only. No emoji, no gradients, no shadows
  beyond 1px borders, no em dashes in copy.

## Tests

| Kind | Where | How |
| --- | --- | --- |
| Viewmodel unit tests | `test/viewmodels/` | Construct the viewmodel with `mocktail` mocks from `test/helpers/mocks.dart`. |
| Model tests | `test/models/` | Pure functions such as `Freshness`. |
| Widget tests | `test/widgets/` | `setUpTestLocator()` then pump the real view with `themed(...)` or `testApp(...)`. |
| Flow test | `test/flows/emergency_flow_test.dart` | The guest emergency flow through the real router with stand-in services. |
| Golden tests | `test/goldens/` | Tagged `golden`. Regenerate with `flutter test --update-goldens test/goldens` on macOS. CI skips them. |

Test names follow Given / when / then.
