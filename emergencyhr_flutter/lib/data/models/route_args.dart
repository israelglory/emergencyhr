import 'package:emergencyhr_client/emergencyhr_client.dart';

/// Opens the facility form. No [facilityId] means a new listing.
class FacilityEditorArgs {
  const FacilityEditorArgs({this.facilityId, this.lat, this.lng, this.name});

  final int? facilityId;
  final double? lat;
  final double? lng;
  final String? name;
}

/// Opens the claim form for an existing listing.
class ClaimArgs {
  const ClaimArgs({required this.facilityId, this.name});

  final int facilityId;
  final String? name;
}

/// Choose your area. [failure] is why the device location could not be
/// used, or null when the person opened it to search somewhere else.
class AreaPickerArgs {
  const AreaPickerArgs({this.failure});

  final Object? failure;
}

/// Where to search and for what.
class EmergencyResultsArgs {
  const EmergencyResultsArgs({
    required this.lat,
    required this.lng,
    required this.type,
    this.area,
  });

  final double lat;
  final double lng;
  final EmergencyType type;

  /// Set when the user chose an area instead of sharing location.
  final String? area;
}
