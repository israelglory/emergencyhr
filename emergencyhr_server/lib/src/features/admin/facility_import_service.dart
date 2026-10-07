import 'package:serverpod/serverpod.dart';

import '../../core/audit_log.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import '../facilities/facility_service.dart';

/// Adds hospitals from an open dataset as unlisted, unverified listings.
///
/// Imported hospitals show to the public as "Unverified. Call before
/// going." until a desk starts confirming their status. Rows already
/// imported (same source id) are skipped, and so are rows with a similar
/// name close to an existing listing, so importing again is safe.
class FacilityImportService {
  const FacilityImportService({this.facilities = const FacilityService()});

  final FacilityService facilities;

  /// Rows per call, so each request stays small.
  static const maxRows = 250;

  Future<FacilityImportSummary> importRows(
    Session session, {
    required List<FacilityImportRow> rows,
    required bool dryRun,
    required AppUser admin,
  }) async {
    if (rows.isEmpty) throw Errors.validation('The file has no hospitals.');
    if (rows.length > maxRows) {
      throw Errors.validation('Import at most $maxRows hospitals at a time.');
    }
    final invalid = <String>[];
    final duplicates = <String>[];
    var alreadyImported = 0;

    final refs = {for (final r in rows) r.sourceRef.trim()};
    final existing = await Facility.db.find(
      session,
      where: (t) => t.sourceRef.inSet(refs),
    );
    final existingRefs = {for (final f in existing) f.sourceRef};
    final seen = <String>{};
    final now = clock.now();
    final toInsert = <Facility>[];

    for (final (i, r) in rows.indexed) {
      final ref = r.sourceRef.trim();
      final name = r.name.trim();
      final area = r.area.trim();
      final address = r.address.trim();
      final problem = _problem(ref, name, area, address, r.lat, r.lng);
      if (problem != null) {
        invalid.add('Row ${i + 1}${name.isEmpty ? '' : ' ($name)'}: $problem');
        continue;
      }
      if (!seen.add(ref)) {
        invalid.add('Row ${i + 1} ($name): listed twice in this file.');
        continue;
      }
      if (existingRefs.contains(ref)) {
        alreadyImported++;
        continue;
      }
      final matches = await facilities.findDuplicates(
        session,
        name: name,
        lat: r.lat,
        lng: r.lng,
      );
      final strong = matches.where((m) => m.strong).firstOrNull;
      if (strong != null) {
        duplicates.add('$name (near "${strong.facility.name}")');
        continue;
      }
      toInsert.add(
        Facility(
          name: name,
          type: r.type,
          address: address,
          area: area,
          lat: r.lat,
          lng: r.lng,
          verificationStatus: VerificationStatus.seeded,
          onboardingStage: OnboardingStage.seeded,
          source: FacilitySource.imported,
          sourceRef: ref,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    if (!dryRun && toInsert.isNotEmpty) {
      await session.db.transaction((tx) async {
        final inserted = await Facility.db.insert(
          session,
          toInsert,
          transaction: tx,
        );
        await AuditLog.record(
          session,
          actorUserId: admin.id!,
          action: 'facility:import',
          targetType: 'facility',
          targetId: inserted.first.id!,
          reason: 'Imported ${inserted.length} hospitals',
          transaction: tx,
        );
      });
    }

    return FacilityImportSummary(
      dryRun: dryRun,
      created: toInsert.length,
      alreadyImported: alreadyImported,
      possibleDuplicates: duplicates,
      invalid: invalid,
    );
  }

  /// Why a row cannot be used, or null. Coordinates must be in Nigeria.
  static String? _problem(
    String ref,
    String name,
    String area,
    String address,
    double lat,
    double lng,
  ) {
    if (ref.isEmpty || ref.length > 120) return 'missing or long source id.';
    if (name.isEmpty || name.length > 150) return 'missing or long name.';
    if (area.isEmpty || area.length > 80) return 'missing or long area.';
    if (address.length > 300) return 'address is too long.';
    if (lat < 4 || lat > 14 || lng < 2.5 || lng > 15) {
      return 'location is outside Nigeria.';
    }
    return null;
  }
}
