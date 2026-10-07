import 'package:serverpod/serverpod.dart';

import '../../core/app_config.dart';
import '../../core/clock.dart';
import '../../generated/protocol.dart';

/// Gives the accounts listed in `adminEmails` (config/app_settings.yaml) the
/// platform admin role, so a new server has its first admin.
///
/// Runs at start-up and when an account is created, so it does not matter
/// whether the person signs up before or after the email is listed. Sign-up
/// confirms the email with a code first, so only the owner of the inbox can
/// get the role. It only ever adds the role: removing an email from the list
/// does not remove it (suspend the account in Admin, Accounts instead).
abstract final class AdminBootstrap {
  /// Every listed email that already has an account.
  static Future<void> run(Session session) async {
    for (final email in AppConfig.instance.adminEmails) {
      final user = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email),
      );
      if (user != null) await grantIfListed(session, user);
    }
  }

  static Future<void> grantIfListed(
    Session session,
    AppUser user, {
    Transaction? transaction,
  }) async {
    final email = user.email?.trim().toLowerCase();
    if (email == null || !AppConfig.instance.adminEmails.contains(email)) {
      return;
    }
    final existing = await RoleAssignment.db.count(
      session,
      where: (t) =>
          t.userId.equals(user.id!) &
          t.role.equals(UserRole.platformAdmin) &
          t.facilityId.equals(null),
      transaction: transaction,
    );
    if (existing > 0) return;
    await RoleAssignment.db.insertRow(
      session,
      RoleAssignment(
        userId: user.id!,
        role: UserRole.platformAdmin,
        createdAt: clock.now(),
      ),
      transaction: transaction,
    );
    session.log(
      'Platform admin role given to account ${user.id} (adminEmails).',
    );
  }
}
