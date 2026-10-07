import 'dart:typed_data';

import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given documents sent through the server',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      ByteData bytes(int length) => ByteData(length)..setUint8(0, 1);

      test('when a facility manager uploads a photo, then it is stored and '
          'can be downloaded', () async {
        final f = await createFacility(
          sessionBuilder,
          name: 'Seed Doc Hospital',
        );
        final manager = await createUser(
          sessionBuilder,
          phone: '+2348036660001',
          roles: [(UserRole.hospitalAdmin, f.id)],
        );
        final doc = await endpoints.document.upload(
          manager.session,
          'Registration certificate.jpg',
          DocumentKind.registration,
          bytes(2048),
          facilityId: f.id,
        );
        expect(doc.facilityId, f.id);
        expect(doc.storagePath, startsWith('facilities/${f.id}/'));
        final back = await endpoints.document.download(
          manager.session,
          doc.id!,
        );
        expect(back.lengthInBytes, 2048);
      });

      test('when someone without access uploads to a facility, or the file '
          'is not a PDF or photo, then it is refused', () async {
        final f = await createFacility(sessionBuilder, name: 'Seed Doc Two');
        final stranger = await createUser(
          sessionBuilder,
          phone: '+2348036660002',
        );
        await expectLater(
          endpoints.document.upload(
            stranger.session,
            'a.pdf',
            DocumentKind.registration,
            bytes(10),
            facilityId: f.id,
          ),
          throwsA(isA<NotAuthorizedException>()),
        );
        await expectLater(
          endpoints.document.upload(
            stranger.session,
            'script.exe',
            DocumentKind.registration,
            bytes(10),
          ),
          throwsA(isA<ValidationException>()),
        );
      });
    },
  );
}
