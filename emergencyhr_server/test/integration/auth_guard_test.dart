import 'package:emergencyhr_server/src/core/auth_guard.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given AuthGuard', (sessionBuilder, endpoints) {
    setUpAuthServices();

    test('when a guest calls account.me then it is rejected', () async {
      await expectLater(
        endpoints.account.me(sessionBuilder),
        throwsA(
          isA<NotAuthorizedException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.notAuthenticated,
          ),
        ),
      );
    });

    test(
      'when a signed-in user calls account.me then roles are returned',
      () async {
        final facility = await createFacility(sessionBuilder);
        final desk = await createUser(
          sessionBuilder,
          phone: '+2348030000001',
          roles: [(UserRole.public, null), (UserRole.deskStaff, facility.id)],
        );
        final me = await endpoints.account.me(desk.session);
        expect(me.roles.map((r) => r.role), contains(UserRole.deskStaff));
        expect(me.facilities.single.id, facility.id);
      },
    );

    test(
      'when desk staff of facility A acts on facility B then denied',
      () async {
        final a = await createFacility(sessionBuilder, name: 'Seed Hospital A');
        final b = await createFacility(sessionBuilder, name: 'Seed Hospital B');
        final desk = await createUser(
          sessionBuilder,
          phone: '+2348030000002',
          roles: [(UserRole.deskStaff, a.id)],
        );
        final session = desk.session.build();
        expect(
          await AuthGuard.hasRole(session, desk.user, {
            UserRole.deskStaff,
          }, facilityId: a.id),
          isTrue,
        );
        expect(
          await AuthGuard.hasRole(session, desk.user, {
            UserRole.deskStaff,
          }, facilityId: b.id),
          isFalse,
        );
      },
    );

    test('when a public user needs desk staff then denied', () async {
      final facility = await createFacility(sessionBuilder);
      final public = await createUser(sessionBuilder, phone: '+2348030000003');
      await expectLater(
        AuthGuard.requireRole(public.session.build(), {
          UserRole.deskStaff,
          UserRole.hospitalAdmin,
        }, facilityId: facility.id),
        throwsA(
          isA<NotAuthorizedException>().having(
            (e) => e.code,
            'code',
            AppErrorCode.notAuthorized,
          ),
        ),
      );
    });

    test('when a field agent covers the area then allowed', () async {
      final facility = await createFacility(sessionBuilder, area: 'Yaba');
      final agent = await createUser(
        sessionBuilder,
        phone: '+2348030000004',
        roles: [(UserRole.fieldAgent, null)],
      );
      await FieldAgentArea.db.insertRow(
        sessionBuilder.build(),
        FieldAgentArea(userId: agent.user.id!, area: 'Yaba'),
      );
      expect(
        await AuthGuard.hasRole(agent.session.build(), agent.user, {
          UserRole.fieldAgent,
        }, facilityId: facility.id),
        isTrue,
      );
    });

    test('when an account is suspended then it acts as a guest', () async {
      final user = await createUser(sessionBuilder, phone: '+2348030000005');
      await AppUser.db.updateRow(
        sessionBuilder.build(),
        user.user.copyWith(suspendedAt: DateTime.now().toUtc()),
      );
      await expectLater(
        endpoints.account.me(user.session),
        throwsA(isA<NotAuthorizedException>()),
      );
    });
  });
}
