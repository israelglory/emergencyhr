import 'package:serverpod/serverpod.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../auth/otp_service.dart';
import 'onboarding_service.dart';

/// Self-serve claims of an existing listing.
class ClaimService {
  ClaimService({OtpService? otp, this.onboarding = const OnboardingService()})
    : otp = otp ?? OtpService();

  final OtpService otp;
  final OnboardingService onboarding;

  /// Sends a code to the listed desk phone, proving the claimant is at the
  /// hospital.
  Future<OtpRequestResult> requestDeskPhoneCode(
    Session session,
    Facility facility,
  ) async {
    final phone = facility.deskPhone;
    if (phone == null) {
      throw Errors.invalidState('This listing has no desk phone on file.');
    }
    final result = await otp.request(
      session,
      phone: phone,
      purpose: OtpPurpose.deskPhone,
    );
    // Do not reveal the full desk number to the claimant.
    return result.copyWith(phone: '••• ${phone.substring(phone.length - 4)}');
  }

  Future<ClaimRequest> submit(
    Session session, {
    required Facility facility,
    required AppUser user,
    required String contactName,
    required List<String> documentPaths,
    String? deskPhoneCode,
  }) async {
    final name = Validate.text(contactName, field: 'contactName', max: 120);
    if (documentPaths.isEmpty) {
      throw Errors.validation(
        'Upload the registration document.',
        field: 'documents',
      );
    }
    final documents = await FacilityDocument.db.find(
      session,
      where: (t) =>
          t.storagePath.inSet(documentPaths.toSet()) &
          t.uploadedByUserId.equals(user.id!),
    );
    if (documents.length != documentPaths.toSet().length) {
      throw Errors.notAuthorized('Some documents could not be found.');
    }
    final pending = await ClaimRequest.db.count(
      session,
      where: (t) =>
          t.facilityId.equals(facility.id!) &
          t.userId.equals(user.id!) &
          t.status.equals(ClaimStatus.pending),
    );
    if (pending > 0) {
      throw Errors.conflict('You already have a claim waiting for review.');
    }
    var deskPhoneVerified = false;
    if (deskPhoneCode != null && deskPhoneCode.isNotEmpty) {
      Validate.otpCode(deskPhoneCode);
      await otp.verify(
        session,
        phone: facility.deskPhone ?? '',
        purpose: OtpPurpose.deskPhone,
        code: deskPhoneCode,
      );
      deskPhoneVerified = true;
    }
    return session.db.transaction((tx) async {
      final claim = await ClaimRequest.db.insertRow(
        session,
        ClaimRequest(
          facilityId: facility.id!,
          userId: user.id!,
          contactName: name,
          documents: documentPaths,
          deskPhoneVerified: deskPhoneVerified,
          status: ClaimStatus.pending,
          createdAt: clock.now(),
        ),
        transaction: tx,
      );
      for (final d in documents) {
        await FacilityDocument.db.updateRow(
          session,
          d.copyWith(claimRequestId: claim.id),
          transaction: tx,
        );
      }
      return claim;
    });
  }

  Future<List<ClaimRequest>> mine(Session session, AppUser user) {
    return ClaimRequest.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  Future<List<ClaimRequest>> list(
    Session session, {
    required ClaimStatus status,
    required int limit,
    required int offset,
  }) {
    final page = Validate.page(limit, offset);
    return ClaimRequest.db.find(
      session,
      where: (t) => t.status.equals(status),
      orderBy: (t) => t.createdAt,
      limit: page.limit,
      offset: page.offset,
    );
  }

  /// The admin queue, with each facility's name and the claimant's phone.
  Future<List<ClaimQueueItem>> queue(
    Session session, {
    required ClaimStatus status,
    required int limit,
    required int offset,
  }) async {
    final claims = await list(
      session,
      status: status,
      limit: limit,
      offset: offset,
    );
    if (claims.isEmpty) return [];
    final facilities = await Facility.db.find(
      session,
      where: (t) => t.id.inSet(<int>{for (final c in claims) c.facilityId}),
    );
    final users = await AppUser.db.find(
      session,
      where: (t) => t.id.inSet(<int>{for (final c in claims) c.userId}),
    );
    final facilityBy = {for (final f in facilities) f.id!: f};
    final phoneBy = {for (final u in users) u.id!: u.phone};
    return [
      for (final c in claims)
        if (facilityBy[c.facilityId] != null)
          ClaimQueueItem(
            claim: c,
            facility: OnboardingService.summary(facilityBy[c.facilityId]!),
            claimantPhone: phoneBy[c.userId] ?? '',
          ),
    ];
  }

  /// Transfers the listing to the claimant, keeping its history.
  Future<ClaimRequest> approve(
    Session session, {
    required ClaimRequest claim,
    required AppUser admin,
  }) async {
    if (claim.status != ClaimStatus.pending) {
      throw Errors.invalidState('This claim has already been reviewed.');
    }
    final facility = await Facility.db.findById(session, claim.facilityId);
    if (facility == null) throw Errors.notFound('Facility');
    final updated = await session.db.transaction((tx) async {
      final now = clock.now();
      final c = await ClaimRequest.db.updateRow(
        session,
        claim.copyWith(
          status: ClaimStatus.approved,
          reviewedByUserId: admin.id,
          reviewedAt: now,
        ),
        transaction: tx,
      );
      await RoleAssignment.db.insertRow(
        session,
        RoleAssignment(
          userId: claim.userId,
          role: UserRole.hospitalAdmin,
          facilityId: claim.facilityId,
          createdAt: now,
          createdByUserId: admin.id,
        ),
        transaction: tx,
      );
      final docs = await FacilityDocument.db.find(
        session,
        where: (t) => t.claimRequestId.equals(claim.id!),
        transaction: tx,
      );
      for (final d in docs) {
        await FacilityDocument.db.updateRow(
          session,
          d.copyWith(facilityId: claim.facilityId),
          transaction: tx,
        );
      }
      var f = await Facility.db.updateRow(
        session,
        facility.copyWith(
          source: FacilitySource.claim,
          deskPhoneConfirmedAt: claim.deskPhoneVerified
              ? now
              : facility.deskPhoneConfirmedAt,
          contactName: claim.contactName,
          updatedAt: now,
        ),
        transaction: tx,
      );
      if (f.onboardingStage == OnboardingStage.seeded) {
        f = await onboarding.moveStage(
          session,
          f,
          OnboardingStage.contacted,
          byUserId: admin.id,
          note: 'Claim approved',
          transaction: tx,
        );
      }
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'claim:approve',
        targetType: 'facility',
        targetId: claim.facilityId,
        transaction: tx,
      );
      return c;
    });
    await onboarding.evaluate(session, claim.facilityId);
    return updated;
  }

  Future<ClaimRequest> reject(
    Session session, {
    required ClaimRequest claim,
    required AppUser admin,
    required String reason,
  }) async {
    if (claim.status != ClaimStatus.pending) {
      throw Errors.invalidState('This claim has already been reviewed.');
    }
    return session.db.transaction((tx) async {
      await AuditLog.record(
        session,
        actorUserId: admin.id!,
        action: 'claim:reject',
        targetType: 'facility',
        targetId: claim.facilityId,
        reason: reason,
        transaction: tx,
      );
      return ClaimRequest.db.updateRow(
        session,
        claim.copyWith(
          status: ClaimStatus.rejected,
          reviewedByUserId: admin.id,
          reviewedAt: clock.now(),
          reason: reason,
        ),
        transaction: tx,
      );
    });
  }
}
