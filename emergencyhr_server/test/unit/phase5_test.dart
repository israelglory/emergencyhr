import 'dart:math';

import 'package:emergencyhr_server/src/core/field_crypto.dart';
import 'package:emergencyhr_server/src/features/profile/family_alert_service.dart';
import 'package:emergencyhr_server/src/features/profile/first_aid_service.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('Given FieldCrypto', () {
    final key = List<int>.generate(32, (_) => Random.secure().nextInt(256));

    test(
      'when encrypting then the text round-trips and is not readable',
      () async {
        final crypto = FieldCrypto(key);
        final sealed = await crypto.encrypt('Penicillin allergy');
        expect(sealed, isNot(contains('Penicillin')));
        expect(await crypto.decrypt(sealed), 'Penicillin allergy');
      },
    );

    test('when the same text is encrypted twice then outputs differ', () async {
      final crypto = FieldCrypto(key);
      expect(await crypto.encrypt('O+'), isNot(await crypto.encrypt('O+')));
    });
  });

  group('Given FamilyAlertService.message', () {
    test('when heading to a hospital then it names it and links the map', () {
      final text = FamilyAlertService.message(
        name: 'Ada',
        hospital: 'Seed Hospital 01, Ikeja',
        lat: 6.6,
        lng: 3.35,
      );
      expect(
        text,
        startsWith(
          'Ada may be having a medical emergency and is heading to '
          'Seed Hospital 01, Ikeja. Location: https://www.google.com/maps',
        ),
      );
      expect(text, endsWith('Sent via Emergencyhr.'));
    });
  });

  group('Given the first-aid content', () {
    final cards = FirstAidService.cards();

    test('when loaded then every emergency type has a card', () {
      expect(
        cards.map((c) => c.type).toSet(),
        EmergencyType.values.toSet(),
      );
    });

    test('when loaded then no card has more than 6 steps and all have a '
        "Don't section", () {
      for (final c in cards) {
        expect(c.doSteps.length, lessThanOrEqualTo(6), reason: c.type.name);
        expect(c.dontSteps, isNotEmpty, reason: c.type.name);
      }
    });

    test('when loaded then the copy has no em dashes', () {
      for (final c in cards) {
        final text = [c.title, c.summary, ...c.doSteps, ...c.dontSteps].join();
        expect(text, isNot(contains('—')), reason: c.type.name);
      }
    });
  });
}
