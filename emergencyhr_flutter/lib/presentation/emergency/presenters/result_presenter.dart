import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../../core/cores.dart';
import '../../../data/models/freshness.dart';
import '../../../data/models/labels.dart';

/// Display text for one emergency result. Used by viewmodels only.
abstract final class ResultPresenter {
  static FreshnessTier tier(EmergencyResult r, DateTime now) =>
      Freshness.tierAt(
        serverTier: r.freshness,
        updatedAt: r.statusUpdatedAt,
        now: now,
      );

  static String statusLabel(EmergencyResult r, DateTime now) {
    if (r.flagged) return 'Under review. Call before going.';
    return Freshness.label(tier(r, now), r.statusUpdatedAt, now);
  }

  static StatusTone tone(EmergencyResult r, DateTime now) {
    if (r.flagged) return StatusTone.critical;
    return switch (tier(r, now)) {
      FreshnessTier.fresh => StatusTone.positive,
      FreshnessTier.stale => StatusTone.warning,
      FreshnessTier.unverified => StatusTone.neutral,
      FreshnessTier.paused => StatusTone.neutral,
    };
  }

  static List<TileMetric> metrics(EmergencyResult r) => [
    if (r.erBedsFree != null) TileMetric('ER beds', '${r.erBedsFree}'),
    if (r.icuBedsFree != null) TileMetric('ICU beds', '${r.icuBedsFree}'),
    if (r.doctorOnDuty != null)
      TileMetric('Doctor', r.doctorOnDuty! ? 'On duty' : 'Not on duty'),
    if (r.depositRequired != null)
      TileMetric(
        'Deposit',
        r.depositRequired! ? 'Required' : 'None',
        tone: r.depositRequired! ? AppTextTone.warning : AppTextTone.primary,
      ),
  ];

  static const _key = [
    Capability.trauma,
    Capability.burns,
    Capability.cardiac,
    Capability.obstetrics,
    Capability.paediatrics,
    Capability.icu,
    Capability.theatre,
    Capability.bloodBank,
  ];

  static List<String> capabilities(EmergencyResult r) => [
    for (final c in _key)
      if (r.capabilities.contains(c)) c.label,
  ].take(4).toList();

  /// "2.4 km · About 9 min drive".
  static String distance(EmergencyResult r) =>
      '${Formatters.distanceKm(r.distanceKm)} · '
      'About ${r.etaMinutes} min drive';

  static String? footnote(EmergencyResult r) =>
      r.match == CapabilityMatch.partial
      ? 'May not have the specialist unit for this emergency.'
      : null;
}
