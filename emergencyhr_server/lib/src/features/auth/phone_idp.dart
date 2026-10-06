import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import 'account_service.dart';
import 'otp_service.dart';

/// Phone number + SMS code sign-in, built on Serverpod's auth core: each
/// [AppUser] is backed by an auth user, and sessions are issued by the
/// configured token manager (JWT).
class PhoneIdp implements IdentityProvider {
  PhoneIdp({
    required this.tokenManager,
    required this.authUsers,
    required this.userProfiles,
    OtpService? otp,
    this.accounts = const AccountService(),
  }) : otp = otp ?? OtpService();

  static const signInMethod = 'phone';

  @override
  String get method => signInMethod;

  final TokenManager tokenManager;
  final AuthUsers authUsers;
  final UserProfiles userProfiles;
  final AccountService accounts;
  final OtpService otp;

  Future<OtpRequestResult> requestCode(Session session, String phone) {
    return otp.request(session, phone: phone, purpose: OtpPurpose.signIn);
  }

  /// Checks the code, creates the account on first sign-in, and issues a
  /// session token.
  Future<AuthSuccess> verifyCode(
    Session session,
    String phone,
    String code,
  ) async {
    // Outside the transaction so failed attempts are always counted.
    await otp.verify(
      session,
      phone: phone,
      purpose: OtpPurpose.signIn,
      code: code,
    );

    return session.db.transaction((transaction) async {
      var user = await accounts.findByPhone(
        session,
        phone,
        transaction: transaction,
      );
      if (user?.suspendedAt != null) {
        throw Errors.notAuthorized('This account is suspended.');
      }

      if (user == null) {
        final authUser = await authUsers.create(
          session,
          transaction: transaction,
        );
        await userProfiles.createUserProfile(
          session,
          authUser.id,
          UserProfileData(),
          transaction: transaction,
        );
        user = await AppUser.db.insertRow(
          session,
          AppUser(
            authUserId: authUser.id,
            phone: phone,
            createdAt: clock.now(),
          ),
          transaction: transaction,
        );
        await RoleAssignment.db.insertRow(
          session,
          RoleAssignment(
            userId: user.id!,
            role: UserRole.public,
            createdAt: clock.now(),
          ),
          transaction: transaction,
        );
      }

      final authUser = await authUsers.get(
        session,
        authUserId: user.authUserId,
        transaction: transaction,
      );
      return tokenManager.issueToken(
        session,
        authUserId: user.authUserId,
        method: method,
        scopes: authUser.scopes,
        transaction: transaction,
      );
    });
  }

  @override
  Future<void> mergeAuthUsers(
    Session session, {
    required UuidValue userToKeepId,
    required UuidValue userToRemoveId,
    required Transaction transaction,
  }) async {}
}

class PhoneIdpConfig extends IdentityProviderBuilder<PhoneIdp> {
  const PhoneIdpConfig();

  @override
  PhoneIdp build({
    required TokenManager tokenManager,
    required AuthUsers authUsers,
    required UserProfiles userProfiles,
  }) {
    return PhoneIdp(
      tokenManager: tokenManager,
      authUsers: authUsers,
      userProfiles: userProfiles,
    );
  }
}

extension PhoneIdpGetter on AuthServices {
  PhoneIdp get phoneIdp => AuthServices.getIdentityProvider<PhoneIdp>();
}
