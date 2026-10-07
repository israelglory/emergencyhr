import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Result of asking for the device location. Never throws.
sealed class LocationResult {
  const LocationResult();
}

class LocationFound extends LocationResult {
  const LocationFound(this.lat, this.lng);
  final double lat;
  final double lng;
}

/// The user said no. Offer the area picker instead.
class LocationDenied extends LocationResult {
  const LocationDenied();
}

/// No reliable location on this device, or it took too long.
class LocationUnavailable extends LocationResult {
  const LocationUnavailable();
}

/// Asks for the location once and always answers within [overallTimeout],
/// so the emergency flow can never wait on it forever.
class LocationService {
  LocationService({GeolocatorPlatform? platform, bool? isWeb})
    : _platformOverride = platform,
      _isWeb = isWeb ?? kIsWeb;

  final GeolocatorPlatform? _platformOverride;
  final bool _isWeb;

  GeolocatorPlatform get _platform =>
      _platformOverride ?? GeolocatorPlatform.instance;

  /// Time allowed for a position fix once permission is granted.
  static const fixTimeout = Duration(seconds: 8);

  /// Hard limit for the whole lookup, including a permission prompt the user
  /// has not answered. After this the app moves on to the area picker.
  static const overallTimeout = Duration(seconds: 15);

  /// Accept a browser fix up to this old; it is much faster than a new one.
  static const webMaximumAge = Duration(minutes: 1);

  /// Desktop Linux often has no location provider; go straight to the picker.
  bool get isLikelySupported =>
      _isWeb || defaultTargetPlatform != TargetPlatform.linux;

  /// The location without asking, for the Home location line: only when
  /// permission was already given. Never shows a prompt.
  Future<LocationResult> withoutPrompt() async {
    try {
      final permission = await _platform.checkPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        return const LocationDenied();
      }
      if (!_isWeb) {
        final last = await _platform.getLastKnownPosition();
        if (last != null) return LocationFound(last.latitude, last.longitude);
      }
      return await current();
    } catch (_) {
      return const LocationUnavailable();
    }
  }

  Future<LocationResult> current() async {
    try {
      return await (_isWeb ? _fromBrowser() : _fromDevice()).timeout(
        overallTimeout,
        onTimeout: () => const LocationUnavailable(),
      );
    } on PermissionDeniedException {
      return const LocationDenied();
    } catch (_) {
      return const LocationUnavailable();
    }
  }

  /// Browsers show their own permission prompt when a position is requested.
  /// Permission is not checked first: some browsers (older Safari) cannot
  /// report it, and the check would wrongly skip the prompt. Browsers only
  /// share location on HTTPS pages (and localhost).
  Future<LocationResult> _fromBrowser() async {
    final position = await _platform.getCurrentPosition(
      locationSettings: WebSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: fixTimeout,
        maximumAge: webMaximumAge,
      ),
    );
    return LocationFound(position.latitude, position.longitude);
  }

  Future<LocationResult> _fromDevice() async {
    if (!await _platform.isLocationServiceEnabled()) {
      return const LocationUnavailable();
    }
    var permission = await _platform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _platform.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return const LocationDenied();
    }
    Position? position;
    try {
      position = await _platform.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: fixTimeout,
        ),
      );
    } on PermissionDeniedException {
      rethrow;
    } catch (_) {
      // Fall back to the last fix rather than dead-ending.
      position = await _platform.getLastKnownPosition();
    }
    if (position == null) return const LocationUnavailable();
    return LocationFound(position.latitude, position.longitude);
  }
}
