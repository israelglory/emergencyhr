import 'dart:math';

/// Great-circle distance in kilometres.
double haversineKm(double lat1, double lng1, double lat2, double lng2) {
  const earthRadiusKm = 6371.0;
  double rad(double deg) => deg * pi / 180;
  final dLat = rad(lat2 - lat1);
  final dLng = rad(lng2 - lng1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(rad(lat1)) * cos(rad(lat2)) * sin(dLng / 2) * sin(dLng / 2);
  return earthRadiusKm * 2 * atan2(sqrt(a), sqrt(1 - a));
}

/// A rough lat/lng bounding box around a point, used to narrow database
/// queries before exact distances are computed.
({double minLat, double maxLat, double minLng, double maxLng}) boundingBox(
  double lat,
  double lng,
  double radiusKm,
) {
  final dLat = radiusKm / 111.0;
  final dLng = radiusKm / (111.0 * cos(lat * pi / 180).abs().clamp(0.01, 1));
  return (
    minLat: lat - dLat,
    maxLat: lat + dLat,
    minLng: lng - dLng,
    maxLng: lng + dLng,
  );
}
