import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

Future<void> _status(
  TestSessionBuilder sb,
  int facilityId, {
  int ageMinutes = 5,
  bool accepting = true,
}) async {
  await FacilityStatus.db.insertRow(
    sb.build(),
    FacilityStatus(
      facilityId: facilityId,
      accepting: accepting,
      erBedsFree: 2,
      icuBedsFree: 1,
      doctorOnDuty: true,
      depositRequired: false,
      updatedAt: DateTime.now().toUtc().subtract(Duration(minutes: ageMinutes)),
    ),
  );
}

Future<void> _caps(TestSessionBuilder sb, int id, List<Capability> caps) =>
    FacilityCapability.db.insert(sb.build(), [
      for (final c in caps) FacilityCapability(facilityId: id, capability: c),
    ]);

void main() {
  withServerpod(
    'Given the emergency flow',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test(
        'when a guest picks road accident then a tier 1 trauma hospital is '
        'first and actions are recorded',
        () async {
          final near = await createFacility(
            sessionBuilder,
            name: 'Seed General Near',
            lat: 6.6000,
            lng: 3.3500,
          );
          final trauma = await createFacility(
            sessionBuilder,
            name: 'Seed Trauma Far',
            lat: 6.6200,
            lng: 3.3600,
          );
          await _caps(sessionBuilder, near.id!, [Capability.generalEmergency]);
          await _caps(sessionBuilder, trauma.id!, [Capability.trauma]);
          await _status(sessionBuilder, near.id!);
          await _status(sessionBuilder, trauma.id!);

          final search = await endpoints.emergency.start(
            sessionBuilder,
            6.5990,
            3.3490,
            EmergencyType.roadAccident,
            area: null,
            tappedAt: null,
          );
          expect(search.results.first.facilityId, trauma.id);
          expect(search.results.first.rankTier, 1);
          expect(search.showCall112, isFalse);

          await endpoints.emergency.recordAction(
            sessionBuilder,
            search.sessionId,
            search.accessToken,
            EmergencyAction.call,
            facilityId: trauma.id,
          );
          final row = await EmergencySession.db.findById(
            sessionBuilder.build(),
            search.sessionId,
          );
          expect(row!.action, EmergencyAction.call);
          expect(row.actedAt, isNotNull);
        },
      );

      test('when the type is changed after start then the same session is '
          're-ranked and earlier hospitals stay actionable', () async {
        final near = await createFacility(
          sessionBuilder,
          name: 'Seed Filter Near',
          lat: 11.0000,
          lng: 8.0000,
        );
        final trauma = await createFacility(
          sessionBuilder,
          name: 'Seed Filter Trauma',
          lat: 11.0200,
          lng: 8.0100,
        );
        await _caps(sessionBuilder, near.id!, [Capability.generalEmergency]);
        await _caps(sessionBuilder, trauma.id!, [Capability.trauma]);
        await _status(sessionBuilder, near.id!);
        await _status(sessionBuilder, trauma.id!);

        final all = await endpoints.emergency.start(
          sessionBuilder,
          10.9990,
          7.9990,
          EmergencyType.skipped,
          area: null,
          tappedAt: null,
        );
        expect(all.results.first.facilityId, near.id);

        final filtered = await endpoints.emergency.updateSearch(
          sessionBuilder,
          all.sessionId,
          all.accessToken,
          EmergencyType.roadAccident,
          lat: null,
          lng: null,
          area: null,
        );
        expect(filtered.sessionId, all.sessionId);
        expect(filtered.emergencyType, EmergencyType.roadAccident);
        expect(filtered.results.first.facilityId, trauma.id);

        final row = await EmergencySession.db.findById(
          sessionBuilder.build(),
          all.sessionId,
        );
        expect(row!.emergencyType, EmergencyType.roadAccident);
        expect(row.resultsShown, containsAll([near.id, trauma.id]));

        await expectLater(
          endpoints.emergency.updateSearch(
            sessionBuilder,
            all.sessionId,
            all.accessToken,
            EmergencyType.skipped,
            lat: 9.0,
            lng: null,
            area: null,
          ),
          throwsA(isA<ValidationException>()),
        );
      });

      test('when the access token is wrong then actions are refused', () async {
        final search = await endpoints.emergency.start(
          sessionBuilder,
          7.5,
          4.5,
          EmergencyType.skipped,
          area: null,
          tappedAt: null,
        );
        await expectLater(
          endpoints.emergency.recordAction(
            sessionBuilder,
            search.sessionId,
            'wrong',
            EmergencyAction.call112,
          ),
          throwsA(isA<NotAuthorizedException>()),
        );
      });

      test(
        'when nothing is accepting within 25 km then call 112 is shown',
        () async {
          final f = await createFacility(
            sessionBuilder,
            name: 'Seed Lonely Paused',
            lat: 8.0,
            lng: 5.0,
          );
          await _caps(sessionBuilder, f.id!, [Capability.generalEmergency]);
          await _status(sessionBuilder, f.id!, accepting: false);
          final search = await endpoints.emergency.start(
            sessionBuilder,
            8.001,
            5.001,
            EmergencyType.skipped,
            area: null,
            tappedAt: null,
          );
          expect(search.showCall112, isTrue);
          expect(search.radiusKm, 25);
        },
      );

      test(
        'when three users report a hospital then it is flagged and hidden',
        () async {
          final f = await createFacility(
            sessionBuilder,
            name: 'Seed Reported',
            lat: 9.0,
            lng: 6.0,
          );
          await _caps(sessionBuilder, f.id!, [Capability.generalEmergency]);
          await _status(sessionBuilder, f.id!);
          for (var i = 0; i < 3; i++) {
            final user = await createUser(
              sessionBuilder,
              phone: '+234803555000$i',
            );
            final search = await endpoints.emergency.start(
              user.session,
              9.0,
              6.0,
              EmergencyType.skipped,
              area: null,
              tappedAt: null,
            );
            await endpoints.emergency.recordAction(
              user.session,
              search.sessionId,
              search.accessToken,
              EmergencyAction.call,
              facilityId: f.id,
            );
            await endpoints.emergency.reportWrongStatus(
              user.session,
              search.sessionId,
              search.accessToken,
              f.id!,
              'They had no beds',
            );
          }
          final after = await endpoints.emergency.start(
            sessionBuilder,
            9.0,
            6.0,
            EmergencyType.skipped,
            area: null,
            tappedAt: null,
          );
          final result = after.results.single;
          expect(result.flagged, isTrue);
          expect(result.rankTier, 0);
        },
      );

      test('when a guest reports then sign-in is required', () async {
        final search = await endpoints.emergency.start(
          sessionBuilder,
          7.6,
          4.6,
          EmergencyType.skipped,
          area: null,
          tappedAt: null,
        );
        await expectLater(
          endpoints.emergency.reportWrongStatus(
            sessionBuilder,
            search.sessionId,
            search.accessToken,
            1,
            'x',
          ),
          throwsA(isA<NotAuthorizedException>()),
        );
      });
    },
  );
}
