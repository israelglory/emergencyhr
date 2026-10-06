import 'dart:typed_data';

import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// Field onboarding, verification submission, claims and join requests.
class OnboardingApi {
  OnboardingApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'OnboardingApi';

  Future<ApiResponse<List<AgentFacility>>> myFacilities({
    double? lat,
    double? lng,
  }) => ApiResponse.guard(
    _tag,
    () => _client.onboarding.myFacilities(lat: lat, lng: lng),
  );

  Future<ApiResponse<GoLiveChecklist>> checklist(int facilityId) =>
      ApiResponse.guard(_tag, () => _client.onboarding.checklist(facilityId));

  Future<ApiResponse<Facility>> setStage(
    int facilityId,
    OnboardingStage stage, {
    String? note,
  }) => ApiResponse.guard(
    _tag,
    () => _client.onboarding.setStage(facilityId, stage, note: note),
  );

  Future<ApiResponse<OnboardingRecord>> updateRecord(
    int facilityId, {
    String? notes,
    DateTime? nextActionAt,
  }) => ApiResponse.guard(
    _tag,
    () => _client.onboarding.updateRecord(
      facilityId,
      notes: notes,
      nextActionAt: nextActionAt,
    ),
  );

  Future<ApiResponse<Facility>> submitForVerification(
    int facilityId, {
    String? notes,
  }) => ApiResponse.guard(
    _tag,
    () => _client.onboarding.submitForVerification(facilityId, notes: notes),
  );

  Future<ApiResponse<OtpRequestResult>> requestDeskPhoneCode(int facilityId) =>
      ApiResponse.guard(
        _tag,
        () => _client.onboarding.requestDeskPhoneCode(facilityId),
      );

  Future<ApiResponse<Facility>> confirmDeskPhone(int facilityId, String code) =>
      ApiResponse.guard(
        _tag,
        () => _client.onboarding.confirmDeskPhone(facilityId, code),
      );

  Future<ApiResponse<Facility>> recordTestCall(
    int facilityId, {
    String? note,
  }) => ApiResponse.guard(
    _tag,
    () => _client.onboarding.recordTestCall(facilityId, note: note),
  );

  /// Uploads a document to private storage and records it.
  Future<ApiResponse<FacilityDocument>> uploadDocument({
    required String fileName,
    required Uint8List bytes,
    required DocumentKind kind,
    int? facilityId,
  }) => ApiResponse.guard(_tag, () async {
    final ticket = await _client.document.createUpload(
      fileName,
      facilityId: facilityId,
    );
    final uploaded = await FileUploader(
      ticket.uploadDescription,
    ).uploadByteData(ByteData.sublistView(bytes));
    if (!uploaded) throw StateError('Upload failed');
    return _client.document.confirmUpload(
      ticket.path,
      kind,
      facilityId: facilityId,
    );
  });

  Future<ApiResponse<ByteData>> downloadDocument(int documentId) =>
      ApiResponse.guard(_tag, () => _client.document.download(documentId));

  Future<ApiResponse<OtpRequestResult>> requestClaimCode(int facilityId) =>
      ApiResponse.guard(
        _tag,
        () => _client.claim.requestDeskPhoneCode(facilityId),
      );

  Future<ApiResponse<ClaimRequest>> submitClaim({
    required int facilityId,
    required String contactName,
    required List<String> documentPaths,
    String? deskPhoneCode,
  }) => ApiResponse.guard(
    _tag,
    () => _client.claim.submit(
      facilityId,
      contactName,
      documentPaths,
      deskPhoneCode: deskPhoneCode,
    ),
  );

  Future<ApiResponse<List<ClaimRequest>>> myClaims() =>
      ApiResponse.guard(_tag, () => _client.claim.mine());

  Future<ApiResponse<JoinRequest>> submitJoinRequest({
    required String hospitalName,
    required String contactName,
    required String phone,
    required String area,
    String? message,
  }) => ApiResponse.guard(
    _tag,
    () => _client.joinRequest.submit(
      hospitalName,
      contactName,
      phone,
      area,
      message: message,
    ),
  );
}
