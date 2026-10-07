import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/onboarding/intro/intro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';
import '../helpers/test_app.dart';

/// First launch on a phone: splash, three intro slides, Welcome.
void main() {
  setUpAll(registerFallbacks);

  Future<TestServices> openIntro(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final s = await setUpTestLocator();
    await tester.pumpWidget(testApp(initialRoute: AppRoutes.intro));
    await tester.pumpAndSettle();
    return s;
  }

  void serveResults(TestServices s) {
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
  }

  testWidgets('Given the intro, when Next is tapped twice, then the third '
      'slide shows Get started, which opens Welcome', (tester) async {
    await openIntro(tester);
    expect(find.text(IntroViewModel.slides[0].title), findsOneWidget);

    await tester.tap(find.widgetWithText(AppButton, 'Next'));
    await tester.pumpAndSettle();
    expect(find.text(IntroViewModel.slides[1].title), findsOneWidget);

    await tester.tap(find.widgetWithText(AppButton, 'Next'));
    await tester.pumpAndSettle();
    expect(find.text(IntroViewModel.slides[2].title), findsOneWidget);
    expect(find.widgetWithText(AppButton, 'Next'), findsNothing);

    await tester.tap(find.widgetWithText(AppButton, 'Get started'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to EmergencyHr'), findsOneWidget);
  });

  testWidgets('Given the intro, when Skip intro is tapped, then Welcome '
      'opens and the intro is remembered', (tester) async {
    final s = await openIntro(tester);
    await tester.tap(find.text('Skip intro'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to EmergencyHr'), findsOneWidget);
    verify(() => s.intro.markIntroSeen()).called(1);
  });

  testWidgets('Given the intro, when Emergency is tapped, then Hospitals near '
      'you opens with no sign-in', (tester) async {
    final s = await openIntro(tester);
    serveResults(s);
    await tester.tap(find.widgetWithText(AppButton, 'Emergency'));
    await tester.pumpAndSettle();
    expect(find.text('Hospitals near you'), findsOneWidget);
    verify(() => s.location.current()).called(1);
  });

  testWidgets('Given Welcome, when Skip for now is tapped, then Home opens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await setUpTestLocator();
    await tester.pumpWidget(testApp(initialRoute: AppRoutes.welcome));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip for now'));
    await tester.pumpAndSettle();
    expect(find.byType(EmergencyButton), findsOneWidget);
  });

  group('Given a phone starting up', () {
    Future<void> start(WidgetTester tester) async {
      await tester.pumpWidget(testApp(initialRoute: AppRoutes.landing));
      await tester.pumpAndSettle();
    }

    testWidgets('on first launch, then the intro shows', (tester) async {
      await setUpTestLocator();
      await start(tester);
      expect(find.text(IntroViewModel.slides[0].title), findsOneWidget);
    });

    testWidgets('after the intro was seen, then Home shows', (tester) async {
      final s = await setUpTestLocator();
      when(() => s.intro.introSeen).thenReturn(true);
      await start(tester);
      expect(find.byType(EmergencyButton), findsOneWidget);
    });

    testWidgets('when signed in, then Home shows', (tester) async {
      final s = await setUpTestLocator();
      when(() => s.session.isSignedIn).thenReturn(true);
      await start(tester);
      expect(find.byType(EmergencyButton), findsOneWidget);
    });
  });

  testWidgets('On a small phone, the intro and Welcome fit without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await setUpTestLocator();
    await tester.pumpWidget(testApp(initialRoute: AppRoutes.intro));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip intro'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to EmergencyHr'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
