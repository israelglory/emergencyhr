import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/core/routes/app_router.dart';
import 'package:emergencyhr_flutter/presentation/landing/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';
import '../helpers/test_app.dart';

/// The web landing page at `/`.
void main() {
  setUpAll(registerFallbacks);
  setUp(() => AppRouter.showLanding = true);
  tearDown(() => AppRouter.showLanding = false);

  Future<TestServices> open(WidgetTester tester, {Size? size}) async {
    tester.view.physicalSize = size ?? const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final s = await setUpTestLocator();
    await tester.pumpWidget(testApp(initialRoute: AppRoutes.landing));
    await tester.pumpAndSettle();
    return s;
  }

  testWidgets(
    'Given the web, then / shows the landing page and /home the app',
    (tester) async {
      await open(tester);
      expect(find.byType(LandingView), findsOneWidget);
      expect(
        find.text('When every minute matters, know where to go.'),
        findsOneWidget,
      );

      await setUpTestLocator();
      await tester.pumpWidget(testApp(initialRoute: AppRoutes.home));
      await tester.pumpAndSettle();
      expect(find.byType(LandingView), findsNothing);
      expect(find.byType(EmergencyButton), findsOneWidget);
    },
  );

  testWidgets('When the hero Emergency button is tapped, then Hospitals near '
      'you opens with no sign-in', (tester) async {
    final s = await open(tester);
    when(() => s.location.current()).thenAnswer(
      (_) async => const LocationFound(6.6, 3.35),
    );
    when(
      () => s.emergencyApi.start(
        lat: any(named: 'lat'),
        lng: any(named: 'lng'),
        type: any(named: 'type'),
        area: any(named: 'area'),
        tappedAt: any(named: 'tappedAt'),
      ),
    ).thenAnswer((_) async => ok(searchFixture()));
    when(
      () => s.emergencyApi.watch(any(), any()),
    ).thenAnswer((_) => silentStream());

    await tester.tap(find.text('Emergency: find a hospital now'));
    await tester.pumpAndSettle();
    expect(find.text('Hospitals near you'), findsOneWidget);
    expect(find.byType(LandingView), findsNothing);
  });

  testWidgets('Given a signed-in person, then the header offers Open app', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final s = await setUpTestLocator();
    when(() => s.session.isSignedIn).thenReturn(true);
    await tester.pumpWidget(testApp(initialRoute: AppRoutes.landing));
    await tester.pumpAndSettle();
    expect(find.text('Open app'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
  });

  testWidgets('At phone width, the page lays out without overflow and the '
      'FAQ opens and closes', (tester) async {
    await open(tester, size: const Size(390, 844));
    const question = 'What does it cost?';
    await tester.scrollUntilVisible(
      find.text(question),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Using EmergencyHr is free.'), findsNothing);
    await tester.tap(find.text(question));
    await tester.pumpAndSettle();
    expect(find.text('Using EmergencyHr is free.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final width in [320.0, 768.0, 1024.0, 1920.0]) {
    testWidgets('At $width px wide, every section lays out without overflow', (
      tester,
    ) async {
      await open(tester, size: Size(width, 900));
      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('© 2026 EmergencyHr'),
        400,
        scrollable: scrollable,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Given a visitor in dark mode, then the landing page is light', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await setUpTestLocator();
    await tester.pumpWidget(
      testApp(initialRoute: AppRoutes.landing, brightness: Brightness.dark),
    );
    await tester.pumpAndSettle();
    final scaffold = tester.widget<Scaffold>(
      find.descendant(
        of: find.byType(LandingView),
        matching: find.byType(Scaffold),
      ),
    );
    expect(scaffold.backgroundColor, AppColors.background);
  });
}
