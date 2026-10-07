import 'package:serverpod/serverpod.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/geo.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../onboarding/onboarding_service.dart';
import 'logic/duplicate_rules.dart';
import 'logic/opening_hours_rules.dart';

/// Facility listings: search, duplicate detection, creation and profiles.
class FacilityService {
  const FacilityService({this.onboarding = const OnboardingService()});

  final OnboardingService onboarding;

  Future<Facility> require(Session session, int facilityId) async {
    final facility = await Facility.db.findById(session, facilityId);
    if (facility == null) throw Errors.notFound('Facility');
    return facility;
  }

  Future<List<FacilitySearchResult>> search(
    Session session, {
    required String query,
    String? area,
    int limit = 20,
  }) async {
    final q = query.trim();
    if (q.length < 2) return [];
    final pattern = '%${q.replaceAll('%', '').replaceAll('_', '')}%';
    final rows = await Facility.db.find(
      session,
      where: (t) {
        final byName = t.name.ilike(pattern) & t.suspendedAt.equals(null);
        return area == null ? byName : byName & t.area.equals(area);
      },
      orderBy: (t) => t.name,
      limit: limit,
    );
    return [
      for (final f in rows)
        FacilitySearchResult(
          facility: OnboardingService.summary(f),
          address: f.address,
        ),
    ];
  }

  /// Facilities within [radiusMeters], nearest first.
  Future<List<FacilitySearchResult>> nearby(
    Session session, {
    required double lat,
    required double lng,
    double radiusMeters = DuplicateRules.nearbyMeters,
  }) async {
    final rows = await _within(session, lat, lng, radiusMeters / 1000);
    final results = <FacilitySearchResult>[];
    for (final f in rows) {
      final meters = haversineKm(lat, lng, f.lat, f.lng) * 1000;
      if (meters > radiusMeters) continue;
      results.add(
        FacilitySearchResult(
          facility: OnboardingService.summary(f),
          address: f.address,
          distanceMeters: meters,
        ),
      );
    }
    results.sort((a, b) => a.distanceMeters!.compareTo(b.distanceMeters!));
    return results;
  }

  Future<List<DuplicateCandidate>> findDuplicates(
    Session session, {
    required String name,
    required double lat,
    required double lng,
    int? excludeId,
  }) async {
    final rows = await _within(
      session,
      lat,
      lng,
      DuplicateRules.sameNameMeters / 1000,
    );
    final candidates = <DuplicateCandidate>[];
    for (final f in rows) {
      if (f.id == excludeId) continue;
      final meters = haversineKm(lat, lng, f.lat, f.lng) * 1000;
      final similarity = DuplicateRules.similarity(name, f.name);
      if (!DuplicateRules.isCandidate(similarity, meters)) continue;
      candidates.add(
        DuplicateCandidate(
          facility: OnboardingService.summary(f),
          address: f.address,
          distanceMeters: meters,
          strong: DuplicateRules.isStrongMatch(similarity, meters),
        ),
      );
    }
    candidates.sort((a, b) {
      if (a.strong != b.strong) return a.strong ? -1 : 1;
      return a.distanceMeters.compareTo(b.distanceMeters);
    });
    return candidates;
  }

  FacilityProfileInput validate(FacilityProfileInput input) {
    Validate.coordinates(input.lat, input.lng);
    if (input.openingHours != null &&
        !OpeningHoursRules.isValid(input.openingHours!)) {
      throw Errors.validation(
        'Opening hours are not valid.',
        field: 'openingHours',
      );
    }
    return input.copyWith(
      name: Validate.text(input.name, field: 'name', min: 3, max: 120),
      address: Validate.text(input.address, field: 'address', max: 300),
      area: Validate.text(input.area, field: 'area', max: 80),
      deskPhone: Validate.optionalPhone(input.deskPhone, field: 'deskPhone'),
      contactName: Validate.optionalText(
        input.contactName,
        field: 'contactName',
        max: 120,
      ),
      contactPhone: Validate.optionalPhone(
        input.contactPhone,
        field: 'contactPhone',
      ),
      capabilities: input.capabilities.toSet().toList(),
    );
  }

  /// Creates a listing after the server-side duplicate check. Self-serve
  /// creators become the hospital admin; agents are assigned to it.
  Future<Facility> create(
    Session session, {
    required FacilityProfileInput input,
    required AppUser actor,
    required FacilitySource source,
  }) async {
    final data = validate(input);
    final duplicates = await findDuplicates(
      session,
      name: data.name,
      lat: data.lat,
      lng: data.lng,
    );
    if (duplicates.any((d) => d.strong)) {
      throw Errors.conflict(
        'This hospital may already be listed as '
        '"${duplicates.firstWhere((d) => d.strong).facility.name}". '
        'Choose the existing listing instead.',
      );
    }

    final stage = switch (source) {
      FacilitySource.fieldAgent => OnboardingStage.visited,
      FacilitySource.selfSignup => OnboardingStage.contacted,
      FacilitySource.claim => OnboardingStage.contacted,
      FacilitySource.seeded ||
      FacilitySource.imported => OnboardingStage.seeded,
    };

    final facility = await session.db.transaction((tx) async {
      final now = clock.now();
      final f = await Facility.db.insertRow(
        session,
        Facility(
          name: data.name,
          type: data.type,
          address: data.address,
          area: data.area,
          lat: data.lat,
          lng: data.lng,
          deskPhone: data.deskPhone,
          contactName: data.contactName,
          contactPhone: data.contactPhone,
          openingHours: data.openingHours,
          verificationStatus: VerificationStatus.seeded,
          onboardingStage: stage,
          source: source,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: tx,
      );
      await _replaceCapabilities(session, f.id!, data.capabilities, tx);
      await OnboardingRecord.db.insertRow(
        session,
        OnboardingRecord(
          facilityId: f.id!,
          stage: stage,
          assignedAgentUserId: source == FacilitySource.fieldAgent
              ? actor.id
              : null,
          updatedAt: now,
        ),
        transaction: tx,
      );
      await OnboardingEvent.db.insertRow(
        session,
        OnboardingEvent(
          facilityId: f.id!,
          toStage: stage,
          byUserId: actor.id,
          note: 'Created (${source.name})',
          at: now,
        ),
        transaction: tx,
      );
      if (source == FacilitySource.selfSignup) {
        await RoleAssignment.db.insertRow(
          session,
          RoleAssignment(
            userId: actor.id!,
            role: UserRole.hospitalAdmin,
            facilityId: f.id,
            createdAt: now,
            createdByUserId: actor.id,
          ),
          transaction: tx,
        );
      }
      await AuditLog.record(
        session,
        actorUserId: actor.id!,
        action: 'facility:create',
        targetType: 'facility',
        targetId: f.id!,
        transaction: tx,
      );
      return f;
    });
    return facility;
  }

  Future<Facility> updateProfile(
    Session session, {
    required Facility facility,
    required FacilityProfileInput input,
    required AppUser actor,
  }) async {
    final data = validate(input);
    final updated = await session.db.transaction((tx) async {
      final f = await Facility.db.updateRow(
        session,
        facility.copyWith(
          name: data.name,
          type: data.type,
          address: data.address,
          area: data.area,
          lat: data.lat,
          lng: data.lng,
          deskPhone: data.deskPhone,
          deskPhoneConfirmedAt: data.deskPhone == facility.deskPhone
              ? facility.deskPhoneConfirmedAt
              : null,
          contactName: data.contactName,
          contactPhone: data.contactPhone,
          openingHours: data.openingHours,
          updatedAt: clock.now(),
        ),
        transaction: tx,
      );
      await _replaceCapabilities(session, f.id!, data.capabilities, tx);
      await AuditLog.record(
        session,
        actorUserId: actor.id!,
        action: 'facility:update',
        targetType: 'facility',
        targetId: f.id!,
        transaction: tx,
      );
      return f;
    });
    await onboarding.evaluate(session, updated.id!);
    return updated;
  }

  Future<List<Capability>> capabilities(Session session, int facilityId) async {
    final rows = await FacilityCapability.db.find(
      session,
      where: (t) => t.facilityId.equals(facilityId),
    );
    return [for (final r in rows) r.capability];
  }

  Future<FacilityDetail> detail(Session session, Facility facility) async {
    final id = facility.id!;
    return FacilityDetail(
      facility: facility,
      capabilities: await capabilities(session, id),
      status: await FacilityStatus.db.findFirstRow(
        session,
        where: (t) => t.facilityId.equals(id),
      ),
      record: await OnboardingRecord.db.findFirstRow(
        session,
        where: (t) => t.facilityId.equals(id),
      ),
      checklist: await onboarding.checklist(session, facility),
      documents: await FacilityDocument.db.find(
        session,
        where: (t) => t.facilityId.equals(id),
        orderBy: (t) => t.createdAt,
      ),
    );
  }

  Future<List<Facility>> _within(
    Session session,
    double lat,
    double lng,
    double radiusKm,
  ) {
    final box = boundingBox(lat, lng, radiusKm);
    return Facility.db.find(
      session,
      where: (t) =>
          t.lat.between(box.minLat, box.maxLat) &
          t.lng.between(box.minLng, box.maxLng),
    );
  }

  Future<void> _replaceCapabilities(
    Session session,
    int facilityId,
    List<Capability> capabilities,
    Transaction tx,
  ) async {
    await FacilityCapability.db.deleteWhere(
      session,
      where: (t) => t.facilityId.equals(facilityId),
      transaction: tx,
    );
    if (capabilities.isEmpty) return;
    await FacilityCapability.db.insert(session, [
      for (final c in capabilities)
        FacilityCapability(facilityId: facilityId, capability: c),
    ], transaction: tx);
  }
}
