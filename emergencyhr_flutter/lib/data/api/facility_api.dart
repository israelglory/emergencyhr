import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Facility listings and profiles.
class FacilityApi {
  FacilityApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'FacilityApi';

  Future<ApiResponse<List<FacilitySearchResult>>> search(
    String query, {
    String? area,
  }) => ApiResponse.guard(
    _tag,
    () => _client.facility.search(query, area: area),
  );

  Future<ApiResponse<List<FacilitySearchResult>>> nearby(
    double lat,
    double lng,
  ) => ApiResponse.guard(_tag, () => _client.facility.nearby(lat, lng));

  Future<ApiResponse<List<DuplicateCandidate>>> findDuplicates(
    String name,
    double lat,
    double lng,
  ) => ApiResponse.guard(
    _tag,
    () => _client.facility.findDuplicates(name, lat, lng),
  );

  Future<ApiResponse<Facility>> create(FacilityProfileInput input) =>
      ApiResponse.guard(_tag, () => _client.facility.create(input));

  Future<ApiResponse<Facility>> updateProfile(
    int facilityId,
    FacilityProfileInput input,
  ) => ApiResponse.guard(
    _tag,
    () => _client.facility.updateProfile(facilityId, input),
  );

  Future<ApiResponse<FacilityDetail>> detail(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.facility.detail(facilityId));
}
