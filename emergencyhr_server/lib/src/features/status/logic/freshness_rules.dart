import '../../../generated/protocol.dart';

/// The freshness and trust model. Stale data is never shown as current, and
/// nothing that is not live, flagged, or older than 120 minutes is ever
/// treated as accepting.
abstract final class FreshnessRules {
  static const freshMinutes = 30;
  static const staleMinutes = 120;

  static FreshnessTier classify({
    required FacilityStatus? status,
    required bool live,
    required bool flagged,
    required DateTime now,
  }) {
    if (!live || flagged || status == null) return FreshnessTier.unverified;
    if (!status.accepting) return FreshnessTier.paused;
    final age = now.difference(status.updatedAt).inMinutes;
    if (age <= freshMinutes) return FreshnessTier.fresh;
    if (age <= staleMinutes) return FreshnessTier.stale;
    return FreshnessTier.unverified;
  }
}
