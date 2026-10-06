import '../../core/app_config.dart';

/// Estimates travel time. The MVP uses straight-line distance with a road
/// factor and an urban speed; a real routing API can replace it.
abstract class RoutingService {
  int etaMinutes(double distanceKm);
}

class HaversineRoutingService implements RoutingService {
  const HaversineRoutingService({this.speedKmh, this.roadFactor = 1.3});

  final double? speedKmh;

  /// Roads are longer than a straight line.
  final double roadFactor;

  @override
  int etaMinutes(double distanceKm) {
    final speed = speedKmh ?? AppConfig.instance.urbanSpeedKmh;
    final minutes = (distanceKm * roadFactor / speed * 60).ceil();
    return minutes < 2 ? 2 : minutes;
  }
}
