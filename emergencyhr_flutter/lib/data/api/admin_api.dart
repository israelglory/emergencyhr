import 'dart:typed_data';

import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Platform admin operations. The server allows platform admins only.
class AdminApi {
  AdminApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  EndpointAdmin get _admin => _client.admin;
  static const _tag = 'AdminApi';

  Future<ApiResponse<T>> _g<T>(Future<T> Function() call) =>
      ApiResponse.guard(_tag, call);
  Future<ApiResponse<bool>> _v(Future<void> Function() call) =>
      ApiResponse.guardVoid(_tag, call);

  Future<ApiResponse<List<VerificationItem>>> verificationQueue() =>
      _g(() => _admin.verificationQueue(limit: 50, offset: 0));
  Future<ApiResponse<Facility>> approve(int id) => _g(() => _admin.approve(id));
  Future<ApiResponse<Facility>> reject(int id, String reason) =>
      _g(() => _admin.reject(id, reason));
  Future<ApiResponse<ByteData>> document(int documentId) =>
      _g(() => _client.document.download(documentId));

  Future<ApiResponse<List<DirectoryRow>>> directory({
    String? query,
    String? area,
    OnboardingStage? stage,
    int offset = 0,
  }) => _g(
    () => _admin.directory(
      query: query,
      area: area,
      stage: stage,
      limit: 50,
      offset: offset,
    ),
  );

  Future<ApiResponse<PipelineBoard>> pipeline({
    String? area,
    int? agentUserId,
  }) => _g(() => _admin.pipeline(area: area, agentUserId: agentUserId));
  Future<ApiResponse<bool>> assignAgent(List<int> facilityIds, int agentId) =>
      _v(() => _admin.assignAgent(facilityIds, agentId));

  Future<ApiResponse<List<ClaimQueueItem>>> claims() => _g(
    () => _admin.claims(status: ClaimStatus.pending, limit: 50, offset: 0),
  );
  Future<ApiResponse<ClaimRequest>> approveClaim(int id) =>
      _g(() => _admin.approveClaim(id));
  Future<ApiResponse<ClaimRequest>> rejectClaim(int id, String reason) =>
      _g(() => _admin.rejectClaim(id, reason));

  Future<ApiResponse<List<JoinRequest>>> joinRequests() =>
      _g(() => _admin.joinRequests(status: null, limit: 50, offset: 0));
  Future<ApiResponse<JoinRequest>> setJoinStatus(
    int id,
    JoinRequestStatus status,
  ) => _g(() => _admin.setJoinRequestStatus(id, status));
  Future<ApiResponse<JoinRequest>> convertJoin({
    required int id,
    required int agentUserId,
    required double lat,
    required double lng,
    required String address,
  }) => _g(() => _admin.convertJoinRequest(id, agentUserId, lat, lng, address));

  Future<ApiResponse<List<AgentRow>>> agents() => _g(() => _admin.agents());
  Future<ApiResponse<AgentRow>> addAgent(
    String phone,
    String name,
    List<String> areas,
  ) => _g(() => _admin.addAgent(phone, name, areas));
  Future<ApiResponse<bool>> setAgentAreas(int userId, List<String> areas) =>
      _v(() => _admin.setAgentAreas(userId, areas));
  Future<ApiResponse<bool>> deactivateAgent(int userId) =>
      _v(() => _admin.deactivateAgent(userId));

  Future<ApiResponse<List<FreshnessRow>>> freshness() =>
      _g(() => _admin.freshness(limit: 100, offset: 0));
  Future<ApiResponse<List<ReportRow>>> reports() =>
      _g(() => _admin.reports(onlyFlagged: false));
  Future<ApiResponse<bool>> reviewReports(int facilityId) =>
      _v(() => _admin.reviewReports(facilityId, note: null));
  Future<ApiResponse<PlatformMetrics>> metrics() => _g(() => _admin.metrics());
  Future<ApiResponse<List<NewHospitalRow>>> newHospitals() =>
      _g(() => _admin.newHospitals());

  Future<ApiResponse<Facility>> setFacilitySuspended(
    int id,
    bool suspended,
    String reason,
  ) => _g(() => _admin.setFacilitySuspended(id, suspended, reason));
  Future<ApiResponse<List<UserRow>>> users({String? query}) =>
      _g(() => _admin.users(query: query, limit: 50, offset: 0));
  Future<ApiResponse<bool>> setUserSuspended(
    int userId,
    bool suspended,
    String reason,
  ) => _v(() => _admin.setUserSuspended(userId, suspended, reason));
}
