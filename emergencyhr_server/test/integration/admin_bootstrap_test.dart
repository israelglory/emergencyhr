import 'package:emergencyhr_server/src/core/app_config.dart';
import 'package:emergencyhr_server/src/features/admin/admin_bootstrap.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  tearDown(() => AppConfig.instance = AppConfig());

  withServerpod(
    'Given admin emails in the settings',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      Future<List<UserRole>> rolesOf(AppUser user) async => [
        for (final r in await RoleAssignment.db.find(
          sessionBuilder.build(),
          where: (t) => t.userId.equals(user.id!),
        ))
          r.role,
      ];

      test('when the server starts, then a listed account becomes platform '
          'admin once, and others do not', () async {
        final listed = await createUser(
          sessionBuilder,
          phone: '+2348039990001',
        );
        final other = await createUser(sessionBuilder, phone: '+2348039990002');
        AppConfig.instance = AppConfig(
          adminEmails: [emailFor('+2348039990001')],
        );

        await AdminBootstrap.run(sessionBuilder.build());
        await AdminBootstrap.run(sessionBuilder.build());

        final roles = await rolesOf(listed.user);
        expect(
          roles.where((r) => r == UserRole.platformAdmin),
          hasLength(1),
        );
        expect(
          await rolesOf(other.user),
          isNot(contains(UserRole.platformAdmin)),
        );
      });

      test('when a listed person signs up after the server started, then '
          'they become platform admin straight away', () async {
        AppConfig.instance = AppConfig(
          adminEmails: [emailFor('+2348039990003')],
        );
        final created = await createUser(
          sessionBuilder,
          phone: '+2348039990003',
        );
        await AdminBootstrap.grantIfListed(
          sessionBuilder.build(),
          created.user,
        );
        expect(await rolesOf(created.user), contains(UserRole.platformAdmin));
      });

      test('when the list is empty, then nobody is made admin', () async {
        final user = await createUser(sessionBuilder, phone: '+2348039990004');
        await AdminBootstrap.run(sessionBuilder.build());
        expect(
          await rolesOf(user.user),
          isNot(contains(UserRole.platformAdmin)),
        );
      });
    },
  );
}
