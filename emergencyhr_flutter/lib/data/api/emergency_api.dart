import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// The emergency flow. Works without an account.
class EmergencyApi {
  EmergencyApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'EmergencyApi';

  Future<ApiResponse<EmergencySearch>> start({
    required double lat,
    required double lng,
    required EmergencyType type,
    String? area,
    DateTime? tappedAt,
  }) => ApiResponse.guard(
    _tag,
    () => _client.emergency
        .start(lat, lng, type, area: area, tappedAt: tappedAt)
        .timeout(const Duration(seconds: 12)),
  );

  Future<ApiResponse<EmergencySearch>> refresh(int sessionId, String token) =>
      ApiResponse.guard(
        _tag,
        () => _client.emergency.refresh(sessionId, token),
      );

  /// Live re-ranked results. Errors close the stream; callers fall back to
  /// periodic refresh.
  Stream<EmergencySearch> watch(int sessionId, String token) =>
      _client.emergency.watch(sessionId, token);

  Future<ApiResponse<bool>> recordAction(
    int sessionId,
    String token,
    EmergencyAction action, {
    int? facilityId,
  }) => ApiResponse.guardVoid(
    _tag,
    () => _client.emergency.recordAction(
      sessionId,
      token,
      action,
      facilityId: facilityId,
    ),
  );

  Future<ApiResponse<bool>> reportWrongStatus(
    int sessionId,
    String token,
    int facilityId,
    String reason,
  ) => ApiResponse.guardVoid(
    _tag,
    () => _client.emergency.reportWrongStatus(
      sessionId,
      token,
      facilityId,
      reason,
    ),
  );

  Future<ApiResponse<PublicFacility>> facility(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.emergency.facility(facilityId));
}
