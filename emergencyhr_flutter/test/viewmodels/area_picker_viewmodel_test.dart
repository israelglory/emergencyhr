import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/models/route_args.dart';
import 'package:emergencyhr_flutter/presentation/emergency/area_picker/area_picker_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  AreaPickerViewModel build({Object? failure, required bool web}) {
    final location = MockLocationService();
    when(() => location.isWeb).thenReturn(web);
    return AreaPickerViewModel(
      args: AreaPickerArgs(failure: failure),
      navigation: MockNavigationService(),
      calls: MockPhoneCallService(),
      location: location,
    );
  }

  test('Given location is blocked in a browser, then the hint says how to '
      'allow it', () {
    final vm = build(failure: const LocationDenied(), web: true);
    expect(vm.hint, contains('blocked for this site'));
    expect(vm.hint, contains('Use my location'));
  });

  test('Given the browser could not find a location, then the hint points '
      'to the computer settings', () {
    final vm = build(failure: const LocationUnavailable(), web: true);
    expect(vm.hint, contains('Location Services'));
  });

  test('Given location is off on a phone, then the hint points to phone '
      'settings', () {
    final vm = build(failure: const LocationDenied(), web: false);
    expect(vm.hint, contains('phone settings'));
  });

  test('Given the picker was opened to search elsewhere, then no failure '
      'is mentioned', () {
    final vm = build(web: true);
    expect(vm.hint, isNot(contains('could not')));
  });

  test('Given Use my location is tapped, then the picker returns it', () {
    final navigation = MockNavigationService();
    final location = MockLocationService();
    when(() => location.isWeb).thenReturn(true);
    when(() => navigation.pop<Object>(any())).thenReturn(null);
    AreaPickerViewModel(
      navigation: navigation,
      calls: MockPhoneCallService(),
      location: location,
    ).useMyLocation();
    verify(
      () => navigation.pop<Object>(any(that: isA<UseMyLocation>())),
    ).called(1);
  });
}
