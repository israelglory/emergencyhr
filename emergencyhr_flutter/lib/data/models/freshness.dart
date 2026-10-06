import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../core/utilities/formatters.dart';

/// Client copy of the server's freshness thresholds. The server tier is
/// authoritative; on the client a tier can only get worse as time passes,
/// never better, so stale data is never shown as current.
abstract final class Freshness {
  static const freshMinutes = 30;
  static const staleMinutes = 120;

  static FreshnessTier tierAt({
    required FreshnessTier serverTier,
    required DateTime? updatedAt,
    required DateTime now,
  }) {
    if (updatedAt == null ||
        serverTier == FreshnessTier.paused ||
        serverTier == FreshnessTier.unverified) {
      return serverTier;
    }
    final age = now.difference(updatedAt).inMinutes;
    if (age > staleMinutes) return FreshnessTier.unverified;
    if (age > freshMinutes) return FreshnessTier.stale;
    return serverTier;
  }

  static String label(FreshnessTier tier, DateTime? updatedAt, DateTime now) {
    final ago = updatedAt == null
        ? null
        : now.difference(updatedAt).inMinutes.clamp(0, 1 << 30);
    return switch (tier) {
      FreshnessTier.fresh =>
        'Accepting emergencies. Confirmed ${ago == 0 ? 'just now' : '$ago min ago'}.',
      FreshnessTier.stale => 'Last confirmed $ago min ago. Call ahead.',
      FreshnessTier.unverified => 'Unverified. Call before going.',
      FreshnessTier.paused => 'Not accepting new emergencies',
    };
  }

  /// Age text for staff, e.g. "Updated 4 min ago".
  static String staffAge(DateTime? updatedAt, DateTime now) => updatedAt == null
      ? 'No status sent yet'
      : 'Updated ${Formatters.ago(updatedAt, now)}';
}
