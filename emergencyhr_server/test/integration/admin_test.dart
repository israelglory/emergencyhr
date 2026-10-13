import 'package:emergencyhr_server/src/features/admin/admin_service.dart';
import 'package:emergencyhr_server/src/features/notifications/messaging.dart';
import 'package:emergencyhr_server/src/features/onboarding/onboarding_service.dart';
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
            () => endpoints.admin.verifyListings(agent.session, [1]),
            () => endpoints.admin.directoryVerifiableIds(agent.session),
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

      test(
        'when the pipeline lists many hospitals then each checklist matches '
        'the single-hospital checklist',
        () async {
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348038880901',
            roles: [(UserRole.platformAdmin, null)],
          );
          final ready = await createFacility(
            sessionBuilder,
            name: 'Pipeline Ready Hospital',
            area: 'Pipeline Test Area',
            stage: OnboardingStage.verified,
          );
          final bare = await createFacility(
            sessionBuilder,
            name: 'Pipeline Bare Hospital',
            area: 'Pipeline Test Area',
            stage: OnboardingStage.seeded,
            verification: VerificationStatus.seeded,
          );
          await createUser(
            sessionBuilder,
            phone: '+2348038880902',
            roles: [(UserRole.hospitalAdmin, ready.id)],
          );
          await createUser(
            sessionBuilder,
            phone: '+2348038880903',
            roles: [(UserRole.deskStaff, ready.id)],
          );
          final session = sessionBuilder.build();
          await FacilityCapability.db.insertRow(
            session,
            FacilityCapability(
              facilityId: ready.id!,
              capability: Capability.trauma,
            ),
          );

          final board = await endpoints.admin.pipeline(
            admin.session,
            area: 'Pipeline Test Area',
          );

          expect(board.rows, hasLength(2));
          for (final facility in [ready, bare]) {
            final row = board.rows.singleWhere(
              (r) => r.facility.id == facility.id,
            );
            final single = await const OnboardingService().checklist(
              session,
              facility,
            );
            expect(
              row.checklistDone,
              single.items.where((i) => i.done).length,
            );
            expect(row.checklistTotal, single.items.length);
          }
          final readyRow = board.rows.singleWhere(
            (r) => r.facility.id == ready.id,
          );
          final bareRow = board.rows.singleWhere(
            (r) => r.facility.id == bare.id,
          );
          expect(readyRow.checklistDone, greaterThan(bareRow.checklistDone));
        },
      );

      test(
        'when an admin bulk verifies an area then unverified listings are '
        'verified, each audited, and suspended ones skipped',
        () async {
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348038880911',
            roles: [(UserRole.platformAdmin, null)],
          );
          const area = 'Bulk Verify Area';
          final seeded = await createFacility(
            sessionBuilder,
            name: 'Bulk A Hospital',
            area: area,
            stage: OnboardingStage.seeded,
            verification: VerificationStatus.seeded,
          );
          final pending = await createFacility(
            sessionBuilder,
            name: 'Bulk B Hospital',
            area: area,
            stage: OnboardingStage.staffTrained,
            verification: VerificationStatus.pending,
          );
          final done = await createFacility(
            sessionBuilder,
            name: 'Bulk C Hospital',
            area: area,
            stage: OnboardingStage.verified,
          );
          final suspended = await createFacility(
            sessionBuilder,
            name: 'Bulk D Hospital',
            area: area,
            stage: OnboardingStage.seeded,
            verification: VerificationStatus.suspended,
          );

          final ids = await endpoints.admin.directoryVerifiableIds(
            admin.session,
            area: area,
          );
          expect(ids, unorderedEquals([seeded.id, pending.id]));
          expect(
            await endpoints.admin.directoryAreas(admin.session),
            contains(area),
          );

          final summary = await endpoints.admin.verifyListings(
            admin.session,
            [seeded.id!, pending.id!, done.id!, suspended.id!],
          );
          expect(summary.verified, 2);
          expect(summary.alreadyVerified, 1);
          expect(summary.skipped, ['Bulk D Hospital: suspended']);

          final session = sessionBuilder.build();
          for (final f in [seeded, pending]) {
            final after = await Facility.db.findById(session, f.id!);
            expect(after!.verificationStatus, VerificationStatus.verified);
            expect(after.onboardingStage, OnboardingStage.verified);
            final record = await OnboardingRecord.db.findFirstRow(
              session,
              where: (t) => t.facilityId.equals(f.id!),
            );
            expect(record!.stage, OnboardingStage.verified);
          }
          final audit = await AdminActionLog.db.count(
            session,
            where: (t) =>
                t.actorUserId.equals(admin.user.id!) &
                t.targetId.inSet({seeded.id!, pending.id!}),
          );
          expect(audit, 2);
          expect(
            await endpoints.admin.directoryVerifiableIds(
              admin.session,
              area: area,
            ),
            isEmpty,
          );
        },
      );

      test(
        'when more than 100 listings are sent at once then it is refused',
        () async {
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348038880912',
            roles: [(UserRole.platformAdmin, null)],
          );
          await expectLater(
            endpoints.admin.verifyListings(admin.session, [
              for (var i = 1; i <= 101; i++) i,
            ]),
            throwsA(isA<ValidationException>()),
          );
        },
      );
    },
  );
}
