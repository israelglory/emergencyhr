import 'package:emergencyhr_server/src/features/facilities/logic/duplicate_rules.dart';
import 'package:emergencyhr_server/src/features/facilities/logic/opening_hours_rules.dart';
import 'package:emergencyhr_server/src/features/onboarding/logic/checklist_rules.dart';
import 'package:emergencyhr_server/src/features/onboarding/logic/stage_rules.dart';
import 'package:emergencyhr_server/src/features/status/logic/freshness_rules.dart';
import 'package:emergencyhr_server/src/features/status/status_service.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('Given DuplicateRules', () {
    test('when names differ only by filler words then similarity is high', () {
      expect(
        DuplicateRules.similarity(
          'St. Mary Hospital',
          'St Mary Specialist Hospital Ltd',
        ),
        greaterThanOrEqualTo(0.85),
      );
    });

    test('when similar names are 100 m apart then it is a strong match', () {
      final s = DuplicateRules.similarity('Gold Cross Clinic', 'Goldcross');
      expect(DuplicateRules.isStrongMatch(s, 100), isTrue);
    });

    test('when different names are 100 m apart then not a strong match', () {
      final s = DuplicateRules.similarity('Lagoon Hospital', 'Reddington');
      expect(DuplicateRules.isStrongMatch(s, 100), isFalse);
      expect(DuplicateRules.isCandidate(s, 100), isTrue);
    });

    test('when the same name is 5 km away then not a duplicate', () {
      expect(DuplicateRules.isStrongMatch(1, 5000), isFalse);
    });
  });

  group('Given StageRules', () {
    String? move(
      OnboardingStage from,
      OnboardingStage to, {
      bool admin = false,
      bool trained = false,
    }) => StageRules.checkManualMove(
      from: from,
      to: to,
      isPlatformAdmin: admin,
      trainingCompleted: trained,
    );

    test('when moving manually to live then refused, even for admins', () {
      expect(move(OnboardingStage.verified, OnboardingStage.live), isNotNull);
      expect(
        move(OnboardingStage.verified, OnboardingStage.live, admin: true),
        isNotNull,
      );
    });

    test('when moving manually to verified then refused', () {
      expect(
        move(OnboardingStage.staffTrained, OnboardingStage.verified),
        isNotNull,
      );
    });

    test('when an agent moves forward from seeded to visited then allowed', () {
      expect(move(OnboardingStage.seeded, OnboardingStage.visited), isNull);
    });

    test('when an agent moves backwards then refused', () {
      expect(
        move(OnboardingStage.visited, OnboardingStage.contacted),
        isNotNull,
      );
      expect(
        move(OnboardingStage.visited, OnboardingStage.contacted, admin: true),
        isNull,
      );
    });

    test('when marking staff trained without training then refused', () {
      expect(
        move(OnboardingStage.visited, OnboardingStage.staffTrained),
        isNotNull,
      );
      expect(
        move(
          OnboardingStage.visited,
          OnboardingStage.staffTrained,
          trained: true,
        ),
        isNull,
      );
    });
  });

  group('Given ChecklistRules', () {
    ChecklistFacts facts({bool verified = true, int desk = 1}) =>
        ChecklistFacts(
          verified: verified,
          hospitalAdminCount: 1,
          activeDeskStaffCount: desk,
          capabilityCount: 2,
          hasOpeningHours: true,
          deskPhoneConfirmed: true,
          trainingCompleted: true,
          hasRealStatus: true,
        );

    test('when every fact holds then complete', () {
      expect(ChecklistRules.build(1, facts()).complete, isTrue);
    });

    test('when not verified then incomplete', () {
      expect(ChecklistRules.build(1, facts(verified: false)).complete, isFalse);
    });

    test('when no active desk staff then incomplete', () {
      final list = ChecklistRules.build(1, facts(desk: 0));
      expect(list.complete, isFalse);
      expect(
        list.items
            .firstWhere((i) => i.key == ChecklistKey.deskStaffActive)
            .done,
        isFalse,
      );
    });
  });

  group('Given OpeningHoursRules', () {
    final weekdays = OpeningHours(
      alwaysOpen: false,
      periods: [
        OpeningPeriod(weekday: 1, openMinute: 8 * 60, closeMinute: 20 * 60),
      ],
    );
    final overnight = OpeningHours(
      alwaysOpen: false,
      periods: [
        OpeningPeriod(weekday: 1, openMinute: 20 * 60, closeMinute: 6 * 60),
      ],
    );

    test('when 09:00 Lagos on Monday then open', () {
      // 2026-10-05 is a Monday. 08:00 UTC is 09:00 in Lagos.
      expect(
        OpeningHoursRules.isOpen(weekdays, DateTime.utc(2026, 10, 5, 8)),
        isTrue,
      );
    });

    test('when 21:00 Lagos on Monday then closed', () {
      expect(
        OpeningHoursRules.isOpen(weekdays, DateTime.utc(2026, 10, 5, 20)),
        isFalse,
      );
    });

    test('when 02:00 Lagos Tuesday on an overnight Monday shift then open', () {
      expect(
        OpeningHoursRules.isOpen(overnight, DateTime.utc(2026, 10, 6, 1)),
        isTrue,
      );
    });

    test('when hours are unknown then treated as open', () {
      expect(OpeningHoursRules.isOpen(null, DateTime.utc(2026)), isTrue);
    });
  });

  group('Given FreshnessRules', () {
    final now = DateTime.utc(2026, 10, 6, 12);
    FacilityStatus status(int minutesAgo, {bool accepting = true}) =>
        FacilityStatus(
          facilityId: 1,
          accepting: accepting,
          erBedsFree: 1,
          icuBedsFree: 0,
          doctorOnDuty: true,
          depositRequired: false,
          updatedAt: now.subtract(Duration(minutes: minutesAgo)),
        );
    FreshnessTier tier(
      FacilityStatus? s, {
      bool live = true,
      bool flagged = false,
    }) => FreshnessRules.classify(
      status: s,
      live: live,
      flagged: flagged,
      now: now,
    );

    test('when confirmed 30 min ago then fresh', () {
      expect(tier(status(30)), FreshnessTier.fresh);
    });

    test('when confirmed 31 min ago then stale', () {
      expect(tier(status(31)), FreshnessTier.stale);
    });

    test('when confirmed 121 min ago then unverified, never accepting', () {
      expect(tier(status(121)), FreshnessTier.unverified);
    });

    test('when never confirmed then unverified', () {
      expect(tier(null), FreshnessTier.unverified);
    });

    test('when not live then unverified even if fresh', () {
      expect(tier(status(1), live: false), FreshnessTier.unverified);
    });

    test('when flagged then unverified even if fresh', () {
      expect(tier(status(1), flagged: true), FreshnessTier.unverified);
    });

    test('when paused then paused', () {
      expect(tier(status(1, accepting: false)), FreshnessTier.paused);
    });
  });

  group('Given StatusService.describe', () {
    test('when beds and accepting change then both are described', () {
      expect(
        StatusService.describe(
          '{"accepting":true,"erBedsFree":3,"icuBedsFree":1,'
              '"doctorOnDuty":true,"depositRequired":false}',
          '{"accepting":false,"erBedsFree":0,"icuBedsFree":1,'
              '"doctorOnDuty":true,"depositRequired":false}',
        ),
        'Paused; ER beds 3 to 0',
      );
    });

    test('when confirmed then says so', () {
      expect(
        StatusService.describe('{}', '{"confirmed":true}'),
        'Confirmed still accurate',
      );
    });
  });
}
