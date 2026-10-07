/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:emergencyhr_client/src/protocol/features/admin/models/agent_row.dart'
    as _i3t6hodj;
import 'package:emergencyhr_client/src/protocol/features/admin/models/claim_queue_item.dart'
    as _ib27qxyi;
import 'package:emergencyhr_client/src/protocol/features/admin/models/directory_row.dart'
    as _ilxv0wae;
import 'package:emergencyhr_client/src/protocol/features/admin/models/facility_import_row.dart'
    as _ifhgg7r5;
import 'package:emergencyhr_client/src/protocol/features/admin/models/facility_import_summary.dart'
    as _irupva58;
import 'package:emergencyhr_client/src/protocol/features/admin/models/freshness_row.dart'
    as _ik1xr38l;
import 'package:emergencyhr_client/src/protocol/features/admin/models/new_hospital_row.dart'
    as _ia6kw2vn;
import 'package:emergencyhr_client/src/protocol/features/admin/models/pipeline_board.dart'
    as _ii9l9p46;
import 'package:emergencyhr_client/src/protocol/features/admin/models/platform_metrics.dart'
    as _igrqa8vd;
import 'package:emergencyhr_client/src/protocol/features/admin/models/report_row.dart'
    as _i2zx97wu;
import 'package:emergencyhr_client/src/protocol/features/admin/models/user_row.dart'
    as _ij7c6bnu;
import 'package:emergencyhr_client/src/protocol/features/admin/models/verification_item.dart'
    as _ip6f1g6g;
import 'package:emergencyhr_client/src/protocol/features/assistant/models/ai_conversation.dart'
    as _ihn3q5hk;
import 'package:emergencyhr_client/src/protocol/features/assistant/models/chat_event.dart'
    as _iqngx2tf;
import 'package:emergencyhr_client/src/protocol/features/assistant/models/chat_message_view.dart'
    as _irdvths1;
import 'package:emergencyhr_client/src/protocol/features/auth/models/current_user.dart'
    as _iau1s38u;
import 'package:emergencyhr_client/src/protocol/features/auth/models/otp_request_result.dart'
    as _ie9uc2bd;
import 'package:emergencyhr_client/src/protocol/features/auth/models/role_assignment.dart'
    as _idpsepmh;
import 'package:emergencyhr_client/src/protocol/features/auth/models/user_role.dart'
    as _ibmnj6dm;
import 'package:emergencyhr_client/src/protocol/features/emergency/models/emergency_action.dart'
    as _idi0zydt;
import 'package:emergencyhr_client/src/protocol/features/emergency/models/emergency_search.dart'
    as _ifmldpgz;
import 'package:emergencyhr_client/src/protocol/features/emergency/models/emergency_type.dart'
    as _io6p8b24;
import 'package:emergencyhr_client/src/protocol/features/emergency/models/public_facility.dart'
    as _i3ykk0vt;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/document_kind.dart'
    as _iadcdtur;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/duplicate_candidate.dart'
    as _i6bzf55j;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/facility.dart'
    as _ibcfwqdd;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/facility_detail.dart'
    as _idntymqu;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/facility_document.dart'
    as _ia2ku4de;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/facility_profile_input.dart'
    as _icsjts62;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/facility_search_result.dart'
    as _i7vk8exb;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/onboarding_stage.dart'
    as _imd9hu5k;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/upload_ticket.dart'
    as _i4szztal;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/agent_facility.dart'
    as _i4l2530l;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/claim_request.dart'
    as _iy913k1i;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/claim_status.dart'
    as _iw39ehhf;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/facility_invite.dart'
    as _iowxn2fh;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/go_live_checklist.dart'
    as _i12l59eb;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/invite_created.dart'
    as _i9iib0sv;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/invite_preview.dart'
    as _imqhjh1w;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/join_request.dart'
    as _iw37o6hv;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/join_request_status.dart'
    as _i1mjz31e;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/onboarding_record.dart'
    as _idy003ld;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/staff_member.dart'
    as _ii3vg1nr;
import 'package:emergencyhr_client/src/protocol/features/profile/models/emergency_contact.dart'
    as _iu611yjn;
import 'package:emergencyhr_client/src/protocol/features/profile/models/family_alert_result.dart'
    as _i46ar9rz;
import 'package:emergencyhr_client/src/protocol/features/profile/models/first_aid_card.dart'
    as _i7aojmz9;
import 'package:emergencyhr_client/src/protocol/features/profile/models/medical_profile_data.dart'
    as _icwufl9g;
import 'package:emergencyhr_client/src/protocol/features/status/models/audit_entry.dart'
    as _i6yinprw;
import 'package:emergencyhr_client/src/protocol/features/status/models/facility_status.dart'
    as _ikh3pjuy;
import 'package:emergencyhr_client/src/protocol/features/status/models/status_input.dart'
    as _ic5rdr82;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Email sign-in: registration with an emailed code, login, password reset.
/// Who may call: anyone.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The Admin shell. Who may call: platform admins only, for every method.
/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _ida.Future<List<_ip6f1g6g.VerificationItem>> verificationQueue({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ip6f1g6g.VerificationItem>>(
    'admin',
    'verificationQueue',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_ibcfwqdd.Facility> approve(int facilityId) =>
      caller.callServerEndpoint<_ibcfwqdd.Facility>(
        'admin',
        'approve',
        {'facilityId': facilityId},
      );

  /// Verifies a listing directly, e.g. an imported hospital the admin has
  /// checked.
  _ida.Future<_ibcfwqdd.Facility> verifyListing(int facilityId) =>
      caller.callServerEndpoint<_ibcfwqdd.Facility>(
        'admin',
        'verifyListing',
        {'facilityId': facilityId},
      );

  /// Adds hospitals from an open dataset. With [dryRun] nothing is saved
  /// and the summary says what would happen.
  _ida.Future<_irupva58.FacilityImportSummary> importFacilities(
    List<_ifhgg7r5.FacilityImportRow> rows, {
    required bool dryRun,
  }) => caller.callServerEndpoint<_irupva58.FacilityImportSummary>(
    'admin',
    'importFacilities',
    {
      'rows': rows,
      'dryRun': dryRun,
    },
  );

  _ida.Future<_ibcfwqdd.Facility> reject(
    int facilityId,
    String reason,
  ) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'admin',
    'reject',
    {
      'facilityId': facilityId,
      'reason': reason,
    },
  );

  _ida.Future<List<_ilxv0wae.DirectoryRow>> directory({
    String? query,
    String? area,
    _imd9hu5k.OnboardingStage? stage,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ilxv0wae.DirectoryRow>>(
    'admin',
    'directory',
    {
      'query': query,
      'area': area,
      'stage': stage,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_ii9l9p46.PipelineBoard> pipeline({
    String? area,
    int? agentUserId,
  }) => caller.callServerEndpoint<_ii9l9p46.PipelineBoard>(
    'admin',
    'pipeline',
    {
      'area': area,
      'agentUserId': agentUserId,
    },
  );

  _ida.Future<void> assignAgent(
    List<int> facilityIds,
    int agentUserId,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'assignAgent',
    {
      'facilityIds': facilityIds,
      'agentUserId': agentUserId,
    },
  );

  _ida.Future<List<_ib27qxyi.ClaimQueueItem>> claims({
    required _iw39ehhf.ClaimStatus status,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ib27qxyi.ClaimQueueItem>>(
    'admin',
    'claims',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_iy913k1i.ClaimRequest> approveClaim(int claimId) =>
      caller.callServerEndpoint<_iy913k1i.ClaimRequest>(
        'admin',
        'approveClaim',
        {'claimId': claimId},
      );

  _ida.Future<_iy913k1i.ClaimRequest> rejectClaim(
    int claimId,
    String reason,
  ) => caller.callServerEndpoint<_iy913k1i.ClaimRequest>(
    'admin',
    'rejectClaim',
    {
      'claimId': claimId,
      'reason': reason,
    },
  );

  _ida.Future<List<_iw37o6hv.JoinRequest>> joinRequests({
    _i1mjz31e.JoinRequestStatus? status,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_iw37o6hv.JoinRequest>>(
    'admin',
    'joinRequests',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_iw37o6hv.JoinRequest> setJoinRequestStatus(
    int requestId,
    _i1mjz31e.JoinRequestStatus status,
  ) => caller.callServerEndpoint<_iw37o6hv.JoinRequest>(
    'admin',
    'setJoinRequestStatus',
    {
      'requestId': requestId,
      'status': status,
    },
  );

  _ida.Future<_iw37o6hv.JoinRequest> convertJoinRequest(
    int requestId,
    int agentUserId,
    double lat,
    double lng,
    String address,
  ) => caller.callServerEndpoint<_iw37o6hv.JoinRequest>(
    'admin',
    'convertJoinRequest',
    {
      'requestId': requestId,
      'agentUserId': agentUserId,
      'lat': lat,
      'lng': lng,
      'address': address,
    },
  );

  _ida.Future<List<_i3t6hodj.AgentRow>> agents() =>
      caller.callServerEndpoint<List<_i3t6hodj.AgentRow>>(
        'admin',
        'agents',
        {},
      );

  _ida.Future<_i3t6hodj.AgentRow> addAgent(
    String email,
    List<String> areas,
  ) => caller.callServerEndpoint<_i3t6hodj.AgentRow>(
    'admin',
    'addAgent',
    {
      'email': email,
      'areas': areas,
    },
  );

  _ida.Future<void> setAgentAreas(
    int userId,
    List<String> areas,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'setAgentAreas',
    {
      'userId': userId,
      'areas': areas,
    },
  );

  _ida.Future<void> deactivateAgent(int userId) =>
      caller.callServerEndpoint<void>(
        'admin',
        'deactivateAgent',
        {'userId': userId},
      );

  _ida.Future<List<_ik1xr38l.FreshnessRow>> freshness({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ik1xr38l.FreshnessRow>>(
    'admin',
    'freshness',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<List<_i2zx97wu.ReportRow>> reports({required bool onlyFlagged}) =>
      caller.callServerEndpoint<List<_i2zx97wu.ReportRow>>(
        'admin',
        'reports',
        {'onlyFlagged': onlyFlagged},
      );

  _ida.Future<void> reviewReports(
    int facilityId, {
    String? note,
  }) => caller.callServerEndpoint<void>(
    'admin',
    'reviewReports',
    {
      'facilityId': facilityId,
      'note': note,
    },
  );

  _ida.Future<_igrqa8vd.PlatformMetrics> metrics() =>
      caller.callServerEndpoint<_igrqa8vd.PlatformMetrics>(
        'admin',
        'metrics',
        {},
      );

  _ida.Future<List<_ia6kw2vn.NewHospitalRow>> newHospitals() =>
      caller.callServerEndpoint<List<_ia6kw2vn.NewHospitalRow>>(
        'admin',
        'newHospitals',
        {},
      );

  _ida.Future<_ibcfwqdd.Facility> setFacilitySuspended(
    int facilityId,
    bool suspended,
    String reason,
  ) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'admin',
    'setFacilitySuspended',
    {
      'facilityId': facilityId,
      'suspended': suspended,
      'reason': reason,
    },
  );

  _ida.Future<List<_ij7c6bnu.UserRow>> users({
    String? query,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ij7c6bnu.UserRow>>(
    'admin',
    'users',
    {
      'query': query,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<void> setUserSuspended(
    int userId,
    bool suspended,
    String reason,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'setUserSuspended',
    {
      'userId': userId,
      'suspended': suspended,
      'reason': reason,
    },
  );
}

/// The Health Assistant. Who may call: signed-in users, for their own
/// conversations only. Rate limited.
/// {@category Endpoint}
class EndpointAssistant extends _isc.EndpointRef {
  EndpointAssistant(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'assistant';

  _ida.Stream<_iqngx2tf.ChatEvent> send(
    String message, {
    int? conversationId,
  }) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_iqngx2tf.ChatEvent>,
        _iqngx2tf.ChatEvent
      >(
        'assistant',
        'send',
        {
          'message': message,
          'conversationId': conversationId,
        },
        {},
      );

  _ida.Future<List<_ihn3q5hk.AiConversation>> conversations() =>
      caller.callServerEndpoint<List<_ihn3q5hk.AiConversation>>(
        'assistant',
        'conversations',
        {},
      );

  _ida.Future<List<_irdvths1.ChatMessageView>> messages(int conversationId) =>
      caller.callServerEndpoint<List<_irdvths1.ChatMessageView>>(
        'assistant',
        'messages',
        {'conversationId': conversationId},
      );

  _ida.Future<void> deleteConversation(int conversationId) =>
      caller.callServerEndpoint<void>(
        'assistant',
        'deleteConversation',
        {'conversationId': conversationId},
      );

  _ida.Future<void> deleteAllConversations() => caller.callServerEndpoint<void>(
    'assistant',
    'deleteAllConversations',
    {},
  );
}

/// The signed-in user's own account. Who may call: any signed-in user.
/// {@category Endpoint}
class EndpointAccount extends _isc.EndpointRef {
  EndpointAccount(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _ida.Future<_iau1s38u.CurrentUser> me() =>
      caller.callServerEndpoint<_iau1s38u.CurrentUser>(
        'account',
        'me',
        {},
      );

  /// Adds, changes or (with null) removes the optional phone number.
  _ida.Future<_iau1s38u.CurrentUser> updatePhone(String? phone) =>
      caller.callServerEndpoint<_iau1s38u.CurrentUser>(
        'account',
        'updatePhone',
        {'phone': phone},
      );

  _ida.Future<_iau1s38u.CurrentUser> updateName(String name) =>
      caller.callServerEndpoint<_iau1s38u.CurrentUser>(
        'account',
        'updateName',
        {'name': name},
      );
}

/// The emergency flow. Who may call: anyone, signed in or not. Session
/// updates need the session's private access token.
/// {@category Endpoint}
class EndpointEmergency extends _isc.EndpointRef {
  EndpointEmergency(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emergency';

  /// Starts a session and returns ranked results.
  _ida.Future<_ifmldpgz.EmergencySearch> start(
    double lat,
    double lng,
    _io6p8b24.EmergencyType type, {
    String? area,
    DateTime? tappedAt,
  }) => caller.callServerEndpoint<_ifmldpgz.EmergencySearch>(
    'emergency',
    'start',
    {
      'lat': lat,
      'lng': lng,
      'type': type,
      'area': area,
      'tappedAt': tappedAt,
    },
  );

  /// Fresh ranking for an existing session (pull to refresh).
  _ida.Future<_ifmldpgz.EmergencySearch> refresh(
    int sessionId,
    String accessToken,
  ) => caller.callServerEndpoint<_ifmldpgz.EmergencySearch>(
    'emergency',
    'refresh',
    {
      'sessionId': sessionId,
      'accessToken': accessToken,
    },
  );

  /// Changes "What happened" or the area for an open session and returns
  /// the new ranking. Who may call: the holder of the session token. Pass
  /// [lat] and [lng] together, or neither to keep the place.
  _ida.Future<_ifmldpgz.EmergencySearch> updateSearch(
    int sessionId,
    String accessToken,
    _io6p8b24.EmergencyType type, {
    double? lat,
    double? lng,
    String? area,
  }) => caller.callServerEndpoint<_ifmldpgz.EmergencySearch>(
    'emergency',
    'updateSearch',
    {
      'sessionId': sessionId,
      'accessToken': accessToken,
      'type': type,
      'lat': lat,
      'lng': lng,
      'area': area,
    },
  );

  /// Re-ranks and emits whenever a listed facility changes status, so an
  /// open results list updates within seconds.
  _ida.Stream<_ifmldpgz.EmergencySearch> watch(
    int sessionId,
    String accessToken,
  ) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ifmldpgz.EmergencySearch>,
        _ifmldpgz.EmergencySearch
      >(
        'emergency',
        'watch',
        {
          'sessionId': sessionId,
          'accessToken': accessToken,
        },
        {},
      );

  _ida.Future<void> recordAction(
    int sessionId,
    String accessToken,
    _idi0zydt.EmergencyAction action, {
    int? facilityId,
  }) => caller.callServerEndpoint<void>(
    'emergency',
    'recordAction',
    {
      'sessionId': sessionId,
      'accessToken': accessToken,
      'action': action,
      'facilityId': facilityId,
    },
  );

  /// Report a wrong status. Who may call: signed-in users, for 24 hours
  /// after acting on that hospital.
  _ida.Future<void> reportWrongStatus(
    int sessionId,
    String accessToken,
    int facilityId,
    String reason,
  ) => caller.callServerEndpoint<void>(
    'emergency',
    'reportWrongStatus',
    {
      'sessionId': sessionId,
      'accessToken': accessToken,
      'facilityId': facilityId,
      'reason': reason,
    },
  );

  /// Texts the user's emergency contacts. Who may call: signed-in users,
  /// for their own session.
  _ida.Future<_i46ar9rz.FamilyAlertResult> notifyFamily(
    int sessionId,
    String accessToken,
  ) => caller.callServerEndpoint<_i46ar9rz.FamilyAlertResult>(
    'emergency',
    'notifyFamily',
    {
      'sessionId': sessionId,
      'accessToken': accessToken,
    },
  );

  /// Hospital detail page. Who may call: anyone.
  _ida.Future<_i3ykk0vt.PublicFacility> facility(int facilityId) =>
      caller.callServerEndpoint<_i3ykk0vt.PublicFacility>(
        'emergency',
        'facility',
        {'facilityId': facilityId},
      );
}

/// {@category Endpoint}
class EndpointDocument extends _isc.EndpointRef {
  EndpointDocument(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  /// Facility documents: the facility's managers. Claim documents (no
  /// facility yet): any signed-in user, stored under their own folder.
  _ida.Future<_i4szztal.UploadTicket> createUpload(
    String fileName, {
    int? facilityId,
  }) => caller.callServerEndpoint<_i4szztal.UploadTicket>(
    'document',
    'createUpload',
    {
      'fileName': fileName,
      'facilityId': facilityId,
    },
  );

  /// Same callers as [createUpload].
  _ida.Future<_ia2ku4de.FacilityDocument> confirmUpload(
    String path,
    _iadcdtur.DocumentKind kind, {
    int? facilityId,
  }) => caller.callServerEndpoint<_ia2ku4de.FacilityDocument>(
    'document',
    'confirmUpload',
    {
      'path': path,
      'kind': kind,
      'facilityId': facilityId,
    },
  );

  /// Who may call: platform admins, or the facility's managers.
  _ida.Future<_idt.ByteData> download(int documentId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'document',
        'download',
        {'documentId': documentId},
      );
}

/// {@category Endpoint}
class EndpointFacility extends _isc.EndpointRef {
  EndpointFacility(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'facility';

  /// Search listings by name. Who may call: anyone.
  _ida.Future<List<_i7vk8exb.FacilitySearchResult>> search(
    String query, {
    String? area,
  }) => caller.callServerEndpoint<List<_i7vk8exb.FacilitySearchResult>>(
    'facility',
    'search',
    {
      'query': query,
      'area': area,
    },
  );

  /// Listings within 300 m of the agent. Who may call: field agents, admins.
  _ida.Future<List<_i7vk8exb.FacilitySearchResult>> nearby(
    double lat,
    double lng,
  ) => caller.callServerEndpoint<List<_i7vk8exb.FacilitySearchResult>>(
    'facility',
    'nearby',
    {
      'lat': lat,
      'lng': lng,
    },
  );

  /// Who may call: any signed-in user.
  _ida.Future<List<_i6bzf55j.DuplicateCandidate>> findDuplicates(
    String name,
    double lat,
    double lng,
  ) => caller.callServerEndpoint<List<_i6bzf55j.DuplicateCandidate>>(
    'facility',
    'findDuplicates',
    {
      'name': name,
      'lat': lat,
      'lng': lng,
    },
  );

  /// Creates a listing. Field agents create agent listings, platform admins
  /// create directory listings, anyone else creates a self-serve listing and
  /// becomes its hospital admin. Who may call: any signed-in user.
  _ida.Future<_ibcfwqdd.Facility> create(
    _icsjts62.FacilityProfileInput input,
  ) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'facility',
    'create',
    {'input': input},
  );

  /// Who may call: the facility's hospital admin, assigned field agent,
  /// platform admins.
  _ida.Future<_ibcfwqdd.Facility> updateProfile(
    int facilityId,
    _icsjts62.FacilityProfileInput input,
  ) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'facility',
    'updateProfile',
    {
      'facilityId': facilityId,
      'input': input,
    },
  );

  /// Who may call: the facility's staff, assigned agent, platform admins.
  _ida.Future<_idntymqu.FacilityDetail> detail(int facilityId) =>
      caller.callServerEndpoint<_idntymqu.FacilityDetail>(
        'facility',
        'detail',
        {'facilityId': facilityId},
      );
}

/// Self-serve claims. Who may call: any signed-in user.
/// {@category Endpoint}
class EndpointClaim extends _isc.EndpointRef {
  EndpointClaim(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'claim';

  _ida.Future<_ie9uc2bd.OtpRequestResult> requestDeskPhoneCode(
    int facilityId,
  ) => caller.callServerEndpoint<_ie9uc2bd.OtpRequestResult>(
    'claim',
    'requestDeskPhoneCode',
    {'facilityId': facilityId},
  );

  _ida.Future<_iy913k1i.ClaimRequest> submit(
    int facilityId,
    String contactName,
    List<String> documentPaths, {
    String? deskPhoneCode,
  }) => caller.callServerEndpoint<_iy913k1i.ClaimRequest>(
    'claim',
    'submit',
    {
      'facilityId': facilityId,
      'contactName': contactName,
      'documentPaths': documentPaths,
      'deskPhoneCode': deskPhoneCode,
    },
  );

  _ida.Future<List<_iy913k1i.ClaimRequest>> mine() =>
      caller.callServerEndpoint<List<_iy913k1i.ClaimRequest>>(
        'claim',
        'mine',
        {},
      );
}

/// {@category Endpoint}
class EndpointInvite extends _isc.EndpointRef {
  EndpointInvite(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invite';

  /// Hospital admins may invite desk staff. Field agents and platform admins
  /// may invite both roles.
  _ida.Future<_i9iib0sv.InviteCreated> create(
    int facilityId,
    _ibmnj6dm.UserRole role, {
    String? email,
  }) => caller.callServerEndpoint<_i9iib0sv.InviteCreated>(
    'invite',
    'create',
    {
      'facilityId': facilityId,
      'role': role,
      'email': email,
    },
  );

  /// Who may call: the facility's managers.
  _ida.Future<List<_iowxn2fh.FacilityInvite>> list(int facilityId) =>
      caller.callServerEndpoint<List<_iowxn2fh.FacilityInvite>>(
        'invite',
        'list',
        {'facilityId': facilityId},
      );

  /// Who may call: the facility's managers.
  _ida.Future<_iowxn2fh.FacilityInvite> revoke(int inviteId) =>
      caller.callServerEndpoint<_iowxn2fh.FacilityInvite>(
        'invite',
        'revoke',
        {'inviteId': inviteId},
      );

  /// Shows what an invite is for before signing in. Who may call: anyone.
  _ida.Future<_imqhjh1w.InvitePreview> preview(String code) =>
      caller.callServerEndpoint<_imqhjh1w.InvitePreview>(
        'invite',
        'preview',
        {'code': code},
      );

  /// Who may call: any signed-in user (the invite may be tied to a phone).
  _ida.Future<_idpsepmh.RoleAssignment> accept(String code) =>
      caller.callServerEndpoint<_idpsepmh.RoleAssignment>(
        'invite',
        'accept',
        {'code': code},
      );
}

/// Who may call: anyone. Rate limited per IP.
/// {@category Endpoint}
class EndpointJoinRequest extends _isc.EndpointRef {
  EndpointJoinRequest(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'joinRequest';

  _ida.Future<_iw37o6hv.JoinRequest> submit(
    String hospitalName,
    String contactName,
    String phone,
    String area, {
    String? message,
  }) => caller.callServerEndpoint<_iw37o6hv.JoinRequest>(
    'joinRequest',
    'submit',
    {
      'hospitalName': hospitalName,
      'contactName': contactName,
      'phone': phone,
      'area': area,
      'message': message,
    },
  );
}

/// {@category Endpoint}
class EndpointOnboarding extends _isc.EndpointRef {
  EndpointOnboarding(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'onboarding';

  /// The agent's assigned facilities. Who may call: field agents.
  _ida.Future<List<_i4l2530l.AgentFacility>> myFacilities({
    double? lat,
    double? lng,
  }) => caller.callServerEndpoint<List<_i4l2530l.AgentFacility>>(
    'onboarding',
    'myFacilities',
    {
      'lat': lat,
      'lng': lng,
    },
  );

  /// Who may call: the facility's managers.
  _ida.Future<_i12l59eb.GoLiveChecklist> checklist(int facilityId) =>
      caller.callServerEndpoint<_i12l59eb.GoLiveChecklist>(
        'onboarding',
        'checklist',
        {'facilityId': facilityId},
      );

  /// Who may call: the assigned field agent, platform admins.
  _ida.Future<_ibcfwqdd.Facility> setStage(
    int facilityId,
    _imd9hu5k.OnboardingStage stage, {
    String? note,
  }) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'onboarding',
    'setStage',
    {
      'facilityId': facilityId,
      'stage': stage,
      'note': note,
    },
  );

  /// Who may call: the assigned field agent, platform admins.
  _ida.Future<_idy003ld.OnboardingRecord> updateRecord(
    int facilityId, {
    String? notes,
    DateTime? nextActionAt,
  }) => caller.callServerEndpoint<_idy003ld.OnboardingRecord>(
    'onboarding',
    'updateRecord',
    {
      'facilityId': facilityId,
      'notes': notes,
      'nextActionAt': nextActionAt,
    },
  );

  /// Who may call: the assigned field agent, the facility's hospital admin.
  _ida.Future<_ibcfwqdd.Facility> submitForVerification(
    int facilityId, {
    String? notes,
  }) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'onboarding',
    'submitForVerification',
    {
      'facilityId': facilityId,
      'notes': notes,
    },
  );

  /// Sends a code to the desk phone. Who may call: the facility's managers.
  _ida.Future<_ie9uc2bd.OtpRequestResult> requestDeskPhoneCode(
    int facilityId,
  ) => caller.callServerEndpoint<_ie9uc2bd.OtpRequestResult>(
    'onboarding',
    'requestDeskPhoneCode',
    {'facilityId': facilityId},
  );

  /// Who may call: the facility's managers.
  _ida.Future<_ibcfwqdd.Facility> confirmDeskPhone(
    int facilityId,
    String code,
  ) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'onboarding',
    'confirmDeskPhone',
    {
      'facilityId': facilityId,
      'code': code,
    },
  );

  /// The agent called the desk and someone answered. Who may call: the
  /// assigned field agent.
  _ida.Future<_ibcfwqdd.Facility> recordTestCall(
    int facilityId, {
    String? note,
  }) => caller.callServerEndpoint<_ibcfwqdd.Facility>(
    'onboarding',
    'recordTestCall',
    {
      'facilityId': facilityId,
      'note': note,
    },
  );
}

/// {@category Endpoint}
class EndpointStaff extends _isc.EndpointRef {
  EndpointStaff(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'staff';

  /// Who may call: the facility's managers.
  _ida.Future<List<_ii3vg1nr.StaffMember>> list(int facilityId) =>
      caller.callServerEndpoint<List<_ii3vg1nr.StaffMember>>(
        'staff',
        'list',
        {'facilityId': facilityId},
      );

  /// Who may call: the facility's managers.
  _ida.Future<void> remove(
    int facilityId,
    int userId,
    _ibmnj6dm.UserRole role,
  ) => caller.callServerEndpoint<void>(
    'staff',
    'remove',
    {
      'facilityId': facilityId,
      'userId': userId,
      'role': role,
    },
  );
}

/// Who may call: anyone.
/// {@category Endpoint}
class EndpointFirstAid extends _isc.EndpointRef {
  EndpointFirstAid(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'firstAid';

  _ida.Future<List<_i7aojmz9.FirstAidCard>> cards() =>
      caller.callServerEndpoint<List<_i7aojmz9.FirstAidCard>>(
        'firstAid',
        'cards',
        {},
      );
}

/// The signed-in user's contacts, medical profile and data rights.
/// Who may call: any signed-in user, for their own data only.
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  _ida.Future<List<_iu611yjn.EmergencyContact>> contacts() =>
      caller.callServerEndpoint<List<_iu611yjn.EmergencyContact>>(
        'profile',
        'contacts',
        {},
      );

  _ida.Future<_iu611yjn.EmergencyContact> saveContact(
    _iu611yjn.EmergencyContact contact,
  ) => caller.callServerEndpoint<_iu611yjn.EmergencyContact>(
    'profile',
    'saveContact',
    {'contact': contact},
  );

  _ida.Future<void> deleteContact(int contactId) =>
      caller.callServerEndpoint<void>(
        'profile',
        'deleteContact',
        {'contactId': contactId},
      );

  _ida.Future<_icwufl9g.MedicalProfileData> medical() =>
      caller.callServerEndpoint<_icwufl9g.MedicalProfileData>(
        'profile',
        'medical',
        {},
      );

  _ida.Future<_icwufl9g.MedicalProfileData> saveMedical(
    _icwufl9g.MedicalProfileData data,
    bool consent,
  ) => caller.callServerEndpoint<_icwufl9g.MedicalProfileData>(
    'profile',
    'saveMedical',
    {
      'data': data,
      'consent': consent,
    },
  );

  _ida.Future<void> deleteMedical() => caller.callServerEndpoint<void>(
    'profile',
    'deleteMedical',
    {},
  );

  /// All personal data as JSON.
  _ida.Future<String> exportMyData() => caller.callServerEndpoint<String>(
    'profile',
    'exportMyData',
    {},
  );

  _ida.Future<void> deleteMyAccount() => caller.callServerEndpoint<void>(
    'profile',
    'deleteMyAccount',
    {},
  );
}

/// {@category Endpoint}
class EndpointStatus extends _isc.EndpointRef {
  EndpointStatus(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'status';

  /// Who may call: the facility's hospital admin and desk staff only.
  _ida.Future<_ikh3pjuy.FacilityStatus> update(
    int facilityId,
    _ic5rdr82.StatusInput input,
  ) => caller.callServerEndpoint<_ikh3pjuy.FacilityStatus>(
    'status',
    'update',
    {
      'facilityId': facilityId,
      'input': input,
    },
  );

  /// "Still accurate". Who may call: the facility's staff.
  _ida.Future<_ikh3pjuy.FacilityStatus> confirm(int facilityId) =>
      caller.callServerEndpoint<_ikh3pjuy.FacilityStatus>(
        'status',
        'confirm',
        {'facilityId': facilityId},
      );

  /// Who may call: the facility's staff.
  _ida.Future<_ikh3pjuy.FacilityStatus?> current(int facilityId) =>
      caller.callServerEndpoint<_ikh3pjuy.FacilityStatus?>(
        'status',
        'current',
        {'facilityId': facilityId},
      );

  /// Training mode. Who may call: the facility's staff and assigned agent.
  _ida.Future<void> practice(
    int facilityId,
    _ic5rdr82.StatusInput input,
  ) => caller.callServerEndpoint<void>(
    'status',
    'practice',
    {
      'facilityId': facilityId,
      'input': input,
    },
  );

  /// Who may call: the facility's staff, managers.
  _ida.Future<List<_i6yinprw.AuditEntry>> auditLog(
    int facilityId, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i6yinprw.AuditEntry>>(
    'status',
    'auditLog',
    {
      'facilityId': facilityId,
      'limit': limit,
      'offset': offset,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    admin = EndpointAdmin(this);
    assistant = EndpointAssistant(this);
    account = EndpointAccount(this);
    emergency = EndpointEmergency(this);
    document = EndpointDocument(this);
    facility = EndpointFacility(this);
    claim = EndpointClaim(this);
    invite = EndpointInvite(this);
    joinRequest = EndpointJoinRequest(this);
    onboarding = EndpointOnboarding(this);
    staff = EndpointStaff(this);
    firstAid = EndpointFirstAid(this);
    profile = EndpointProfile(this);
    status = EndpointStatus(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAdmin admin;

  late final EndpointAssistant assistant;

  late final EndpointAccount account;

  late final EndpointEmergency emergency;

  late final EndpointDocument document;

  late final EndpointFacility facility;

  late final EndpointClaim claim;

  late final EndpointInvite invite;

  late final EndpointJoinRequest joinRequest;

  late final EndpointOnboarding onboarding;

  late final EndpointStaff staff;

  late final EndpointFirstAid firstAid;

  late final EndpointProfile profile;

  late final EndpointStatus status;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'admin': admin,
    'assistant': assistant,
    'account': account,
    'emergency': emergency,
    'document': document,
    'facility': facility,
    'claim': claim,
    'invite': invite,
    'joinRequest': joinRequest,
    'onboarding': onboarding,
    'staff': staff,
    'firstAid': firstAid,
    'profile': profile,
    'status': status,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
