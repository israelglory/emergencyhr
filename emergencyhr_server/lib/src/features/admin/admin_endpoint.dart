import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/errors.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../facilities/facility_service.dart';
import '../onboarding/claim_service.dart';
import '../onboarding/join_request_service.dart';
import '../onboarding/onboarding_service.dart';
import 'admin_service.dart';
import 'facility_import_service.dart';

/// The Admin shell. Who may call: platform admins only, for every method.
class AdminEndpoint extends Endpoint {
  static const _admin = AdminService();
  static const _onboarding = OnboardingService();
  static const _facilities = FacilityService();
  static final _claims = ClaimService();
  static final _joins = JoinRequestService();
  static const _imports = FacilityImportService();

  Future<AppUser> _requireAdmin(Session session) =>
      AuthGuard.requireRole(session, {UserRole.platformAdmin});

  // Verification
  Future<List<VerificationItem>> verificationQueue(
    Session session, {
    int limit = 50,
    int offset = 0,
  }) async {
    await _requireAdmin(session);
    return _admin.verificationQueue(session, limit: limit, offset: offset);
  }

  Future<Facility> approve(Session session, int facilityId) async {
    final admin = await _requireAdmin(session);
    return _onboarding.approve(
      session,
      facility: await _facilities.require(session, facilityId),
      admin: admin,
    );
  }

  /// Verifies a listing directly, e.g. an imported hospital the admin has
  /// checked.
  Future<Facility> verifyListing(Session session, int facilityId) async {
    final admin = await _requireAdmin(session);
    return _onboarding.verifyListing(
      session,
      facility: await _facilities.require(session, facilityId),
      admin: admin,
    );
  }

  /// Adds hospitals from an open dataset. With [dryRun] nothing is saved
  /// and the summary says what would happen.
  Future<FacilityImportSummary> importFacilities(
    Session session,
    List<FacilityImportRow> rows, {
    bool dryRun = true,
  }) async {
    final admin = await _requireAdmin(session);
    return _imports.importRows(
      session,
      rows: rows,
      dryRun: dryRun,
      admin: admin,
    );
  }

  Future<Facility> reject(
    Session session,
    int facilityId,
    String reason,
  ) async {
    final admin = await _requireAdmin(session);
    return _onboarding.reject(
      session,
      facility: await _facilities.require(session, facilityId),
      admin: admin,
      reason: Validate.text(reason, field: 'reason', max: 500),
    );
  }

  // Directory
  Future<List<DirectoryRow>> directory(
    Session session, {
    String? query,
    String? area,
    OnboardingStage? stage,
    int limit = 50,
    int offset = 0,
  }) async {
    await _requireAdmin(session);
    return _admin.directory(
      session,
      query: query,
      area: area,
      stage: stage,
      limit: limit,
      offset: offset,
    );
  }

  // Pipeline
  Future<PipelineBoard> pipeline(
    Session session, {
    String? area,
    int? agentUserId,
  }) async {
    await _requireAdmin(session);
    return _admin.pipeline(session, area: area, agentUserId: agentUserId);
  }

  Future<void> assignAgent(
    Session session,
    List<int> facilityIds,
    int agentUserId,
  ) async {
    final admin = await _requireAdmin(session);
    await _admin.assignAgent(
      session,
      facilityIds: facilityIds,
      agentUserId: agentUserId,
      admin: admin,
    );
  }

  // Claims
  Future<List<ClaimQueueItem>> claims(
    Session session, {
    ClaimStatus status = ClaimStatus.pending,
    int limit = 50,
    int offset = 0,
  }) async {
    await _requireAdmin(session);
    return _claims.queue(session, status: status, limit: limit, offset: offset);
  }

  Future<ClaimRequest> approveClaim(Session session, int claimId) async {
    final admin = await _requireAdmin(session);
    final claim = await ClaimRequest.db.findById(session, claimId);
    if (claim == null) throw Errors.notFound('Claim');
    return _claims.approve(session, claim: claim, admin: admin);
  }

  Future<ClaimRequest> rejectClaim(
    Session session,
    int claimId,
    String reason,
  ) async {
    final admin = await _requireAdmin(session);
    final claim = await ClaimRequest.db.findById(session, claimId);
    if (claim == null) throw Errors.notFound('Claim');
    return _claims.reject(
      session,
      claim: claim,
      admin: admin,
      reason: Validate.text(reason, field: 'reason', max: 500),
    );
  }

  // Join requests
  Future<List<JoinRequest>> joinRequests(
    Session session, {
    JoinRequestStatus? status,
    int limit = 50,
    int offset = 0,
  }) async {
    await _requireAdmin(session);
    return _joins.list(session, status: status, limit: limit, offset: offset);
  }

  Future<JoinRequest> setJoinRequestStatus(
    Session session,
    int requestId,
    JoinRequestStatus status,
  ) async {
    final admin = await _requireAdmin(session);
    final request = await JoinRequest.db.findById(session, requestId);
    if (request == null) throw Errors.notFound('Join request');
    return _joins.setStatus(
      session,
      request: request,
      status: status,
      admin: admin,
    );
  }

  Future<JoinRequest> convertJoinRequest(
    Session session,
    int requestId,
    int agentUserId,
    double lat,
    double lng,
    String address,
  ) async {
    final admin = await _requireAdmin(session);
    final request = await JoinRequest.db.findById(session, requestId);
    if (request == null) throw Errors.notFound('Join request');
    return _joins.convert(
      session,
      request: request,
      admin: admin,
      agentUserId: agentUserId,
      lat: lat,
      lng: lng,
      address: address,
    );
  }

  // Field agents
  Future<List<AgentRow>> agents(Session session) async {
    await _requireAdmin(session);
    return _admin.agents(session);
  }

  Future<AgentRow> addAgent(
    Session session,
    String email,
    List<String> areas,
  ) async {
    final admin = await _requireAdmin(session);
    return _admin.addAgent(
      session,
      email: email,
      areas: areas,
      admin: admin,
    );
  }

  Future<void> setAgentAreas(
    Session session,
    int userId,
    List<String> areas,
  ) async {
    final admin = await _requireAdmin(session);
    await _admin.setAgentAreas(
      session,
      userId: userId,
      areas: areas,
      admin: admin,
    );
  }

  Future<void> deactivateAgent(Session session, int userId) async {
    final admin = await _requireAdmin(session);
    await _admin.deactivateAgent(session, userId: userId, admin: admin);
  }

  // Dashboards
  Future<List<FreshnessRow>> freshness(
    Session session, {
    int limit = 100,
    int offset = 0,
  }) async {
    await _requireAdmin(session);
    return _admin.freshness(session, limit: limit, offset: offset);
  }

  Future<List<ReportRow>> reports(
    Session session, {
    bool onlyFlagged = false,
  }) async {
    await _requireAdmin(session);
    return _admin.reports(session, onlyFlagged: onlyFlagged);
  }

  Future<void> reviewReports(
    Session session,
    int facilityId, {
    String? note,
  }) async {
    final admin = await _requireAdmin(session);
    await _admin.reviewReports(
      session,
      facilityId: facilityId,
      admin: admin,
      note: Validate.optionalText(note, field: 'note', max: 500),
    );
  }

  Future<PlatformMetrics> metrics(Session session) async {
    await _requireAdmin(session);
    return _admin.metrics(session);
  }

  Future<List<NewHospitalRow>> newHospitals(Session session) async {
    await _requireAdmin(session);
    return _admin.newHospitals(session);
  }

  // Suspensions
  Future<Facility> setFacilitySuspended(
    Session session,
    int facilityId,
    bool suspended,
    String reason,
  ) async {
    final admin = await _requireAdmin(session);
    return _admin.setFacilitySuspended(
      session,
      facilityId: facilityId,
      suspended: suspended,
      reason: reason,
      admin: admin,
    );
  }

  Future<List<UserRow>> users(
    Session session, {
    String? query,
    int limit = 50,
    int offset = 0,
  }) async {
    await _requireAdmin(session);
    return _admin.users(session, query: query, limit: limit, offset: offset);
  }

  Future<void> setUserSuspended(
    Session session,
    int userId,
    bool suspended,
    String reason,
  ) async {
    final admin = await _requireAdmin(session);
    await _admin.setUserSuspended(
      session,
      userId: userId,
      suspended: suspended,
      reason: reason,
      admin: admin,
    );
  }
}
