import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import 'account_service.dart';

/// The signed-in user's own account. Who may call: any signed-in user.
class AccountEndpoint extends Endpoint {
  static const _accounts = AccountService();

  Future<CurrentUser> me(Session session) async {
    final user = await AuthGuard.requireUser(session);
    return _accounts.currentUser(session, user);
  }

  /// Adds, changes or (with null) removes the optional phone number.
  Future<CurrentUser> updatePhone(Session session, String? phone) async {
    final user = await AuthGuard.requireUser(session);
    final updated = await _accounts.updatePhone(
      session,
      user,
      Validate.optionalPhone(phone),
    );
    return _accounts.currentUser(session, updated);
  }

  Future<CurrentUser> updateName(Session session, String name) async {
    final user = await AuthGuard.requireUser(session);
    final updated = await _accounts.updateName(
      session,
      user,
      Validate.text(name, field: 'name', max: 80),
    );
    return _accounts.currentUser(session, updated);
  }
}
