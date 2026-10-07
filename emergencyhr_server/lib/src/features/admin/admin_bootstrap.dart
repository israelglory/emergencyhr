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
  /// Every listed email that already has an account. Logs what it found
  /// at warning level so it shows in hosted logs.
  static Future<void> run(Session session) async {
    for (final email in AppConfig.instance.adminEmails) {
      final user = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email),
      );
      if (user == null) {
        session.log(
          'Admin setup: no account uses ${_mask(email)} yet. It becomes '
          'admin when it signs up.',
          level: LogLevel.warning,
        );
        continue;
      }
      await grantIfListed(session, user);
    }
  }

  /// "ig****@gmail.com", so logs do not carry full addresses.
  static String _mask(String email) {
    final at = email.indexOf('@');
    if (at < 2) return '***${at < 0 ? '' : email.substring(at)}';
    return '${email.substring(0, 2)}****${email.substring(at)}';
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
    if (existing > 0) {
      session.log(
        'Admin setup: account ${user.id} (${_mask(email)}) is already admin.',
        level: LogLevel.warning,
      );
      return;
    }
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
      'Admin setup: platform admin role given to account ${user.id} '
      '(${_mask(email)}).',
      level: LogLevel.warning,
    );
  }
}
