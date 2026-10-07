import 'package:emergencyhr_server/src/features/notifications/messaging.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  late CapturingSmsGateway sms;
  setUp(() => Messaging.smsOverride = sms = CapturingSmsGateway());
  tearDown(() => Messaging.smsOverride = null);

  withServerpod(
    'Given a profile',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      EmergencyContact contact(String phone) => EmergencyContact(
        userId: 0,
        name: 'Mum',
        phone: phone,
        channel: ContactChannel.sms,
      );

      test(
        'when saving medical details without consent then refused',
        () async {
          final user = await createUser(
            sessionBuilder,
            phone: '+2348036660001',
          );
          await expectLater(
            endpoints.profile.saveMedical(
              user.session,
              MedicalProfileData(allergies: 'Penicillin'),
              false,
            ),
            throwsA(isA<ValidationException>()),
          );
        },
      );

      test('when saving with consent then it is encrypted at rest', () async {
        final user = await createUser(sessionBuilder, phone: '+2348036660002');
        final saved = await endpoints.profile.saveMedical(
          user.session,
          MedicalProfileData(allergies: 'Penicillin', bloodGroup: 'O+'),
          true,
        );
        expect(saved.allergies, 'Penicillin');
        expect(saved.consentAt, isNotNull);
        final row = await MedicalProfile.db.findFirstRow(
          sessionBuilder.build(),
          where: (t) => t.userId.equals(user.user.id!),
        );
        expect(row!.allergiesEnc, isNot(contains('Penicillin')));
      });

      test('when adding a fourth contact then refused', () async {
        final user = await createUser(sessionBuilder, phone: '+2348036660003');
        for (var i = 1; i <= 3; i++) {
          await endpoints.profile.saveContact(
            user.session,
            contact('0803666100$i'),
          );
        }
        await expectLater(
          endpoints.profile.saveContact(user.session, contact('08036661004')),
          throwsA(isA<ValidationException>()),
        );
      });

      test(
        'when notifying family then each contact gets the message',
        () async {
          final user = await createUser(
            sessionBuilder,
            phone: '+2348036660004',
          );
          await endpoints.profile.saveContact(
            user.session,
            contact('08036662001'),
          );
          final search = await endpoints.emergency.start(
            user.session,
            6.6,
            3.35,
            EmergencyType.skipped,
            area: null,
            tappedAt: null,
          );
          final result = await endpoints.emergency.notifyFamily(
            user.session,
            search.sessionId,
            search.accessToken,
          );
          expect(result.results.single.sentVia, ContactChannel.sms);
          expect(sms.messages.last.to, '+2348036662001');
          expect(sms.messages.last.message, contains('Sent via EmergencyHr.'));
        },
      );

      test(
        'when exporting then data is included; when deleting then gone',
        () async {
          final user = await createUser(
            sessionBuilder,
            phone: '+2348036660005',
          );
          await endpoints.profile.saveContact(
            user.session,
            contact('08036663001'),
          );
          final json = await endpoints.profile.exportMyData(user.session);
          expect(json, contains('+2348036663001'));
          await endpoints.profile.deleteMyAccount(user.session);
          expect(
            await AppUser.db.findById(sessionBuilder.build(), user.user.id!),
            isNull,
          );
          expect(
            await EmergencyContact.db.count(
              sessionBuilder.build(),
              where: (t) => t.userId.equals(user.user.id!),
            ),
            0,
          );
        },
      );

      test(
        'when a user reads another user’s contact by id then not found',
        () async {
          final a = await createUser(sessionBuilder, phone: '+2348036660006');
          final b = await createUser(sessionBuilder, phone: '+2348036660007');
          final saved = await endpoints.profile.saveContact(
            a.session,
            contact('08036664001'),
          );
          await expectLater(
            endpoints.profile.saveContact(
              b.session,
              saved.copyWith(name: 'Hijack'),
            ),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    },
  );
}
