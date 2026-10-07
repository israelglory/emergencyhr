import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';

/// Account lookups and the signed-in user's role context.
class AccountService {
  const AccountService();

  /// Called by the email sign-in provider when a new email account is
  /// created: creates the matching [AppUser] with the public role.
  static Future<void> onEmailAccountCreated(
    Session session, {
    required String email,
    required UuidValue authUserId,
    required UuidValue emailAccountId,
    required Transaction? transaction,
  }) async {
    await const AccountService().ensureFor(
      session,
      authUserId: authUserId,
      email: email,
      transaction: transaction,
    );
  }

  /// Finds the account for an auth user, creating it if missing.
  Future<AppUser> ensureFor(
    Session session, {
    required UuidValue authUserId,
    String? email,
    Transaction? transaction,
  }) async {
    final existing = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      transaction: transaction,
    );
    if (existing != null) return existing;
    final now = clock.now();
    final user = await AppUser.db.insertRow(
      session,
      AppUser(
        authUserId: authUserId,
        email: email?.trim().toLowerCase(),
        createdAt: now,
      ),
      transaction: transaction,
    );
    await RoleAssignment.db.insertRow(
      session,
      RoleAssignment(userId: user.id!, role: UserRole.public, createdAt: now),
      transaction: transaction,
    );
    return user;
  }

  Future<AppUser?> findByEmail(
    Session session,
    String email, {
    Transaction? transaction,
  }) {
    final normalised = email.trim().toLowerCase();
    return AppUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals(normalised),
      transaction: transaction,
    );
  }

  /// Name, else email, else phone. Used wherever a person is shown.
  static String displayName(AppUser u) =>
      u.name ?? u.email ?? u.phone ?? 'Account ${u.id}';

  Future<CurrentUser> currentUser(Session session, AppUser user) async {
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      orderBy: (t) => t.id,
    );
    final facilityIds = {
      for (final role in roles)
        if (role.facilityId != null) role.facilityId!,
    };
    final facilities = facilityIds.isEmpty
        ? <Facility>[]
        : await Facility.db.find(
            session,
            where: (t) => t.id.inSet(facilityIds),
            orderBy: (t) => t.name,
          );
    return CurrentUser(
      user: user,
      roles: roles,
      facilities: [
        for (final f in facilities)
          FacilitySummary(
            id: f.id!,
            name: f.name,
            area: f.area,
            onboardingStage: f.onboardingStage,
            verificationStatus: f.verificationStatus,
          ),
      ],
    );
  }

  Future<AppUser> updateName(Session session, AppUser user, String name) {
    return AppUser.db.updateRow(session, user.copyWith(name: name));
  }

  /// Sets or clears the optional phone number. Each number belongs to one
  /// account.
  Future<AppUser> updatePhone(
    Session session,
    AppUser user,
    String? phone,
  ) async {
    if (phone != null && phone != user.phone) {
      final taken = await AppUser.db.count(
        session,
        where: (t) => t.phone.equals(phone) & t.id.notEquals(user.id),
      );
      if (taken > 0) {
        throw Errors.conflict('This phone number is used by another account.');
      }
    }
    return AppUser.db.updateRow(session, user.copyWith(phone: phone));
  }
}
