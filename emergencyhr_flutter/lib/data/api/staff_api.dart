import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Facility staff and invites.
class StaffApi {
  StaffApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'StaffApi';

  Future<ApiResponse<List<StaffMember>>> list(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.staff.list(facilityId));

  Future<ApiResponse<bool>> remove(int facilityId, int userId, UserRole role) =>
      ApiResponse.guardVoid(
        _tag,
        () => _client.staff.remove(facilityId, userId, role),
      );

  Future<ApiResponse<InviteCreated>> invite(
    int facilityId,
    UserRole role, {
    String? phone,
  }) => ApiResponse.guard(
    _tag,
    () => _client.invite.create(facilityId, role, phone: phone),
  );

  Future<ApiResponse<List<FacilityInvite>>> invites(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.invite.list(facilityId));

  Future<ApiResponse<FacilityInvite>> revokeInvite(int inviteId) =>
      ApiResponse.guard(_tag, () => _client.invite.revoke(inviteId));

  Future<ApiResponse<InvitePreview>> previewInvite(String code) =>
      ApiResponse.guard(_tag, () => _client.invite.preview(code));

  Future<ApiResponse<RoleAssignment>> acceptInvite(String code) =>
      ApiResponse.guard(_tag, () => _client.invite.accept(code));
}
