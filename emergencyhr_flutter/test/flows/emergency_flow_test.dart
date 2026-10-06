import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';
import '../helpers/test_app.dart';

/// The guest flow from the brief: tap Emergency, pick Road accident, see a
/// Tier 1 trauma hospital first, tap Call, see first-aid cards.
void main() {
  setUpAll(registerFallbacks);

  testWidgets('Guest: Emergency -> Road accident -> Tier 1 trauma first -> '
      'Call -> first aid', (tester) async {
    tester.view.physicalSize = const Size(420, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final s = await setUpTestLocator();
    final fresh = DateTime.now().toUtc().subtract(const Duration(minutes: 4));
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
    ).thenAnswer(
      (_) async => ok(
        searchFixture(
          results: [
            resultFixture(id: 2, name: 'Seed Trauma Centre').copyWith(
              statusUpdatedAt: fresh,
            ),
            resultFixture(
              id: 3,
              name: 'Seed General Clinic',
              tier: 2,
              capabilities: [Capability.generalEmergency],
            ).copyWith(statusUpdatedAt: fresh),
          ],
        ),
      ),
    );
    when(() => s.emergencyApi.watch(any(), any())).thenAnswer(
      (_) => silentStream(),
    );
    when(
      () => s.emergencyApi.recordAction(
        any(),
        any(),
        any(),
        facilityId: any(named: 'facilityId'),
      ),
    ).thenAnswer((_) async => ok(true));
    when(
      () => s.calls.callNumber(
        number: any(named: 'number'),
        title: any(named: 'title'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async => true);

    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    // 1. Emergency
    await tester.tap(find.byType(EmergencyButton));
    await tester.pumpAndSettle();

    // 2. Road accident
    await tester.tap(find.text('Road accident'));
    await tester.pumpAndSettle();

    // 3. Tier 1 trauma hospital first
    final tiles = tester
        .widgetList<HospitalListTile>(find.byType(HospitalListTile))
        .toList();
    expect(tiles.first.name, 'Seed Trauma Centre');
    expect(tiles.first.statusLabel, startsWith('Accepting emergencies.'));

    // 4. Call
    await tester.tap(find.widgetWithText(AppButton, 'Call').first);
    await tester.pumpAndSettle();
    verify(
      () => s.calls.callNumber(
        number: '+2348100000001',
        title: 'Call Seed Trauma Centre',
        message: any(named: 'message'),
      ),
    ).called(1);
    verify(
      () => s.emergencyApi.recordAction(
        10,
        'token',
        EmergencyAction.call,
        facilityId: 2,
      ),
    ).called(1);

    // 5. First-aid cards
    expect(find.text('Calling Seed Trauma Centre'), findsOneWidget);
    expect(find.text('First aid while you wait'), findsOneWidget);
    expect(find.text('Road accident'), findsOneWidget);
  });
}
