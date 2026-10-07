import 'package:emergencyhr_server/src/features/admin/admin_service.dart';
import 'package:emergencyhr_server/src/features/notifications/messaging.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  setUp(() => Messaging.smsOverride = CapturingSmsGateway());
  tearDown(() => Messaging.smsOverride = null);

  test('Given a live facility, when 49 hours pass without an update, then '
      'it is quiet', () {
    final now = DateTime.utc(2026, 10, 6);
    expect(
      AdminService.isQuiet(
        lastUpdateAt: now.subtract(const Duration(hours: 49)),
        liveAt: now.subtract(const Duration(days: 5)),
        now: now,
      ),
      isTrue,
    );
    expect(
      AdminService.isQuiet(
        lastUpdateAt: now.subtract(const Duration(hours: 2)),
        liveAt: now.subtract(const Duration(days: 5)),
        now: now,
      ),
      isFalse,
    );
  });

  withServerpod(
    'Given the admin endpoints',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test(
        'when a non-admin calls admin methods then every call is denied',
        () async {
          final agent = await createUser(
            sessionBuilder,
            phone: '+2348038880001',
            roles: [(UserRole.fieldAgent, null)],
          );
          final calls = <Future<Object?> Function()>[
            () => endpoints.admin.verificationQueue(
              agent.session,
              limit: 10,
              offset: 0,
            ),
            () => endpoints.admin.metrics(agent.session),
            () => endpoints.admin.agents(agent.session),
            () => endpoints.admin.approve(agent.session, 1),
            () => endpoints.admin.setUserSuspended(agent.session, 1, true, 'x'),
          ];
          for (final call in calls) {
            await expectLater(call(), throwsA(isA<NotAuthorizedException>()));
          }
        },
      );

      test('when an admin suspends a facility then it leaves the emergency '
          'results', () async {
        final admin = await createUser(
          sessionBuilder,
          phone: '+2348038880002',
          roles: [(UserRole.platformAdmin, null)],
        );
        final f = await createFacility(
          sessionBuilder,
          name: 'Seed Suspend Me',
          lat: 10.0,
          lng: 7.0,
        );
        await endpoints.admin.setFacilitySuspended(
          admin.session,
          f.id!,
          true,
          'Closed for renovation',
        );
        final search = await endpoints.emergency.start(
          sessionBuilder,
          10.0,
          7.0,
          EmergencyType.skipped,
          area: null,
          tappedAt: null,
        );
        expect(search.results.where((r) => r.facilityId == f.id), isEmpty);
      });

      test('when sessions are acted on then the median time to action is '
          'reported', () async {
        final admin = await createUser(
          sessionBuilder,
          phone: '+2348038880003',
          roles: [(UserRole.platformAdmin, null)],
        );
        final now = DateTime.now().toUtc();
        for (final seconds in [30, 60, 90]) {
          await EmergencySession.db.insertRow(
            sessionBuilder.build(),
            EmergencySession(
              lat: 0,
              lng: 0,
              emergencyType: EmergencyType.skipped,
              resultsShown: [],
              action: EmergencyAction.call,
              startedAt: now.subtract(const Duration(hours: 1)),
              actedAt: now
                  .subtract(const Duration(hours: 1))
                  .add(Duration(seconds: seconds)),
            ),
          );
        }
        final m = await endpoints.admin.metrics(admin.session);
        expect(m.medianSecondsToAction, 60);
      });

      test(
        'when an admin adds an agent then the agent has the role and areas',
        () async {
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348038880004',
            roles: [(UserRole.platformAdmin, null)],
          );
          await createUser(sessionBuilder, phone: '+2348038880005');
          final row = await endpoints.admin.addAgent(
            admin.session,
            emailFor('+2348038880005'),
            ['Yaba'],
          );
          expect(row.areas, ['Yaba']);
          final roles = await RoleAssignment.db.find(
            sessionBuilder.build(),
            where: (t) => t.userId.equals(row.userId),
          );
          expect(roles.map((r) => r.role), contains(UserRole.fieldAgent));
        },
      );

      test(
        'when no account uses the email then adding an agent is refused',
        () async {
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348038880007',
            roles: [(UserRole.platformAdmin, null)],
          );
          await expectLater(
            endpoints.admin.addAgent(admin.session, 'nobody@test.emergencyhr', [
              'Yaba',
            ]),
            throwsA(isA<ValidationException>()),
          );
        },
      );

      test('when an admin suspends their own account then refused', () async {
        final admin = await createUser(
          sessionBuilder,
          phone: '+2348038880006',
          roles: [(UserRole.platformAdmin, null)],
        );
        await expectLater(
          endpoints.admin.setUserSuspended(
            admin.session,
            admin.user.id!,
            true,
            'test',
          ),
          throwsA(isA<InvalidStateException>()),
        );
      });
    },
  );
}
