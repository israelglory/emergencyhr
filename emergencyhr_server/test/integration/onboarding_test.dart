import 'package:emergencyhr_server/src/core/clock.dart';
import 'package:emergencyhr_server/src/features/notifications/messaging.dart';
import 'package:emergencyhr_server/src/features/onboarding/onboarding_service.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

final _input = StatusInputs.accepting;

abstract final class StatusInputs {
  static final accepting = StatusInput(
    accepting: true,
    erBedsFree: 2,
    icuBedsFree: 1,
    doctorOnDuty: true,
    depositRequired: false,
  );
}

void main() {
  setUp(() => Messaging.smsOverride = CapturingSmsGateway());
  tearDown(() {
    Messaging.smsOverride = null;
    clock = const SystemClock();
  });

  withServerpod(
    'Given facility status',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test(
        'when desk staff of A updates A then it is saved and logged',
        () async {
          final a = await createFacility(sessionBuilder, name: 'Seed Status A');
          final desk = await createUser(
            sessionBuilder,
            phone: '+2348031110001',
            roles: [(UserRole.deskStaff, a.id)],
          );
          final status = await endpoints.status.update(
            desk.session,
            a.id!,
            _input,
          );
          expect(status.erBedsFree, 2);
          final log = await endpoints.status.auditLog(
            desk.session,
            a.id!,
            limit: 50,
            offset: 0,
          );
          expect(log.single.summary, contains('Accepting'));
        },
      );

      test('when desk staff of A updates B then denied', () async {
        final a = await createFacility(sessionBuilder, name: 'Seed Status A2');
        final b = await createFacility(sessionBuilder, name: 'Seed Status B2');
        final desk = await createUser(
          sessionBuilder,
          phone: '+2348031110002',
          roles: [(UserRole.deskStaff, a.id)],
        );
        await expectLater(
          endpoints.status.update(desk.session, b.id!, _input),
          throwsA(isA<NotAuthorizedException>()),
        );
      });

      test('when a public user sets status then denied', () async {
        final a = await createFacility(sessionBuilder, name: 'Seed Status C');
        final user = await createUser(sessionBuilder, phone: '+2348031110003');
        await expectLater(
          endpoints.status.update(user.session, a.id!, _input),
          throwsA(isA<NotAuthorizedException>()),
        );
      });

      test('when beds are negative then validation fails', () async {
        final a = await createFacility(sessionBuilder, name: 'Seed Status D');
        final desk = await createUser(
          sessionBuilder,
          phone: '+2348031110004',
          roles: [(UserRole.deskStaff, a.id)],
        );
        await expectLater(
          endpoints.status.update(
            desk.session,
            a.id!,
            _input.copyWith(erBedsFree: -1),
          ),
          throwsA(isA<ValidationException>()),
        );
      });

      test('when practising then the public status is not touched', () async {
        final a = await createFacility(
          sessionBuilder,
          name: 'Seed Status E',
          stage: OnboardingStage.visited,
          verification: VerificationStatus.seeded,
        );
        final desk = await createUser(
          sessionBuilder,
          phone: '+2348031110005',
          roles: [(UserRole.deskStaff, a.id)],
        );
        await endpoints.status.practice(desk.session, a.id!, _input);
        expect(await endpoints.status.current(desk.session, a.id!), isNull);
        final f = await Facility.db.findById(sessionBuilder.build(), a.id!);
        expect(f!.trainingCompletedAt, isNotNull);
        expect(f.onboardingStage, OnboardingStage.staffTrained);
      });
    },
  );

  withServerpod(
    'Given invites',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test('when an invite is used twice then the second use fails', () async {
        final f = await createFacility(sessionBuilder, name: 'Seed Invite A');
        final agent = await createUser(
          sessionBuilder,
          phone: '+2348032220001',
          roles: [(UserRole.fieldAgent, null)],
        );
        await assignAgent(sessionBuilder, f.id!, agent.user.id!);
        final created = await endpoints.invite.create(
          agent.session,
          f.id!,
          UserRole.deskStaff,
        );
        final first = await createUser(sessionBuilder, phone: '+2348032220002');
        final second = await createUser(
          sessionBuilder,
          phone: '+2348032220003',
        );
        await endpoints.invite.accept(first.session, created.invite.shortCode);
        await expectLater(
          endpoints.invite.accept(second.session, created.invite.shortCode),
          throwsA(isA<InvalidStateException>()),
        );
      });

      test(
        'when an invite is older than 72 hours then it has expired',
        () async {
          final f = await createFacility(sessionBuilder, name: 'Seed Invite B');
          final agent = await createUser(
            sessionBuilder,
            phone: '+2348032220004',
            roles: [(UserRole.fieldAgent, null)],
          );
          await assignAgent(sessionBuilder, f.id!, agent.user.id!);
          final created = await endpoints.invite.create(
            agent.session,
            f.id!,
            UserRole.deskStaff,
          );
          clock = FixedClock(
            DateTime.now().toUtc().add(const Duration(hours: 73)),
          );
          final user = await createUser(
            sessionBuilder,
            phone: '+2348032220005',
          );
          await expectLater(
            endpoints.invite.accept(user.session, created.invite.shortCode),
            throwsA(isA<InvalidStateException>()),
          );
        },
      );

      test('when the invite is for another email then denied', () async {
        final f = await createFacility(sessionBuilder, name: 'Seed Invite C');
        final agent = await createUser(
          sessionBuilder,
          phone: '+2348032220006',
          roles: [(UserRole.fieldAgent, null)],
        );
        await assignAgent(sessionBuilder, f.id!, agent.user.id!);
        final created = await endpoints.invite.create(
          agent.session,
          f.id!,
          UserRole.hospitalAdmin,
          email: 'Invited@Hospital.test',
        );
        expect(created.invite.email, 'invited@hospital.test');
        final other = await createUser(sessionBuilder, phone: '+2348032220008');
        await expectLater(
          endpoints.invite.accept(other.session, created.link.split('/').last),
          throwsA(isA<NotAuthorizedException>()),
        );
      });

      test(
        'when a hospital admin invites a hospital admin then denied',
        () async {
          final f = await createFacility(sessionBuilder, name: 'Seed Invite D');
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348032220009',
            roles: [(UserRole.hospitalAdmin, f.id)],
          );
          await expectLater(
            endpoints.invite.create(
              admin.session,
              f.id!,
              UserRole.hospitalAdmin,
            ),
            throwsA(isA<NotAuthorizedException>()),
          );
        },
      );
    },
  );

  withServerpod(
    'Given onboarding to go-live',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test(
        'when an agent tries to approve their own submission then denied',
        () async {
          final f = await createFacility(
            sessionBuilder,
            name: 'Seed Golive A',
            stage: OnboardingStage.staffTrained,
            verification: VerificationStatus.pending,
          );
          final both = await createUser(
            sessionBuilder,
            phone: '+2348033330001',
            roles: [
              (UserRole.fieldAgent, null),
              (UserRole.platformAdmin, null),
            ],
          );
          final session = sessionBuilder.build();
          final record = await const OnboardingService().recordFor(session, f);
          await OnboardingRecord.db.updateRow(
            session,
            record.copyWith(submittedByUserId: both.user.id),
          );
          await expectLater(
            const OnboardingService().approve(
              session,
              facility: f,
              admin: both.user,
            ),
            throwsA(isA<NotAuthorizedException>()),
          );
        },
      );

      test(
        'when the checklist completes then the facility goes live',
        () async {
          final session = sessionBuilder.build();
          var f = await createFacility(
            sessionBuilder,
            name: 'Seed Golive B',
            stage: OnboardingStage.staffTrained,
            verification: VerificationStatus.pending,
          );
          f = await Facility.db.updateRow(
            session,
            f.copyWith(
              deskPhone: '+2348033339999',
              deskPhoneConfirmedAt: DateTime.now().toUtc(),
              trainingCompletedAt: DateTime.now().toUtc(),
              openingHours: OpeningHours(alwaysOpen: true, periods: []),
            ),
          );
          await FacilityCapability.db.insertRow(
            session,
            FacilityCapability(
              facilityId: f.id!,
              capability: Capability.trauma,
            ),
          );
          final admin = await createUser(
            sessionBuilder,
            phone: '+2348033330002',
            roles: [(UserRole.hospitalAdmin, f.id)],
          );
          await createUser(
            sessionBuilder,
            phone: '+2348033330003',
            roles: [(UserRole.deskStaff, f.id)],
          );
          await endpoints.status.update(admin.session, f.id!, _input);
          final platform = await createUser(
            sessionBuilder,
            phone: '+2348033330004',
            roles: [(UserRole.platformAdmin, null)],
          );
          await const OnboardingService().approve(
            session,
            facility: (await Facility.db.findById(session, f.id!))!,
            admin: platform.user,
          );
          final after = await Facility.db.findById(session, f.id!);
          expect(after!.onboardingStage, OnboardingStage.live);
          expect(after.liveAt, isNotNull);
        },
      );

      test('when an agent sets stage to live manually then refused', () async {
        final f = await createFacility(
          sessionBuilder,
          name: 'Seed Golive C',
          stage: OnboardingStage.verified,
        );
        final agent = await createUser(
          sessionBuilder,
          phone: '+2348033330005',
          roles: [(UserRole.fieldAgent, null)],
        );
        await assignAgent(sessionBuilder, f.id!, agent.user.id!);
        await expectLater(
          endpoints.onboarding.setStage(
            agent.session,
            f.id!,
            OnboardingStage.live,
          ),
          throwsA(isA<InvalidStateException>()),
        );
      });
    },
  );

  withServerpod(
    'Given self-serve signup',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      FacilityProfileInput input(String name, double lat, double lng) =>
          FacilityProfileInput(
            name: name,
            type: FacilityType.private,
            address: '1 Test Road',
            area: 'Ikeja',
            lat: lat,
            lng: lng,
            capabilities: [Capability.generalEmergency],
          );

      test(
        'when a near-identical listing exists nearby then creation fails',
        () async {
          await createFacility(
            sessionBuilder,
            name: 'Harmony Specialist Hospital',
            lat: 6.6000,
            lng: 3.3500,
          );
          final user = await createUser(
            sessionBuilder,
            phone: '+2348034440001',
          );
          await expectLater(
            endpoints.facility.create(
              user.session,
              input('Harmony Hospital', 6.6005, 3.3502),
            ),
            throwsA(isA<ConflictException>()),
          );
        },
      );

      test(
        'when no duplicate exists then the creator becomes hospital admin',
        () async {
          final user = await createUser(
            sessionBuilder,
            phone: '+2348034440002',
          );
          final f = await endpoints.facility.create(
            user.session,
            input('Brand New Unique Clinic', 6.4000, 3.9000),
          );
          expect(f.source, FacilitySource.selfSignup);
          final me = await endpoints.account.me(user.session);
          expect(
            me.roles.any(
              (r) => r.role == UserRole.hospitalAdmin && r.facilityId == f.id,
            ),
            isTrue,
          );
        },
      );
    },
  );
}
