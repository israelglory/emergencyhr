import 'dart:convert';

import 'package:emergencyhr_server/src/features/telegram/logic/bot_actions.dart';
import 'package:emergencyhr_server/src/features/telegram/logic/bot_copy.dart';
import 'package:emergencyhr_server/src/features/telegram/logic/bot_message.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

final _now = DateTime.utc(2026, 10, 8, 12);

EmergencyResult _result(
  int id, {
  String? name,
  int tier = 1,
  FreshnessTier freshness = FreshnessTier.fresh,
  String? phone = '+2348012345678',
}) => EmergencyResult(
  facilityId: id,
  name: name ?? 'Hospital $id',
  address: 'a',
  area: 'Ikeja',
  lat: 6.6,
  lng: 3.35,
  deskPhone: phone,
  distanceKm: 2.34,
  etaMinutes: 7,
  rankTier: tier,
  freshness: freshness,
  statusUpdatedAt: _now.subtract(const Duration(minutes: 12)),
  erBedsFree: 3,
  icuBedsFree: 1,
  doctorOnDuty: true,
  depositRequired: false,
  capabilities: const [],
  match: CapabilityMatch.full,
  flagged: false,
);

/// Every button's data must fit Telegram's 64-byte limit.
void _expectButtonsFit(BotMessage message) {
  for (final row in message.buttons) {
    for (final b in row) {
      if (b.callbackData != null) {
        expect(utf8.encode(b.callbackData!).length, lessThanOrEqualTo(64));
      }
    }
  }
}

void main() {
  group('Given bot button data', () {
    test('when a status draft is written and read then it is unchanged', () {
      const draft = StatusDraft(
        facilityId: 663,
        accepting: false,
        erBeds: 12,
        icuBeds: 4,
      );
      final edit = BotAction.parse(draft.editData);
      final save = BotAction.parse(draft.saveData);
      expect(edit, isA<EditDraft>());
      expect(save, isA<SaveDraft>());
      final read = (save as SaveDraft).draft;
      expect(read.facilityId, 663);
      expect(read.accepting, isFalse);
      expect(read.erBeds, 12);
      expect(read.icuBeds, 4);
    });

    test('when a type filter is read then the place and type come back', () {
      final action = BotAction.parse('t:breathingDifficulty:6.60180:3.35150');
      expect(action, isA<FilterType>());
      final f = action! as FilterType;
      expect(f.type, EmergencyType.breathingDifficulty);
      expect(f.lat, closeTo(6.6018, 1e-9));
    });

    test('when data is unknown or broken then nothing happens', () {
      expect(BotAction.parse(''), isNull);
      expect(BotAction.parse('x:1'), isNull);
      expect(BotAction.parse('t:notAType:1:2'), isNull);
      expect(BotAction.parse('v:1:1:2'), isNull);
    });

    test('when beds go below zero then they stay at zero', () {
      const draft = StatusDraft(
        facilityId: 1,
        accepting: true,
        erBeds: 0,
        icuBeds: 0,
      );
      expect(draft.copyWith(erBeds: -1).erBeds, 0);
    });
  });

  group('Given hospital results', () {
    test('when some are hidden then only visible ones are listed', () {
      final message = BotCopy.results(
        ranked: [
          _result(1, name: 'Alpha <A&B>'),
          _result(2, tier: 0, name: 'Hidden One'),
          _result(3, freshness: FreshnessTier.unverified, tier: 3),
        ],
        showCall112: false,
        type: EmergencyType.skipped,
        lat: 6.6018,
        lng: 3.3515,
        now: _now,
      );
      expect(message.text, contains('Alpha &lt;A&amp;B&gt;'));
      expect(message.text, isNot(contains('Hidden One')));
      expect(
        message.text,
        contains('Accepting emergencies. Confirmed 12 min ago.'),
      );
      expect(message.text, contains('Unverified. Call before going.'));
      expect(message.text, contains('call <b>112</b>'));
      // Two directions buttons, then the "What happened" rows.
      expect(message.buttons.first.single.url, contains('destination=6.60000'));
      _expectButtonsFit(message);
    });

    test('when nothing is found then the message says to call 112', () {
      final message = BotCopy.results(
        ranked: const [],
        showCall112: true,
        type: EmergencyType.burns,
        lat: 9,
        lng: 7,
        now: _now,
      );
      expect(message.text, contains('No hospitals found within 25 km'));
    });

    test('when only unverified hospitals are near then 112 is shown first', () {
      final message = BotCopy.results(
        ranked: [_result(1, freshness: FreshnessTier.unverified, tier: 3)],
        showCall112: true,
        type: EmergencyType.skipped,
        lat: 9,
        lng: 7,
        now: _now,
      );
      expect(message.text, contains('No hospital within 25 km is confirmed'));
    });
  });

  group('Given the staff panel', () {
    final facility = Facility(
      id: 7,
      name: 'Desk Hospital',
      type: FacilityType.private,
      address: 'a',
      area: 'Ikeja',
      lat: 6.6,
      lng: 3.35,
      verificationStatus: VerificationStatus.verified,
      onboardingStage: OnboardingStage.live,
      source: FacilitySource.seeded,
    );
    final saved = FacilityStatus(
      facilityId: 7,
      accepting: true,
      erBedsFree: 2,
      icuBedsFree: 0,
      doctorOnDuty: true,
      depositRequired: false,
      updatedAt: _now.subtract(const Duration(minutes: 40)),
    );

    test('when nothing changed then Still accurate is offered', () {
      final message = BotCopy.panel(
        facility: facility,
        saved: saved,
        draft: StatusDraft.from(7, saved),
        now: _now,
      );
      expect(message.text, contains('Updated 40 min ago'));
      expect(message.buttons.last.single.text, 'Still accurate');
      _expectButtonsFit(message);
    });

    test('when beds changed then Save update is offered', () {
      final message = BotCopy.panel(
        facility: facility,
        saved: saved,
        draft: StatusDraft.from(7, saved).copyWith(erBeds: 5),
        now: _now,
      );
      expect(message.text, contains('ER beds 5'));
      expect(message.buttons.last.single.text, 'Save update');
      expect(message.buttons.last.single.callbackData, 'v:7:1:5:0');
    });
  });
}
