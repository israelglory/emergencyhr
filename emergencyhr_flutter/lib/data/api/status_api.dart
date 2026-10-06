import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Hospital desk status updates and the audit log.
class StatusApi {
  StatusApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'StatusApi';

  Future<ApiResponse<FacilityStatus?>> current(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.status.current(facilityId));

  Future<ApiResponse<FacilityStatus>> update(
    int facilityId,
    StatusInput input,
  ) => ApiResponse.guard(_tag, () => _client.status.update(facilityId, input));

  Future<ApiResponse<FacilityStatus>> confirm(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.status.confirm(facilityId));

  Future<ApiResponse<bool>> practice(int facilityId, StatusInput input) =>
      ApiResponse.guardVoid(
        _tag,
        () => _client.status.practice(facilityId, input),
      );

  Future<ApiResponse<List<AuditEntry>>> auditLog(
    int facilityId, {
    int limit = 50,
    int offset = 0,
  }) => ApiResponse.guard(
    _tag,
    () => _client.status.auditLog(facilityId, limit: limit, offset: offset),
  );
}
