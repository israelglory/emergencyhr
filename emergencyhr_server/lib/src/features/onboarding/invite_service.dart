import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/app_config.dart';
import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import '../auth/otp_codes.dart';
import '../auth/otp_service.dart';
import 'onboarding_service.dart';

/// Single-use facility invites. Only token hashes are stored. An invite is
/// redeemed with either the secret link token or the 8-character short code.
class InviteService {
  InviteService({this.onboarding = const OnboardingService()});

  final OnboardingService onboarding;

  static const ttl = Duration(hours: 72);
  static const _alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  static final _random = Random.secure();

  final _acceptLimiter = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'invite',
      source: 'accept',
      maxAttempts: 20,
      timeframe: const Duration(hours: 1),
    ),
  );

  static String newToken() => base64Url
      .encode(List<int>.generate(32, (_) => _random.nextInt(256)))
      .replaceAll('=', '');

  static String newShortCode() => List.generate(
    8,
    (_) => _alphabet[_random.nextInt(_alphabet.length)],
  ).join();

  static String hashToken(Session session, String token) =>
      OtpCodes.hash(token, 'invite', OtpService.pepper(session));

  Future<InviteCreated> create(
    Session session, {
    required Facility facility,
    required UserRole role,
    required AppUser createdBy,
    String? email,
  }) async {
    if (role != UserRole.hospitalAdmin && role != UserRole.deskStaff) {
      throw Errors.validation('Invites are for hospital admins or desk staff.');
    }
    final token = newToken();
    final now = clock.now();
    final invite = await FacilityInvite.db.insertRow(
      session,
      FacilityInvite(
        facilityId: facility.id!,
        role: role,
        email: email?.trim().toLowerCase(),
        tokenHash: hashToken(session, token),
        shortCode: newShortCode(),
        createdByUserId: createdBy.id!,
        expiresAt: now.add(ttl),
        createdAt: now,
      ),
    );
    await AuditLog.record(
      session,
      actorUserId: createdBy.id!,
      action: 'invite:create:${role.name}',
      targetType: 'facility',
      targetId: facility.id!,
    );
    // Shared by QR code, link or short code; nothing is sent by SMS.
    final link = '${AppConfig.instance.appBaseUrl}/invite/$token';
    return InviteCreated(invite: invite, link: link);
  }

  Future<List<FacilityInvite>> list(Session session, int facilityId) {
    return FacilityInvite.db.find(
      session,
      where: (t) => t.facilityId.equals(facilityId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 50,
    );
  }

  Future<FacilityInvite> revoke(
    Session session, {
    required FacilityInvite invite,
    required AppUser actor,
  }) async {
    if (invite.usedAt != null) {
      throw Errors.invalidState('This invite has already been used.');
    }
    await AuditLog.record(
      session,
      actorUserId: actor.id!,
      action: 'invite:revoke',
      targetType: 'facility',
      targetId: invite.facilityId,
    );
    return FacilityInvite.db.updateRow(
      session,
      invite.copyWith(revokedAt: clock.now()),
    );
  }

  Future<FacilityInvite?> find(Session session, String codeOrToken) {
    final value = codeOrToken.trim();
    final code = value.toUpperCase().replaceAll(RegExp(r'[\s-]'), '');
    if (code.length == 8) {
      return FacilityInvite.db.findFirstRow(
        session,
        where: (t) => t.shortCode.equals(code),
      );
    }
    return FacilityInvite.db.findFirstRow(
      session,
      where: (t) => t.tokenHash.equals(hashToken(session, value)),
    );
  }

  /// Null when usable, otherwise why not.
  static String? problem(FacilityInvite invite, DateTime now) {
    if (invite.revokedAt != null) return 'This invite was cancelled.';
    if (invite.usedAt != null) return 'This invite has already been used.';
    if (!invite.expiresAt.isAfter(now)) return 'This invite has expired.';
    return null;
  }

  Future<InvitePreview> preview(Session session, String codeOrToken) async {
    final invite = await find(session, codeOrToken);
    if (invite == null) throw Errors.notFound('Invite');
    final facility = await Facility.db.findById(session, invite.facilityId);
    final reason = problem(invite, clock.now());
    final inviter = await AppUser.db.findById(session, invite.createdByUserId);
    final inviterName = inviter?.name?.trim();
    return InvitePreview(
      facilityName: facility?.name ?? 'Unknown facility',
      role: invite.role,
      expiresAt: invite.expiresAt,
      valid: reason == null,
      reason: reason,
      invitedBy: inviterName == null || inviterName.isEmpty
          ? null
          : inviterName,
    );
  }

  Future<RoleAssignment> accept(
    Session session, {
    required String codeOrToken,
    required AppUser user,
  }) async {
    if (!await _acceptLimiter.tryRecordAttempt(
      session,
      key: '${user.id}',
    )) {
      throw Errors.rateLimited(retryAfterSeconds: 3600);
    }
    final invite = await find(session, codeOrToken);
    if (invite == null) throw Errors.notFound('Invite');
    final reason = problem(invite, clock.now());
    if (reason != null) throw Errors.invalidState(reason);
    if (invite.email != null && invite.email != user.email) {
      throw Errors.notAuthorized(
        'This invite is for a different email address. Sign in with '
        '${invite.email}.',
      );
    }

    final assignment = await session.db.transaction((tx) async {
      final now = clock.now();
      final existing = await RoleAssignment.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(user.id!) &
            t.role.equals(invite.role) &
            t.facilityId.equals(invite.facilityId),
        transaction: tx,
      );
      await FacilityInvite.db.updateRow(
        session,
        invite.copyWith(usedAt: now, usedByUserId: user.id),
        transaction: tx,
      );
      await AuditLog.record(
        session,
        actorUserId: user.id!,
        action: 'invite:accept:${invite.role.name}',
        targetType: 'facility',
        targetId: invite.facilityId,
        transaction: tx,
      );
      return existing ??
          await RoleAssignment.db.insertRow(
            session,
            RoleAssignment(
              userId: user.id!,
              role: invite.role,
              facilityId: invite.facilityId,
              createdAt: now,
              createdByUserId: invite.createdByUserId,
            ),
            transaction: tx,
          );
    });
    await onboarding.evaluate(session, invite.facilityId);
    return assignment;
  }
}
