import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given hospitals from an open dataset',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      FacilityImportRow row(
        String ref,
        String name, {
        double lat = 8.1335,
        double lng = 4.2410,
      }) => FacilityImportRow(
        sourceRef: ref,
        name: name,
        type: FacilityType.private,
        address: 'Ogbomoso North LGA, Oyo State',
        area: 'Ogbomoso',
        lat: lat,
        lng: lng,
      );

      test('when an admin previews then imports, then hospitals are added '
          'unverified once, and importing again adds nothing', () async {
        final admin = await createUser(
          sessionBuilder,
          phone: '+2348037770001',
          roles: [(UserRole.platformAdmin, null)],
        );
        final rows = [
          row('test:import-1', 'Seed Import Alpha Hospital', lat: 8.20),
          row('test:import-2', 'Seed Import Beta Clinic', lat: 8.21),
        ];

        final preview = await endpoints.admin.importFacilities(
          admin.session,
          rows,
          dryRun: true,
        );
        expect(preview.created, 2);
        expect(
          await Facility.db.count(
            sessionBuilder.build(),
            where: (t) => t.sourceRef.like('test:import-%'),
          ),
          0,
        );

        final done = await endpoints.admin.importFacilities(
          admin.session,
          rows,
          dryRun: false,
        );
        expect(done.created, 2);
        final saved = await Facility.db.find(
          sessionBuilder.build(),
          where: (t) => t.sourceRef.like('test:import-%'),
        );
        expect(saved, hasLength(2));
        expect(saved.every((f) => f.source == FacilitySource.imported), isTrue);
        expect(
          saved.every((f) => f.verificationStatus == VerificationStatus.seeded),
          isTrue,
        );

        final again = await endpoints.admin.importFacilities(
          admin.session,
          rows,
          dryRun: false,
        );
        expect(again.created, 0);
        expect(again.alreadyImported, 2);
      });

      test('when a row is close to a listing with a similar name, or is '
          'outside Nigeria, then it is skipped with a reason', () async {
        final admin = await createUser(
          sessionBuilder,
          phone: '+2348037770002',
          roles: [(UserRole.platformAdmin, null)],
        );
        await createFacility(
          sessionBuilder,
          name: 'Seed Harbour Point Hospital',
          lat: 8.30,
          lng: 4.30,
        );
        final summary = await endpoints.admin.importFacilities(
          admin.session,
          [
            row(
              'test:dup-1',
              'Seed Harbour Point Hospital',
              lat: 8.3001,
              lng: 4.3001,
            ),
            row('test:bad-1', 'Seed Abroad Hospital', lat: 51.5, lng: -0.1),
          ],
          dryRun: true,
        );
        expect(summary.created, 0);
        expect(summary.possibleDuplicates, hasLength(1));
        expect(summary.invalid.single, contains('outside Nigeria'));
      });

      test(
        'when a non-admin imports or verifies, then it is refused',
        () async {
          final agent = await createUser(
            sessionBuilder,
            phone: '+2348037770003',
            roles: [(UserRole.fieldAgent, null)],
          );
          await expectLater(
            endpoints.admin.importFacilities(
              agent.session,
              [row('test:x', 'Seed X')],
              dryRun: true,
            ),
            throwsA(isA<NotAuthorizedException>()),
          );
          await expectLater(
            endpoints.admin.verifyListing(agent.session, 1),
            throwsA(isA<NotAuthorizedException>()),
          );
        },
      );

      test('when an admin verifies an imported hospital, then it is verified '
          'and cannot be verified twice', () async {
        final admin = await createUser(
          sessionBuilder,
          phone: '+2348037770004',
          roles: [(UserRole.platformAdmin, null)],
        );
        final f = await createFacility(
          sessionBuilder,
          name: 'Seed Verify Me Hospital',
          lat: 8.40,
          lng: 4.40,
          stage: OnboardingStage.seeded,
          verification: VerificationStatus.seeded,
        );
        final verified = await endpoints.admin.verifyListing(
          admin.session,
          f.id!,
        );
        expect(verified.verificationStatus, VerificationStatus.verified);
        expect(verified.onboardingStage, OnboardingStage.verified);
        await expectLater(
          endpoints.admin.verifyListing(admin.session, f.id!),
          throwsA(isA<InvalidStateException>()),
        );
      });
    },
  );
}
