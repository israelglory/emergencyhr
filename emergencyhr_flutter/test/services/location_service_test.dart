import 'dart:async';

import 'package:emergencyhr_flutter/core/services/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

/// A scripted stand-in for the device or browser location API.
class FakeGeolocator extends GeolocatorPlatform {
  Future<Position> Function()? onPosition;
  LocationPermission permission = LocationPermission.whileInUse;
  bool checkThrows = false;
  int checkCalls = 0;
  LocationSettings? lastSettings;

  @override
  Future<bool> isLocationServiceEnabled() async => true;

  @override
  Future<LocationPermission> checkPermission() async {
    checkCalls++;
    if (checkThrows) throw UnsupportedError('permissions API missing');
    return permission;
  }

  @override
  Future<LocationPermission> requestPermission() async => permission;

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) {
    lastSettings = locationSettings;
    return onPosition!();
  }

  @override
  Future<Position?> getLastKnownPosition({
    bool forceLocationManager = false,
  }) async => null;
}

Position _position() => Position(
  latitude: 6.6,
  longitude: 3.35,
  timestamp: DateTime.utc(2026, 10, 6),
  accuracy: 10,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

void main() {
  group('Given the web', () {
    test('when the user allows location then it is found without a separate '
        'permission check', () async {
      final fake = FakeGeolocator()
        ..checkThrows = true
        ..onPosition = () async => _position();
      final result = await LocationService(
        platform: fake,
        isWeb: true,
      ).current();
      expect(result, isA<LocationFound>());
      expect(fake.checkCalls, 0);
      expect(fake.lastSettings, isA<WebSettings>());
    });

    test('when the user blocks location then it is denied', () async {
      final fake = FakeGeolocator()
        ..onPosition = () =>
            Future.error(const PermissionDeniedException('blocked'));
      final result = await LocationService(
        platform: fake,
        isWeb: true,
      ).current();
      expect(result, isA<LocationDenied>());
    });

    test('when the page is not secure or the fix fails then it is '
        'unavailable', () async {
      final fake = FakeGeolocator()
        ..onPosition = () => Future.error(
          const PositionUpdateException('Only secure origins are allowed'),
        );
      final result = await LocationService(
        platform: fake,
        isWeb: true,
      ).current();
      expect(result, isA<LocationUnavailable>());
    });

    testWidgets('when the prompt is never answered then it gives up after '
        '15 seconds instead of waiting forever', (tester) async {
      final fake = FakeGeolocator()
        ..onPosition = () => Completer<Position>().future;
      LocationResult? result;
      unawaited(
        LocationService(
          platform: fake,
          isWeb: true,
        ).current().then((r) => result = r),
      );
      await tester.pump(const Duration(seconds: 14));
      expect(result, isNull);
      await tester.pump(const Duration(seconds: 2));
      expect(result, isA<LocationUnavailable>());
    });
  });

  group('Given a phone', () {
    test('when permission is denied then it is denied', () async {
      final fake = FakeGeolocator()..permission = LocationPermission.denied;
      final result = await LocationService(
        platform: fake,
        isWeb: false,
      ).current();
      expect(result, isA<LocationDenied>());
    });

    test('when allowed then it is found', () async {
      final fake = FakeGeolocator()..onPosition = () async => _position();
      final result = await LocationService(
        platform: fake,
        isWeb: false,
      ).current();
      expect(result, isA<LocationFound>());
    });
  });
}
