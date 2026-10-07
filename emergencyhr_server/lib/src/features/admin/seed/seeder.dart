import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../../../core/clock.dart';
import '../../../generated/protocol.dart';
import 'seed_data.dart';

/// Loads the fictional Lagos pilot data into an empty development database.
abstract final class Seeder {
  static Future<void> run(Session session) async {
    final existing = await Facility.db.count(session);
    if (existing > 0) {
      await ensureDemoLogins(session);
      await refreshStatusAges(session);
      return;
    }
    session.log('Seeding development data', level: LogLevel.info);
    final now = clock.now();

    Future<AppUser> user(
      String phone,
      String name,
      List<UserRole> roles, {
      int? facilityId,
    }) async {
      final authUser = await AuthServices.instance.authUsers.create(session);
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        authUser.id,
        UserProfileData(fullName: name),
      );
      final u = await AppUser.db.insertRow(
        session,
        AppUser(
          authUserId: authUser.id,
          phone: phone,
          name: name,
          createdAt: now,
        ),
      );
      await RoleAssignment.db.insertRow(
        session,
        RoleAssignment(userId: u.id!, role: UserRole.public, createdAt: now),
      );
      for (final role in roles) {
        await RoleAssignment.db.insertRow(
          session,
          RoleAssignment(
            userId: u.id!,
            role: role,
            facilityId: facilityId,
            createdAt: now,
          ),
        );
      }
      return u;
    }

    final admin = await user(
      SeedData.platformAdminPhone,
      'Ada Platform',
      [UserRole.platformAdmin],
    );
    final agentA = await user(SeedData.agentAPhone, 'Tunde Agent', [
      UserRole.fieldAgent,
    ]);
    final agentB = await user(SeedData.agentBPhone, 'Ngozi Agent', [
      UserRole.fieldAgent,
    ]);
    for (final area in SeedData.agentAAreas) {
      await FieldAgentArea.db.insertRow(
        session,
        FieldAgentArea(userId: agentA.id!, area: area),
      );
    }
    for (final area in SeedData.agentBAreas) {
      await FieldAgentArea.db.insertRow(
        session,
        FieldAgentArea(userId: agentB.id!, area: area),
      );
    }

    final facilities = <int, Facility>{};
    for (var n = 1; n <= 30; n++) {
      final (lat, lng) = SeedData.coordinates(n);
      final stage = SeedData.stage(n);
      final live = stage == OnboardingStage.live;
      final liveAt = SeedData.quietNewcomer(n)
          ? now.subtract(const Duration(days: 5))
          : live
          ? now.subtract(Duration(days: 30 + n))
          : null;
      final f = await Facility.db.insertRow(
        session,
        Facility(
          name: SeedData.name(n),
          type: SeedData.type(n),
          address: '$n Seed Road, ${SeedData.areaFor(n)}, Lagos',
          area: SeedData.areaFor(n),
          lat: lat,
          lng: lng,
          deskPhone: SeedData.deskPhone(n),
          deskPhoneConfirmedAt: n <= 18 ? now : null,
          contactName: 'Desk Lead $n',
          verificationStatus: SeedData.verification(n),
          onboardingStage: stage,
          source: n <= 24 ? FacilitySource.fieldAgent : FacilitySource.seeded,
          liveAt: liveAt,
          openingHours: SeedData.openingHours(n),
          trainingCompletedAt: n <= 21 ? now : null,
          flaggedAt: SeedData.flagged(n) ? now : null,
          createdAt: now.subtract(const Duration(days: 60)),
          updatedAt: now,
        ),
      );
      facilities[n] = f;
      await FacilityCapability.db.insert(session, [
        for (final c in SeedData.capabilities(n))
          FacilityCapability(facilityId: f.id!, capability: c),
      ]);
      final agent = SeedData.agentAAreas.contains(f.area) ? agentA : agentB;
      await OnboardingRecord.db.insertRow(
        session,
        OnboardingRecord(
          facilityId: f.id!,
          stage: stage,
          assignedAgentUserId: agent.id,
          submittedAt: n == 19 || n == 20 ? now : null,
          submittedByUserId: n == 19 || n == 20 ? agent.id : null,
          nextActionAt: n > 18 ? now.add(Duration(days: n % 5 + 1)) : null,
          updatedAt: now,
        ),
      );
      await OnboardingEvent.db.insertRow(
        session,
        OnboardingEvent(
          facilityId: f.id!,
          toStage: stage,
          note: 'Seeded',
          at: now,
        ),
      );
      final age = SeedData.statusAgeMinutes(n);
      if (age != null) {
        final updatedAt = now.subtract(Duration(minutes: age));
        await FacilityStatus.db.insertRow(
          session,
          FacilityStatus(
            facilityId: f.id!,
            accepting: SeedData.accepting(n),
            erBedsFree: (n * 3) % 7,
            icuBedsFree: n % 3,
            doctorOnDuty: n != 9,
            depositRequired: n % 2 == 0,
            updatedAt: updatedAt,
          ),
        );
        await StatusChangeLog.db.insertRow(
          session,
          StatusChangeLog(
            facilityId: f.id!,
            newValue: '{"accepting":${SeedData.accepting(n)}}',
            at: updatedAt,
          ),
        );
      }
    }

    // Hospital staff for the first three live facilities.
    await user(SeedData.hospitalAdmin01Phone, 'Bola Admin', [
      UserRole.hospitalAdmin,
    ], facilityId: facilities[1]!.id);
    await user(SeedData.hospitalAdmin02Phone, 'Chidi Admin', [
      UserRole.hospitalAdmin,
    ], facilityId: facilities[2]!.id);
    await user(SeedData.desk01Phone, 'Kemi Desk', [
      UserRole.deskStaff,
    ], facilityId: facilities[1]!.id);
    await user(SeedData.desk02Phone, 'Emeka Desk', [
      UserRole.deskStaff,
    ], facilityId: facilities[2]!.id);
    await user(SeedData.desk03Phone, 'Fatima Desk', [
      UserRole.deskStaff,
    ], facilityId: facilities[3]!.id);

    // A public user with one pending claim and three recent wrong-status
    // reports on the flagged facility.
    final publicUser = await user(SeedData.publicUserPhone, 'Segun Public', []);
    await ClaimRequest.db.insertRow(
      session,
      ClaimRequest(
        facilityId: facilities[27]!.id!,
        userId: publicUser.id!,
        contactName: 'Segun Public',
        documents: [],
        status: ClaimStatus.pending,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
    );
    final flagged = facilities[13]!;
    for (var i = 0; i < 3; i++) {
      final s = await EmergencySession.db.insertRow(
        session,
        EmergencySession(
          lat: flagged.lat,
          lng: flagged.lng,
          emergencyType: EmergencyType.other,
          resultsShown: [flagged.id!],
          action: EmergencyAction.call,
          facilityId: flagged.id,
          startedAt: now.subtract(Duration(hours: 5 - i)),
          actedAt: now.subtract(Duration(hours: 5 - i, minutes: -2)),
        ),
      );
      await StatusReport.db.insertRow(
        session,
        StatusReport(
          sessionId: s.id!,
          facilityId: flagged.id!,
          reason: 'They said they had no beds',
          createdAt: now.subtract(Duration(hours: 4 - i)),
        ),
      );
    }

    await JoinRequest.db.insert(session, [
      JoinRequest(
        hospitalName: 'Seed Clinic Interest, Ojota',
        contactName: 'Mrs Join One',
        phone: '+2348020000001',
        area: 'Ikeja',
        message: 'We have a 24 hour emergency unit and want to join.',
        status: JoinRequestStatus.received,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now,
      ),
      JoinRequest(
        hospitalName: 'Seed Specialist Interest, Ajah',
        contactName: 'Dr Join Two',
        phone: '+2348020000002',
        area: 'Lekki',
        status: JoinRequestStatus.contacted,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now,
      ),
    ]);

    session.log(
      'Seeded 30 facilities. Platform admin: ${SeedData.platformAdminPhone} '
      '(admin user id ${admin.id})',
      level: LogLevel.info,
    );
  }

  /// Development only: gives demo accounts created before email sign-in an
  /// email and the demo password. Safe to run on every start.
  static Future<void> ensureDemoLogins(Session session) async {
    final emailIdp = AuthServices.instance.emailIdp;
    for (final MapEntry(key: phone, value: email)
        in SeedData.accounts.entries) {
      final user = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.phone.equals(phone),
      );
      if (user == null) continue;
      if (user.email == null) {
        await AppUser.db.updateRow(session, user.copyWith(email: email));
      }
      if (await emailIdp.admin.findAccount(session, email: email) == null) {
        await emailIdp.admin.createEmailAuthentication(
          session,
          authUserId: user.authUserId,
          email: email,
          password: SeedData.demoPassword,
        );
      }
    }
  }

  /// Development only: re-stamps the seed statuses so every freshness tier
  /// is present each time the server starts.
  static Future<void> refreshStatusAges(Session session) async {
    final now = clock.now();
    for (var n = 1; n <= 14; n++) {
      final age = SeedData.statusAgeMinutes(n);
      final facility = await Facility.db.findFirstRow(
        session,
        where: (t) => t.name.equals(SeedData.name(n)),
      );
      if (age == null || facility == null) continue;
      final status = await FacilityStatus.db.findFirstRow(
        session,
        where: (t) => t.facilityId.equals(facility.id!),
      );
      if (status == null || status.updatedByUserId != null) continue;
      await FacilityStatus.db.updateRow(
        session,
        status.copyWith(updatedAt: now.subtract(Duration(minutes: age))),
      );
    }
  }
}
