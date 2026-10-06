import 'package:emergencyhr_client/emergencyhr_client.dart';

/// Arguments for the sign-in code screen.
class VerifyCodeArgs {
  const VerifyCodeArgs({required this.request, this.next});

  final OtpRequestResult request;

  /// Route to open after sign-in.
  final String? next;
}

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
