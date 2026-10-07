import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart' show UuidValue;
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given email sign-in',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      Future<UuidValue> emailAccount(String email, String password) async {
        final session = sessionBuilder.build();
        final authUser = await AuthServices.instance.authUsers.create(session);
        await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
          session,
          authUserId: authUser.id,
          email: email,
          password: password,
        );
        return authUser.id;
      }

      test('when signing in with the right password then a session is issued '
          'and a public account is created', () async {
        await emailAccount('ada@test.emergencyhr', 'Correct-horse-1');
        final auth = await endpoints.emailIdp.login(
          sessionBuilder,
          email: 'ada@test.emergencyhr',
          password: 'Correct-horse-1',
        );
        final signedIn = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            auth.authUserId.toString(),
            {},
          ),
        );
        final me = await endpoints.account.me(signedIn);
        expect(me.roles.map((r) => r.role), [UserRole.public]);
        expect(me.user.phone, isNull);
      });

      test('when the password is wrong then sign-in fails', () async {
        await emailAccount('bola@test.emergencyhr', 'Correct-horse-1');
        await expectLater(
          endpoints.emailIdp.login(
            sessionBuilder,
            email: 'bola@test.emergencyhr',
            password: 'wrong-password',
          ),
          throwsA(isA<EmailAccountLoginException>()),
        );
      });

      test('when the account was created at registration then the hook links '
          'its email', () async {
        final user = await createUser(sessionBuilder, phone: '+2348039991001');
        expect(user.user.email, emailFor('+2348039991001'));
      });

      test('when a phone is added later then it is saved, and another account '
          'cannot reuse it', () async {
        final a = await createUser(sessionBuilder, phone: '+2348039991002');
        final b = await createUser(sessionBuilder, phone: '+2348039991003');
        final updated = await endpoints.account.updatePhone(
          a.session,
          '0803 999 1004',
        );
        expect(updated.user.phone, '+2348039991004');
        await expectLater(
          endpoints.account.updatePhone(b.session, '08039991004'),
          throwsA(isA<ConflictException>()),
        );
        final cleared = await endpoints.account.updatePhone(a.session, null);
        expect(cleared.user.phone, isNull);
      });
    },
  );
}
