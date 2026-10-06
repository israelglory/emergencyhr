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

/// No reliable location on this device or it timed out.
class LocationUnavailable extends LocationResult {
  const LocationUnavailable();
}

/// Asks for the location once, with a timeout so the emergency flow never
/// waits more than a few seconds.
class LocationService {
  static const timeout = Duration(seconds: 8);

  /// Desktop Linux often has no location provider; go straight to the picker.
  bool get isLikelySupported =>
      kIsWeb || defaultTargetPlatform != TargetPlatform.linux;

  Future<LocationResult> current() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const LocationUnavailable();
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const LocationDenied();
      }
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: timeout,
          ),
        );
      } catch (_) {
        // Fall back to the last fix rather than dead-ending.
        position = kIsWeb ? null : await Geolocator.getLastKnownPosition();
      }
      if (position == null) return const LocationUnavailable();
      return LocationFound(position.latitude, position.longitude);
    } catch (_) {
      return const LocationUnavailable();
    }
  }
}
