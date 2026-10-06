import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../status/status_service.dart';

/// "Status was wrong" reports. Three in 24 hours flag the facility for
/// review and hide it from Tier 1 until an admin reviews it.
class ReportService {
  ReportService();

  static const flagThreshold = 3;
  static const window = Duration(hours: 24);

  final _perUser = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'report',
      source: 'user',
      maxAttempts: 10,
      timeframe: const Duration(hours: 24),
    ),
  );

  Future<StatusReport> report(
    Session session, {
    required EmergencySession emergencySession,
    required AppUser user,
    required int facilityId,
    required String reason,
  }) async {
    final now = clock.now();
    final actedAt = emergencySession.actedAt;
    if (actedAt == null || now.difference(actedAt) > window) {
      throw Errors.invalidState(
        'You can report a hospital for 24 hours after calling it or getting '
        'directions.',
      );
    }
    if (emergencySession.facilityId != facilityId) {
      throw Errors.validation('Report the hospital you called or went to.');
    }
    if (!await _perUser.tryRecordAttempt(session, key: '${user.id}')) {
      throw Errors.rateLimited();
    }
    final existing = await StatusReport.db.count(
      session,
      where: (t) =>
          t.sessionId.equals(emergencySession.id!) &
          t.facilityId.equals(facilityId),
    );
    if (existing > 0) {
      throw Errors.conflict('You already reported this hospital.');
    }
    final row = await StatusReport.db.insertRow(
      session,
      StatusReport(
        sessionId: emergencySession.id!,
        facilityId: facilityId,
        userId: user.id,
        reason: Validate.text(reason, field: 'reason', max: 500),
        createdAt: now,
      ),
    );
    await _maybeFlag(session, facilityId);
    return row;
  }

  Future<void> _maybeFlag(Session session, int facilityId) async {
    final since = clock.now().subtract(window);
    final recent = await StatusReport.db.count(
      session,
      where: (t) =>
          t.facilityId.equals(facilityId) &
          (t.createdAt > since) &
          t.reviewedAt.equals(null),
    );
    if (recent < flagThreshold) return;
    final facility = await Facility.db.findById(session, facilityId);
    if (facility == null || facility.flaggedAt != null) return;
    final flagged = await Facility.db.updateRow(
      session,
      facility.copyWith(flaggedAt: clock.now()),
    );
    final status = await FacilityStatus.db.findFirstRow(
      session,
      where: (t) => t.facilityId.equals(facilityId),
    );
    await session.messages.postMessage(
      StatusService.channel,
      FacilityStatusChanged(
        facilityId: flagged.id!,
        status: status,
        flagged: true,
      ),
    );
    session.log('facility=$facilityId flagged after reports');
  }
}
