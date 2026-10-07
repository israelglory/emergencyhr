import 'dart:async';

import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';
import '../helpers/test_app.dart';
import 'package:emergencyhr_flutter/data/models/route_args.dart';
import 'package:emergencyhr_client/emergencyhr_client.dart';

void main() {
  setUpAll(registerFallbacks);

  Future<TestServices> open(WidgetTester tester, Object result) async {
    final s = await setUpTestLocator();
    when(
      () => s.emergencyApi.start(
        lat: any(named: 'lat'),
        lng: any(named: 'lng'),
        type: any(named: 'type'),
        area: any(named: 'area'),
        tappedAt: any(named: 'tappedAt'),
      ),
    ).thenAnswer((_) async => result as dynamic);
    when(() => s.emergencyApi.watch(any(), any())).thenAnswer(
      (_) => silentStream(),
    );
    await tester.pumpWidget(testApp());
    unawaited(
      navigationService.pushNamed<void>(
        AppRoutes.emergency,
        args: const EmergencyResultsArgs(
          lat: 6.6,
          lng: 3.35,
          type: EmergencyType.skipped,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return s;
  }

  testWidgets('Given no hospitals within 25 km, then the empty state offers '
      'Call 112', (tester) async {
    await open(tester, ok(searchFixture(results: [], call112: true)));
    expect(find.text('No hospitals found within 25 km'), findsOneWidget);
    expect(find.widgetWithText(AppButton, 'Call 112'), findsOneWidget);
  });

  testWidgets('Given a failed load and no saved results, then the error '
      'state offers retry and Call 112', (tester) async {
    await open(tester, failed<EmergencySearch>('down'));
    expect(find.text('Try again'), findsOneWidget);
    expect(find.widgetWithText(AppButton, 'Call 112'), findsOneWidget);
  });
}
