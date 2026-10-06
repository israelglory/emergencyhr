import '../../../generated/protocol.dart';
import '../../status/logic/freshness_rules.dart';
import 'capability_rules.dart';

/// A facility with everything ranking needs, gathered from the database.
class RankingCandidate {
  const RankingCandidate({
    required this.facility,
    required this.capabilities,
    required this.status,
    required this.distanceKm,
    required this.etaMinutes,
  });

  final Facility facility;
  final Set<Capability> capabilities;
  final FacilityStatus? status;
  final double distanceKm;
  final int etaMinutes;
}

/// Pure ranking. No database access.
///
/// Tier 1: accepting, confirmed within 30 min, full capability match.
/// Tier 2: accepting and confirmed 31 to 120 min ago with a match, or fresh
/// with a partial match.
/// Tier 3: unverified, older than 120 min, not live, or no capability match.
/// Hidden (tier 0): paused or flagged.
/// Inside a tier: preferred unit, then travel time, then beds free.
abstract final class Ranking {
  static List<EmergencyResult> rank({
    required List<RankingCandidate> candidates,
    required EmergencyType type,
    required DateTime now,
  }) {
    final results = [
      for (final c in candidates) _result(c, type, now),
    ];
    final preferred = {
      for (final c in candidates)
        if (CapabilityRules.preferred(type, c.capabilities)) c.facility.id!,
    };
    int tierOrder(int t) => t == 0 ? 99 : t;
    results.sort((a, b) {
      final t = tierOrder(a.rankTier).compareTo(tierOrder(b.rankTier));
      if (t != 0) return t;
      final pa = preferred.contains(a.facilityId) ? 0 : 1;
      final pb = preferred.contains(b.facilityId) ? 0 : 1;
      if (pa != pb) return pa.compareTo(pb);
      final eta = a.etaMinutes.compareTo(b.etaMinutes);
      if (eta != 0) return eta;
      return (b.erBedsFree ?? -1).compareTo(a.erBedsFree ?? -1);
    });
    return results;
  }

  static EmergencyResult _result(
    RankingCandidate c,
    EmergencyType type,
    DateTime now,
  ) {
    final f = c.facility;
    final live =
        f.onboardingStage == OnboardingStage.live &&
        f.verificationStatus == VerificationStatus.verified &&
        f.suspendedAt == null;
    final flagged = f.flaggedAt != null;
    final freshness = FreshnessRules.classify(
      status: c.status,
      live: live,
      flagged: flagged,
      now: now,
    );
    final match = CapabilityRules.match(
      type,
      c.capabilities,
      doctorOnDuty: c.status?.doctorOnDuty ?? false,
    );
    final tier = tierFor(
      freshness: freshness,
      match: match,
      flagged: flagged,
      paused: live && c.status != null && !c.status!.accepting,
    );
    // Live figures are only shown for live facilities with a status.
    final showStatus = live && c.status != null;
    return EmergencyResult(
      facilityId: f.id!,
      name: f.name,
      address: f.address,
      area: f.area,
      lat: f.lat,
      lng: f.lng,
      deskPhone: f.deskPhone,
      distanceKm: c.distanceKm,
      etaMinutes: c.etaMinutes,
      rankTier: tier,
      freshness: freshness,
      statusUpdatedAt: showStatus ? c.status!.updatedAt : null,
      erBedsFree: showStatus ? c.status!.erBedsFree : null,
      icuBedsFree: showStatus ? c.status!.icuBedsFree : null,
      doctorOnDuty: showStatus ? c.status!.doctorOnDuty : null,
      depositRequired: showStatus ? c.status!.depositRequired : null,
      capabilities: c.capabilities.toList()..sort((a, b) => a.index - b.index),
      match: match,
      flagged: flagged,
    );
  }

  static int tierFor({
    required FreshnessTier freshness,
    required CapabilityMatch match,
    required bool flagged,
    required bool paused,
  }) {
    if (paused || flagged) return 0;
    switch (freshness) {
      case FreshnessTier.fresh:
        if (match == CapabilityMatch.full) return 1;
        if (match == CapabilityMatch.partial) return 2;
        return 3;
      case FreshnessTier.stale:
        return match == CapabilityMatch.none ? 3 : 2;
      case FreshnessTier.unverified:
        return 3;
      case FreshnessTier.paused:
        return 0;
    }
  }

  /// True when nothing within reach can be called "accepting".
  static bool noAccepting(List<EmergencyResult> results) =>
      !results.any((r) => r.rankTier == 1 || r.rankTier == 2);
}
