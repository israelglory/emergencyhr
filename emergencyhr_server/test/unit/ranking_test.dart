import 'package:emergencyhr_server/src/features/emergency/logic/capability_rules.dart';
import 'package:emergencyhr_server/src/features/emergency/logic/ranking.dart';
import 'package:emergencyhr_server/src/features/emergency/routing_service.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

final _now = DateTime.utc(2026, 10, 6, 12);

RankingCandidate _candidate(
  int id, {
  double km = 2,
  int? ageMinutes = 5,
  bool accepting = true,
  bool doctor = true,
  int beds = 2,
  Set<Capability> caps = const {Capability.generalEmergency},
  OnboardingStage stage = OnboardingStage.live,
  bool flagged = false,
}) {
  return RankingCandidate(
    facility: Facility(
      id: id,
      name: 'Seed $id',
      type: FacilityType.private,
      address: 'a',
      area: 'Ikeja',
      lat: 0,
      lng: 0,
      verificationStatus: stage == OnboardingStage.live
          ? VerificationStatus.verified
          : VerificationStatus.seeded,
      onboardingStage: stage,
      source: FacilitySource.seeded,
      flaggedAt: flagged ? _now : null,
    ),
    capabilities: caps,
    status: ageMinutes == null
        ? null
        : FacilityStatus(
            facilityId: id,
            accepting: accepting,
            erBedsFree: beds,
            icuBedsFree: 0,
            doctorOnDuty: doctor,
            depositRequired: false,
            updatedAt: _now.subtract(Duration(minutes: ageMinutes)),
          ),
    distanceKm: km,
    etaMinutes: const HaversineRoutingService(speedKmh: 20).etaMinutes(km),
  );
}

List<EmergencyResult> _rank(List<RankingCandidate> c, EmergencyType type) =>
    Ranking.rank(candidates: c, type: type, now: _now);

void main() {
  group('Given CapabilityRules', () {
    test('when road accident and trauma unit then full match', () {
      expect(
        CapabilityRules.match(EmergencyType.roadAccident, {
          Capability.trauma,
        }, doctorOnDuty: false),
        CapabilityMatch.full,
      );
    });

    test('when road accident and only general emergency then partial', () {
      expect(
        CapabilityRules.match(EmergencyType.roadAccident, {
          Capability.generalEmergency,
        }, doctorOnDuty: true),
        CapabilityMatch.partial,
      );
    });

    test('when chest pain and general emergency without doctor then none', () {
      expect(
        CapabilityRules.match(EmergencyType.chestPain, {
          Capability.generalEmergency,
        }, doctorOnDuty: false),
        CapabilityMatch.none,
      );
    });

    test('when burns and burns unit then full', () {
      expect(
        CapabilityRules.match(EmergencyType.burns, {
          Capability.burns,
        }, doctorOnDuty: false),
        CapabilityMatch.full,
      );
    });

    test('when skipped then general emergency with doctor is full', () {
      expect(
        CapabilityRules.match(EmergencyType.skipped, {
          Capability.generalEmergency,
        }, doctorOnDuty: true),
        CapabilityMatch.full,
      );
    });
  });

  group('Given Ranking', () {
    test('when road accident then the fresh trauma hospital is first', () {
      final results = _rank([
        _candidate(1, km: 1),
        _candidate(
          2,
          km: 4,
          caps: {Capability.trauma, Capability.generalEmergency},
        ),
      ], EmergencyType.roadAccident);
      expect(results.first.facilityId, 2);
      expect(results.first.rankTier, 1);
      expect(results[1].rankTier, 2);
    });

    test('when in the same tier then nearer comes first, then more beds', () {
      final results = _rank([
        _candidate(1, km: 5),
        _candidate(2, km: 1, beds: 0),
        _candidate(3, km: 1, beds: 4),
      ], EmergencyType.skipped);
      expect(results.map((r) => r.facilityId), [3, 2, 1]);
    });

    test('when stale (45 min) then tier 2, never tier 1', () {
      final r = _rank([_candidate(1, ageMinutes: 45)], EmergencyType.skipped);
      expect(r.single.rankTier, 2);
      expect(r.single.freshness, FreshnessTier.stale);
    });

    test('when older than 120 min then tier 3 and unverified', () {
      final r = _rank([_candidate(1, ageMinutes: 121)], EmergencyType.skipped);
      expect(r.single.rankTier, 3);
      expect(r.single.freshness, FreshnessTier.unverified);
    });

    test('when not live then tier 3, unverified, and no live figures', () {
      final r = _rank([
        _candidate(1, stage: OnboardingStage.visited),
      ], EmergencyType.skipped);
      expect(r.single.rankTier, 3);
      expect(r.single.freshness, FreshnessTier.unverified);
      expect(r.single.erBedsFree, isNull);
    });

    test('when paused or flagged then hidden and last', () {
      final r = _rank([
        _candidate(1, accepting: false),
        _candidate(2, flagged: true),
        _candidate(3, ageMinutes: null),
      ], EmergencyType.skipped);
      expect(r.map((x) => x.rankTier), [3, 0, 0]);
    });

    test('when no tier 1 or 2 then call 112 is shown', () {
      final r = _rank([
        _candidate(1, ageMinutes: 300),
        _candidate(2, accepting: false),
      ], EmergencyType.skipped);
      expect(Ranking.noAccepting(r), isTrue);
    });

    test('when burns then a burns unit comes before a nearer trauma unit', () {
      final r = _rank([
        _candidate(1, km: 1, caps: {Capability.trauma}),
        _candidate(2, km: 6, caps: {Capability.burns}),
      ], EmergencyType.burns);
      expect(r.first.facilityId, 2);
    });

    test('no stale or unverified facility is ever ranked as accepting', () {
      for (final age in [31, 60, 119, 120, 121, 500]) {
        final r = _rank([
          _candidate(1, ageMinutes: age, caps: {Capability.trauma}),
        ], EmergencyType.roadAccident);
        expect(r.single.rankTier, isNot(1), reason: 'age $age');
        expect(r.single.freshness, isNot(FreshnessTier.fresh));
      }
    });
  });

  group('Given HaversineRoutingService', () {
    test('when 10 km at 20 km/h then 39 minutes with road factor', () {
      expect(const HaversineRoutingService(speedKmh: 20).etaMinutes(10), 39);
    });

    test('when very close then at least 2 minutes', () {
      expect(const HaversineRoutingService(speedKmh: 20).etaMinutes(0.1), 2);
    });
  });
}
