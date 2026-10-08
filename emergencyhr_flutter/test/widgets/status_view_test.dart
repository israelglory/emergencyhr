import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/desk/status/status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';
import '../helpers/test_app.dart';

void main() {
  setUpAll(registerFallbacks);

  testWidgets('Given the status screen, when beds are increased and saved, '
      'then the update is sent', (tester) async {
    tester.view.physicalSize = const Size(420, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final s = await setUpTestLocator();
    when(() => s.facilityApi.detail(1)).thenAnswer(
      (_) async => ok(detailFixture(status: statusFixture())),
    );
    when(() => s.statusApi.update(1, any())).thenAnswer(
      (_) async => ok(statusFixture().copyWith(erBedsFree: 4)),
    );

    await tester.pumpWidget(themed(const StatusView(facilityId: 1)));
    await tester.pumpAndSettle();

    expect(find.text('Accepting'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Increase ER beds free'));
    await tester.pump();
    expect(find.text('4'), findsOneWidget);
    await tester.tap(find.widgetWithText(AppButton, 'Save update'));
    await tester.pumpAndSettle();
    verify(() => s.statusApi.update(1, any())).called(1);
  });

  testWidgets('Given Telegram is on, when Connect is tapped, then the bot '
      'link opens', (tester) async {
    tester.view.physicalSize = const Size(420, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final s = await setUpTestLocator();
    when(() => s.facilityApi.detail(1)).thenAnswer(
      (_) async => ok(detailFixture(status: statusFixture())),
    );
    when(() => s.telegramApi.connection()).thenAnswer(
      (_) async => ok(
        TelegramConnection(
          enabled: true,
          connected: false,
          botUsername: 'EmergencyHrBot',
        ),
      ),
    );
    const link = 'https://t.me/EmergencyHrBot?start=link_abc';
    when(() => s.telegramApi.createLink()).thenAnswer((_) async => ok(link));
    when(
      () => s.launcher.openUrl(Uri.parse(link)),
    ).thenAnswer((_) async => true);

    await tester.pumpWidget(themed(const StatusView(facilityId: 1)));
    await tester.pumpAndSettle();

    expect(find.text('Update from Telegram'), findsOneWidget);
    await tester.tap(find.widgetWithText(AppButton, 'Connect'));
    await tester.pumpAndSettle();
    verify(() => s.launcher.openUrl(Uri.parse(link))).called(1);
  });
}
