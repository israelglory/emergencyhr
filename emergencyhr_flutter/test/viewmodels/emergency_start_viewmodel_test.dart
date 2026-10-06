import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/models/route_args.dart';
import 'package:emergencyhr_flutter/presentation/emergency/start/emergency_start_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(registerFallbacks);

  late EmergencySessionService emergency;
  late MockNavigationService navigation;
  late MockLocationService location;

  setUp(() {
    emergency = EmergencySessionService();
    navigation = MockNavigationService();
    location = MockLocationService();
    when(
      () => navigation.pushNamed<void>(any(), args: any(named: 'args')),
    ).thenAnswer((_) async {});
  });

  EmergencyStartViewModel build({EmergencyType? preset}) =>
      EmergencyStartViewModel(
        presetType: preset,
        emergency: emergency,
        location: location,
        navigation: navigation,
        calls: MockPhoneCallService(),
      );

  test('Given location is found, when Road accident is picked, then results '
      'open for that type', () async {
    emergency.begin(Future.value(const LocationFound(6.6, 3.35)));
    final vm = build();
    await vm.onReady();
    expect(vm.locationLabel, 'Location found');
    await vm.choose(EmergencyType.roadAccident);
    final args =
        verify(
              () => navigation.pushNamed<void>(
                AppRoutes.emergencyResults,
                args: captureAny(named: 'args'),
              ),
            ).captured.single
            as EmergencyResultsArgs;
    expect(args.type, EmergencyType.roadAccident);
    expect(args.lat, 6.6);
  });

  test('Given location is denied, when Skip is tapped, then the area picker '
      'opens (never a dead end)', () async {
    emergency.begin(Future.value(const LocationDenied()));
    final vm = build();
    await vm.onReady();
    expect(vm.locationTone, StatusTone.warning);
    await vm.skip();
    verify(
      () => navigation.pushNamed<void>(
        AppRoutes.emergencyArea,
        args: EmergencyType.skipped,
      ),
    ).called(1);
  });

  test(
    'Given a preset type from the assistant, then it continues by itself',
    () async {
      emergency.begin(Future.value(const LocationFound(6.6, 3.35)));
      final vm = build(preset: EmergencyType.chestPain);
      await vm.onReady();
      verify(
        () => navigation.pushNamed<void>(
          AppRoutes.emergencyResults,
          args: any(named: 'args'),
        ),
      ).called(1);
    },
  );
}
