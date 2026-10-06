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
    'Given phone sign-in',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      const phone = '08031234567';
      const normalised = '+2348031234567';

      test(
        'when requesting a code then an SMS with 6 digits is sent',
        () async {
          final result = await endpoints.phoneAuth.requestCode(
            sessionBuilder,
            phone,
          );
          expect(result.phone, normalised);
          expect(result.codeLength, 6);
          expect(sms.lastCodeFor(normalised), matches(RegExp(r'^\d{6}$')));
        },
      );

      test(
        'when verifying the right code then a public account is created',
        () async {
          const other = '+2348031230000';
          await endpoints.phoneAuth.requestCode(sessionBuilder, other);
          final auth = await endpoints.phoneAuth.verifyCode(
            sessionBuilder,
            other,
            sms.lastCodeFor(other),
          );
          expect(auth.authUserId, isNotNull);

          final user = await AppUser.db.findFirstRow(
            sessionBuilder.build(),
            where: (t) => t.phone.equals(other),
          );
          final roles = await RoleAssignment.db.find(
            sessionBuilder.build(),
            where: (t) => t.userId.equals(user!.id!),
          );
          expect(roles.map((r) => r.role), [UserRole.public]);
        },
      );

      test('when verifying a wrong code then it is rejected', () async {
        const other = '+2348031231111';
        await endpoints.phoneAuth.requestCode(sessionBuilder, other);
        final right = sms.lastCodeFor(other);
        final wrong = right == '000000' ? '111111' : '000000';
        await expectLater(
          endpoints.phoneAuth.verifyCode(sessionBuilder, other, wrong),
          throwsA(
            isA<InvalidStateException>().having(
              (e) => e.code,
              'code',
              AppErrorCode.otpInvalid,
            ),
          ),
        );
      });

      test('when a code is used twice then the second use fails', () async {
        const other = '+2348031232222';
        await endpoints.phoneAuth.requestCode(sessionBuilder, other);
        final code = sms.lastCodeFor(other);
        await endpoints.phoneAuth.verifyCode(sessionBuilder, other, code);
        await expectLater(
          endpoints.phoneAuth.verifyCode(sessionBuilder, other, code),
          throwsA(
            isA<InvalidStateException>().having(
              (e) => e.code,
              'code',
              AppErrorCode.otpExpired,
            ),
          ),
        );
      });

      test(
        'when requesting again within 30 seconds then rate limited',
        () async {
          const other = '+2348031233333';
          await endpoints.phoneAuth.requestCode(sessionBuilder, other);
          await expectLater(
            endpoints.phoneAuth.requestCode(sessionBuilder, other),
            throwsA(isA<RateLimitedException>()),
          );
        },
      );

      test('when the phone number is invalid then validation fails', () async {
        await expectLater(
          endpoints.phoneAuth.requestCode(sessionBuilder, '12'),
          throwsA(isA<ValidationException>()),
        );
      });
    },
  );
}
