import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// The signed-in user's contacts, medical profile and data rights.
class ProfileApi {
  ProfileApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'ProfileApi';

  Future<ApiResponse<List<EmergencyContact>>> contacts() =>
      ApiResponse.guard(_tag, () => _client.profile.contacts());

  Future<ApiResponse<EmergencyContact>> saveContact(EmergencyContact c) =>
      ApiResponse.guard(_tag, () => _client.profile.saveContact(c));

  Future<ApiResponse<bool>> deleteContact(int id) =>
      ApiResponse.guardVoid(_tag, () => _client.profile.deleteContact(id));

  Future<ApiResponse<MedicalProfileData>> medical() =>
      ApiResponse.guard(_tag, () => _client.profile.medical());

  Future<ApiResponse<MedicalProfileData>> saveMedical(
    MedicalProfileData data, {
    required bool consent,
  }) => ApiResponse.guard(
    _tag,
    () => _client.profile.saveMedical(data, consent),
  );

  Future<ApiResponse<bool>> deleteMedical() =>
      ApiResponse.guardVoid(_tag, () => _client.profile.deleteMedical());

  Future<ApiResponse<String>> exportMyData() =>
      ApiResponse.guard(_tag, () => _client.profile.exportMyData());

  Future<ApiResponse<bool>> deleteMyAccount() =>
      ApiResponse.guardVoid(_tag, () => _client.profile.deleteMyAccount());

  Future<ApiResponse<List<FirstAidCard>>> firstAidCards() =>
      ApiResponse.guard(_tag, () => _client.firstAid.cards());

  Future<ApiResponse<FamilyAlertResult>> notifyFamily(
    int sessionId,
    String token,
  ) => ApiResponse.guard(
    _tag,
    () => _client.emergency.notifyFamily(sessionId, token),
  );
}
