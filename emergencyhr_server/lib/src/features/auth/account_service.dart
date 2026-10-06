import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// Account lookups and the signed-in user's role context.
class AccountService {
  const AccountService();

  Future<AppUser?> findByPhone(
    Session session,
    String phone, {
    Transaction? transaction,
  }) {
    return AppUser.db.findFirstRow(
      session,
      where: (t) => t.phone.equals(phone),
      transaction: transaction,
    );
  }

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
}
