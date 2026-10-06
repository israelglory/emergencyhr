import 'package:emergencyhr_server/src/features/auth/phone_idp.dart';
import 'package:emergencyhr_server/src/features/notifications/sms_gateway.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Initialises auth services the way lib/server.dart does. Call inside a
/// `withServerpod` group, which provides the passwords.
void setUpAuthServices() {
  setUpAll(
    () => AuthServices.set(
      tokenManagerBuilders: [JwtConfigFromPasswords()],
      identityProviderBuilders: [const PhoneIdpConfig()],
    ),
  );
}

/// Captures SMS messages instead of sending them.
class CapturingSmsGateway implements SmsGateway {
  final messages = <({String to, String message})>[];

  String lastCodeFor(String phone) {
    final message = messages.lastWhere((m) => m.to == phone).message;
    return RegExp(r'\d{6}').firstMatch(message)!.group(0)!;
  }

  @override
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  }) async {
    messages.add((to: to, message: message));
    return true;
  }
}

/// Creates a user with the given roles and returns a session builder signed
/// in as them.
Future<({AppUser user, TestSessionBuilder session})> createUser(
  TestSessionBuilder sessionBuilder, {
  required String phone,
  List<(UserRole, int?)> roles = const [(UserRole.public, null)],
}) async {
  final session = sessionBuilder.build();
  final authUser = await AuthServices.instance.authUsers.create(session);
  final user = await AppUser.db.insertRow(
    session,
    AppUser(authUserId: authUser.id, phone: phone),
  );
  for (final (role, facilityId) in roles) {
    await RoleAssignment.db.insertRow(
      session,
      RoleAssignment(userId: user.id!, role: role, facilityId: facilityId),
    );
  }
  return (
    user: user,
    session: sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        authUser.id.toString(),
        {},
      ),
    ),
  );
}

Future<Facility> createFacility(
  TestSessionBuilder sessionBuilder, {
  String name = 'Seed Hospital 01, Ikeja',
  String area = 'Ikeja',
  double lat = 6.6018,
  double lng = 3.3515,
  OnboardingStage stage = OnboardingStage.live,
  VerificationStatus verification = VerificationStatus.verified,
}) {
  return Facility.db.insertRow(
    sessionBuilder.build(),
    Facility(
      name: name,
      type: FacilityType.private,
      address: '1 Test Road, $area',
      area: area,
      lat: lat,
      lng: lng,
      verificationStatus: verification,
      onboardingStage: stage,
      source: FacilitySource.seeded,
    ),
  );
}

Future<void> assignAgent(
  TestSessionBuilder sessionBuilder,
  int facilityId,
  int agentUserId,
) async {
  await OnboardingRecord.db.insertRow(
    sessionBuilder.build(),
    OnboardingRecord(
      facilityId: facilityId,
      stage: OnboardingStage.visited,
      assignedAgentUserId: agentUserId,
    ),
  );
}
