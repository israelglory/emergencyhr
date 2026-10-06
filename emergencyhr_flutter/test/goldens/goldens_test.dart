@Tags(['golden'])
library;

import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/mocks.dart';
import '../helpers/test_app.dart';

/// Golden images of key screens: light and dark, compact and expanded.
/// Regenerate with `flutter test --update-goldens test/goldens`.
void main() {
  setUpAll(registerFallbacks);

  const sizes = {'compact': Size(400, 860), 'expanded': Size(1280, 860)};
  const modes = {'light': Brightness.light, 'dark': Brightness.dark};

  for (final size in sizes.entries) {
    for (final mode in modes.entries) {
      testWidgets('home ${size.key} ${mode.key}', (tester) async {
        tester.view.physicalSize = size.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await setUpTestLocator();
        await tester.pumpWidget(testApp(brightness: mode.value));
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('images/home_${size.key}_${mode.key}.png'),
        );
      });

      testWidgets('hospital tile ${size.key} ${mode.key}', (tester) async {
        tester.view.physicalSize = size.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          themed(
            brightness: mode.value,
            const SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  HospitalListTile(
                    name: 'Seed Hospital 01, Ikeja',
                    distanceLabel: '2.4 km',
                    etaLabel: 'About 9 min drive',
                    statusLabel: 'Accepting emergencies. Confirmed 4 min ago.',
                    statusTone: StatusTone.positive,
                    metrics: [
                      (label: 'ER beds', value: '3'),
                      (label: 'ICU beds', value: '1'),
                      (label: 'Doctor', value: 'On duty'),
                    ],
                    capabilitiesLabel: 'Trauma, ICU, Theatre',
                    onCall: _noop,
                    onDirections: _noop,
                  ),
                  Divider(),
                  HospitalListTile(
                    name: 'Seed Hospital 07, Yaba',
                    distanceLabel: '5.1 km',
                    etaLabel: 'About 20 min drive',
                    statusLabel: 'Last confirmed 45 min ago. Call ahead.',
                    statusTone: StatusTone.warning,
                    metrics: [],
                    onCall: _noop,
                    onDirections: _noop,
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('images/tile_${size.key}_${mode.key}.png'),
        );
      });
    }
  }
}

void _noop() {}
