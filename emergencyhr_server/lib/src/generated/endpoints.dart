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
import 'dart:typed_data' as _idt;
import 'package:emergencyhr_server/src/generated/features/admin/models/facility_import_row.dart'
    as _ijbyy5tt;
import 'package:emergencyhr_server/src/generated/features/auth/models/user_role.dart'
    as _ijg5vzn8;
import 'package:emergencyhr_server/src/generated/features/emergency/models/emergency_action.dart'
    as _i1o2kj5x;
import 'package:emergencyhr_server/src/generated/features/emergency/models/emergency_type.dart'
    as _i5d26921;
import 'package:emergencyhr_server/src/generated/features/facilities/models/document_kind.dart'
    as _ikyy3g9e;
import 'package:emergencyhr_server/src/generated/features/facilities/models/facility_profile_input.dart'
    as _iw5b0z0o;
import 'package:emergencyhr_server/src/generated/features/facilities/models/onboarding_stage.dart'
    as _ic7x89it;
import 'package:emergencyhr_server/src/generated/features/onboarding/models/claim_status.dart'
    as _inxbvse6;
import 'package:emergencyhr_server/src/generated/features/onboarding/models/join_request_status.dart'
    as _i1gqxm9l;
import 'package:emergencyhr_server/src/generated/features/profile/models/emergency_contact.dart'
    as _in56got1;
import 'package:emergencyhr_server/src/generated/features/profile/models/medical_profile_data.dart'
    as _ikei1cv9;
import 'package:emergencyhr_server/src/generated/features/status/models/status_input.dart'
    as _idur43kt;
import 'package:emergencyhr_server/src/generated/future_calls.dart'
    as _ivh67sjw;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../features/admin/admin_endpoint.dart' as _i7xoxkop;
import '../features/assistant/assistant_endpoint.dart' as _i82valcs;
import '../features/auth/account_endpoint.dart' as _i38ty4yj;
import '../features/emergency/emergency_endpoint.dart' as _i1y4c3vh;
import '../features/facilities/document_endpoint.dart' as _iyhpnwj1;
import '../features/facilities/facility_endpoint.dart' as _icukadel;
import '../features/onboarding/claim_endpoint.dart' as _ikm7jvkd;
import '../features/onboarding/invite_endpoint.dart' as _ixb2ed39;
import '../features/onboarding/join_request_endpoint.dart' as _ivjmmce8;
import '../features/onboarding/onboarding_endpoint.dart' as _ify2xuof;
import '../features/onboarding/staff_endpoint.dart' as _i162w4na;
import '../features/profile/first_aid_endpoint.dart' as _iuv1rm65;
import '../features/profile/profile_endpoint.dart' as _iohh3cg0;
import '../features/status/status_endpoint.dart' as _iwwegfni;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'admin': _i7xoxkop.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'assistant': _i82valcs.AssistantEndpoint()
        ..initialize(
          server,
          'assistant',
          null,
        ),
      'account': _i38ty4yj.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'emergency': _i1y4c3vh.EmergencyEndpoint()
        ..initialize(
          server,
          'emergency',
          null,
        ),
      'document': _iyhpnwj1.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'facility': _icukadel.FacilityEndpoint()
        ..initialize(
          server,
          'facility',
          null,
        ),
      'claim': _ikm7jvkd.ClaimEndpoint()
        ..initialize(
          server,
          'claim',
          null,
        ),
      'invite': _ixb2ed39.InviteEndpoint()
        ..initialize(
          server,
          'invite',
          null,
        ),
      'joinRequest': _ivjmmce8.JoinRequestEndpoint()
        ..initialize(
          server,
          'joinRequest',
          null,
        ),
      'onboarding': _ify2xuof.OnboardingEndpoint()
        ..initialize(
          server,
          'onboarding',
          null,
        ),
      'staff': _i162w4na.StaffEndpoint()
        ..initialize(
          server,
          'staff',
          null,
        ),
      'firstAid': _iuv1rm65.FirstAidEndpoint()
        ..initialize(
          server,
          'firstAid',
          null,
        ),
      'profile': _iohh3cg0.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'status': _iwwegfni.StatusEndpoint()
        ..initialize(
          server,
          'status',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'verificationQueue': _is.MethodConnector(
          name: 'verificationQueue',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .verificationQueue(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'approve': _is.MethodConnector(
          name: 'approve',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).approve(
                    session,
                    params['facilityId'],
                  ),
        ),
        'verifyListing': _is.MethodConnector(
          name: 'verifyListing',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).verifyListing(
                    session,
                    params['facilityId'],
                  ),
        ),
        'importFacilities': _is.MethodConnector(
          name: 'importFacilities',
          params: {
            'rows': _is.ParameterDescription(
              name: 'rows',
              type: _is.getType<List<_ijbyy5tt.FacilityImportRow>>(),
              nullable: false,
            ),
            'dryRun': _is.ParameterDescription(
              name: 'dryRun',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .importFacilities(
                    session,
                    params['rows'],
                    dryRun: params['dryRun'],
                  ),
        ),
        'reject': _is.MethodConnector(
          name: 'reject',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint).reject(
                session,
                params['facilityId'],
                params['reason'],
              ),
        ),
        'directory': _is.MethodConnector(
          name: 'directory',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'area': _is.ParameterDescription(
              name: 'area',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'stage': _is.ParameterDescription(
              name: 'stage',
              type: _is.getType<_ic7x89it.OnboardingStage?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).directory(
                    session,
                    query: params['query'],
                    area: params['area'],
                    stage: params['stage'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'pipeline': _is.MethodConnector(
          name: 'pipeline',
          params: {
            'area': _is.ParameterDescription(
              name: 'area',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'agentUserId': _is.ParameterDescription(
              name: 'agentUserId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).pipeline(
                    session,
                    area: params['area'],
                    agentUserId: params['agentUserId'],
                  ),
        ),
        'assignAgent': _is.MethodConnector(
          name: 'assignAgent',
          params: {
            'facilityIds': _is.ParameterDescription(
              name: 'facilityIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
            'agentUserId': _is.ParameterDescription(
              name: 'agentUserId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).assignAgent(
                    session,
                    params['facilityIds'],
                    params['agentUserId'],
                  ),
        ),
        'claims': _is.MethodConnector(
          name: 'claims',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_inxbvse6.ClaimStatus>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint).claims(
                session,
                status: params['status'],
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
        'approveClaim': _is.MethodConnector(
          name: 'approveClaim',
          params: {
            'claimId': _is.ParameterDescription(
              name: 'claimId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).approveClaim(
                    session,
                    params['claimId'],
                  ),
        ),
        'rejectClaim': _is.MethodConnector(
          name: 'rejectClaim',
          params: {
            'claimId': _is.ParameterDescription(
              name: 'claimId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).rejectClaim(
                    session,
                    params['claimId'],
                    params['reason'],
                  ),
        ),
        'joinRequests': _is.MethodConnector(
          name: 'joinRequests',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_i1gqxm9l.JoinRequestStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).joinRequests(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'setJoinRequestStatus': _is.MethodConnector(
          name: 'setJoinRequestStatus',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_i1gqxm9l.JoinRequestStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .setJoinRequestStatus(
                    session,
                    params['requestId'],
                    params['status'],
                  ),
        ),
        'convertJoinRequest': _is.MethodConnector(
          name: 'convertJoinRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'agentUserId': _is.ParameterDescription(
              name: 'agentUserId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .convertJoinRequest(
                    session,
                    params['requestId'],
                    params['agentUserId'],
                    params['lat'],
                    params['lng'],
                    params['address'],
                  ),
        ),
        'agents': _is.MethodConnector(
          name: 'agents',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint).agents(
                session,
              ),
        ),
        'addAgent': _is.MethodConnector(
          name: 'addAgent',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'areas': _is.ParameterDescription(
              name: 'areas',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).addAgent(
                    session,
                    params['email'],
                    params['areas'],
                  ),
        ),
        'setAgentAreas': _is.MethodConnector(
          name: 'setAgentAreas',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'areas': _is.ParameterDescription(
              name: 'areas',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).setAgentAreas(
                    session,
                    params['userId'],
                    params['areas'],
                  ),
        ),
        'deactivateAgent': _is.MethodConnector(
          name: 'deactivateAgent',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .deactivateAgent(
                    session,
                    params['userId'],
                  ),
        ),
        'freshness': _is.MethodConnector(
          name: 'freshness',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).freshness(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'reports': _is.MethodConnector(
          name: 'reports',
          params: {
            'onlyFlagged': _is.ParameterDescription(
              name: 'onlyFlagged',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).reports(
                    session,
                    onlyFlagged: params['onlyFlagged'],
                  ),
        ),
        'reviewReports': _is.MethodConnector(
          name: 'reviewReports',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i7xoxkop.AdminEndpoint).reviewReports(
                    session,
                    params['facilityId'],
                    note: params['note'],
                  ),
        ),
        'metrics': _is.MethodConnector(
          name: 'metrics',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .metrics(session),
        ),
        'newHospitals': _is.MethodConnector(
          name: 'newHospitals',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .newHospitals(session),
        ),
        'setFacilitySuspended': _is.MethodConnector(
          name: 'setFacilitySuspended',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'suspended': _is.ParameterDescription(
              name: 'suspended',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .setFacilitySuspended(
                    session,
                    params['facilityId'],
                    params['suspended'],
                    params['reason'],
                  ),
        ),
        'users': _is.MethodConnector(
          name: 'users',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint).users(
                session,
                query: params['query'],
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
        'setUserSuspended': _is.MethodConnector(
          name: 'setUserSuspended',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'suspended': _is.ParameterDescription(
              name: 'suspended',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i7xoxkop.AdminEndpoint)
                  .setUserSuspended(
                    session,
                    params['userId'],
                    params['suspended'],
                    params['reason'],
                  ),
        ),
      },
    );
    connectors['assistant'] = _is.EndpointConnector(
      name: 'assistant',
      endpoint: endpoints['assistant']!,
      methodConnectors: {
        'conversations': _is.MethodConnector(
          name: 'conversations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assistant'] as _i82valcs.AssistantEndpoint)
                  .conversations(session),
        ),
        'messages': _is.MethodConnector(
          name: 'messages',
          params: {
            'conversationId': _is.ParameterDescription(
              name: 'conversationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assistant'] as _i82valcs.AssistantEndpoint)
                  .messages(
                    session,
                    params['conversationId'],
                  ),
        ),
        'deleteConversation': _is.MethodConnector(
          name: 'deleteConversation',
          params: {
            'conversationId': _is.ParameterDescription(
              name: 'conversationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assistant'] as _i82valcs.AssistantEndpoint)
                  .deleteConversation(
                    session,
                    params['conversationId'],
                  ),
        ),
        'deleteAllConversations': _is.MethodConnector(
          name: 'deleteAllConversations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['assistant'] as _i82valcs.AssistantEndpoint)
                  .deleteAllConversations(session),
        ),
        'send': _is.MethodStreamConnector(
          name: 'send',
          params: {
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'conversationId': _is.ParameterDescription(
              name: 'conversationId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['assistant'] as _i82valcs.AssistantEndpoint).send(
                session,
                params['message'],
                conversationId: params['conversationId'],
              ),
        ),
      },
    );
    connectors['account'] = _is.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i38ty4yj.AccountEndpoint).me(
                session,
              ),
        ),
        'updatePhone': _is.MethodConnector(
          name: 'updatePhone',
          params: {
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i38ty4yj.AccountEndpoint)
                  .updatePhone(
                    session,
                    params['phone'],
                  ),
        ),
        'updateName': _is.MethodConnector(
          name: 'updateName',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _i38ty4yj.AccountEndpoint)
                  .updateName(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['emergency'] = _is.EndpointConnector(
      name: 'emergency',
      endpoint: endpoints['emergency']!,
      methodConnectors: {
        'start': _is.MethodConnector(
          name: 'start',
          params: {
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<_i5d26921.EmergencyType>(),
              nullable: false,
            ),
            'area': _is.ParameterDescription(
              name: 'area',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'tappedAt': _is.ParameterDescription(
              name: 'tappedAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint).start(
                    session,
                    params['lat'],
                    params['lng'],
                    params['type'],
                    area: params['area'],
                    tappedAt: params['tappedAt'],
                  ),
        ),
        'refresh': _is.MethodConnector(
          name: 'refresh',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint)
                  .refresh(
                    session,
                    params['sessionId'],
                    params['accessToken'],
                  ),
        ),
        'updateSearch': _is.MethodConnector(
          name: 'updateSearch',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<_i5d26921.EmergencyType>(),
              nullable: false,
            ),
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'area': _is.ParameterDescription(
              name: 'area',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint)
                  .updateSearch(
                    session,
                    params['sessionId'],
                    params['accessToken'],
                    params['type'],
                    lat: params['lat'],
                    lng: params['lng'],
                    area: params['area'],
                  ),
        ),
        'recordAction': _is.MethodConnector(
          name: 'recordAction',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'action': _is.ParameterDescription(
              name: 'action',
              type: _is.getType<_i1o2kj5x.EmergencyAction>(),
              nullable: false,
            ),
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint)
                  .recordAction(
                    session,
                    params['sessionId'],
                    params['accessToken'],
                    params['action'],
                    facilityId: params['facilityId'],
                  ),
        ),
        'reportWrongStatus': _is.MethodConnector(
          name: 'reportWrongStatus',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint)
                  .reportWrongStatus(
                    session,
                    params['sessionId'],
                    params['accessToken'],
                    params['facilityId'],
                    params['reason'],
                  ),
        ),
        'notifyFamily': _is.MethodConnector(
          name: 'notifyFamily',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint)
                  .notifyFamily(
                    session,
                    params['sessionId'],
                    params['accessToken'],
                  ),
        ),
        'facility': _is.MethodConnector(
          name: 'facility',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint)
                  .facility(
                    session,
                    params['facilityId'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) =>
                  (endpoints['emergency'] as _i1y4c3vh.EmergencyEndpoint).watch(
                    session,
                    params['sessionId'],
                    params['accessToken'],
                  ),
        ),
      },
    );
    connectors['document'] = _is.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'createUpload': _is.MethodConnector(
          name: 'createUpload',
          params: {
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _iyhpnwj1.DocumentEndpoint)
                  .createUpload(
                    session,
                    params['fileName'],
                    facilityId: params['facilityId'],
                  ),
        ),
        'upload': _is.MethodConnector(
          name: 'upload',
          params: {
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<_ikyy3g9e.DocumentKind>(),
              nullable: false,
            ),
            'bytes': _is.ParameterDescription(
              name: 'bytes',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _iyhpnwj1.DocumentEndpoint).upload(
                    session,
                    params['fileName'],
                    params['kind'],
                    params['bytes'],
                    facilityId: params['facilityId'],
                  ),
        ),
        'confirmUpload': _is.MethodConnector(
          name: 'confirmUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<_ikyy3g9e.DocumentKind>(),
              nullable: false,
            ),
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _iyhpnwj1.DocumentEndpoint)
                  .confirmUpload(
                    session,
                    params['path'],
                    params['kind'],
                    facilityId: params['facilityId'],
                  ),
        ),
        'download': _is.MethodConnector(
          name: 'download',
          params: {
            'documentId': _is.ParameterDescription(
              name: 'documentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _iyhpnwj1.DocumentEndpoint)
                  .download(
                    session,
                    params['documentId'],
                  ),
        ),
      },
    );
    connectors['facility'] = _is.EndpointConnector(
      name: 'facility',
      endpoint: endpoints['facility']!,
      methodConnectors: {
        'search': _is.MethodConnector(
          name: 'search',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'area': _is.ParameterDescription(
              name: 'area',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['facility'] as _icukadel.FacilityEndpoint).search(
                    session,
                    params['query'],
                    area: params['area'],
                  ),
        ),
        'nearby': _is.MethodConnector(
          name: 'nearby',
          params: {
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['facility'] as _icukadel.FacilityEndpoint).nearby(
                    session,
                    params['lat'],
                    params['lng'],
                  ),
        ),
        'findDuplicates': _is.MethodConnector(
          name: 'findDuplicates',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['facility'] as _icukadel.FacilityEndpoint)
                  .findDuplicates(
                    session,
                    params['name'],
                    params['lat'],
                    params['lng'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_iw5b0z0o.FacilityProfileInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['facility'] as _icukadel.FacilityEndpoint).create(
                    session,
                    params['input'],
                  ),
        ),
        'updateProfile': _is.MethodConnector(
          name: 'updateProfile',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_iw5b0z0o.FacilityProfileInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['facility'] as _icukadel.FacilityEndpoint)
                  .updateProfile(
                    session,
                    params['facilityId'],
                    params['input'],
                  ),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['facility'] as _icukadel.FacilityEndpoint).detail(
                    session,
                    params['facilityId'],
                  ),
        ),
      },
    );
    connectors['claim'] = _is.EndpointConnector(
      name: 'claim',
      endpoint: endpoints['claim']!,
      methodConnectors: {
        'requestDeskPhoneCode': _is.MethodConnector(
          name: 'requestDeskPhoneCode',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['claim'] as _ikm7jvkd.ClaimEndpoint)
                  .requestDeskPhoneCode(
                    session,
                    params['facilityId'],
                  ),
        ),
        'submit': _is.MethodConnector(
          name: 'submit',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'contactName': _is.ParameterDescription(
              name: 'contactName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'documentPaths': _is.ParameterDescription(
              name: 'documentPaths',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'deskPhoneCode': _is.ParameterDescription(
              name: 'deskPhoneCode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['claim'] as _ikm7jvkd.ClaimEndpoint).submit(
                session,
                params['facilityId'],
                params['contactName'],
                params['documentPaths'],
                deskPhoneCode: params['deskPhoneCode'],
              ),
        ),
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['claim'] as _ikm7jvkd.ClaimEndpoint).mine(session),
        ),
      },
    );
    connectors['invite'] = _is.EndpointConnector(
      name: 'invite',
      endpoint: endpoints['invite']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_ijg5vzn8.UserRole>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invite'] as _ixb2ed39.InviteEndpoint).create(
                    session,
                    params['facilityId'],
                    params['role'],
                    email: params['email'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invite'] as _ixb2ed39.InviteEndpoint).list(
                session,
                params['facilityId'],
              ),
        ),
        'revoke': _is.MethodConnector(
          name: 'revoke',
          params: {
            'inviteId': _is.ParameterDescription(
              name: 'inviteId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invite'] as _ixb2ed39.InviteEndpoint).revoke(
                    session,
                    params['inviteId'],
                  ),
        ),
        'preview': _is.MethodConnector(
          name: 'preview',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invite'] as _ixb2ed39.InviteEndpoint).preview(
                    session,
                    params['code'],
                  ),
        ),
        'accept': _is.MethodConnector(
          name: 'accept',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invite'] as _ixb2ed39.InviteEndpoint).accept(
                    session,
                    params['code'],
                  ),
        ),
      },
    );
    connectors['joinRequest'] = _is.EndpointConnector(
      name: 'joinRequest',
      endpoint: endpoints['joinRequest']!,
      methodConnectors: {
        'submit': _is.MethodConnector(
          name: 'submit',
          params: {
            'hospitalName': _is.ParameterDescription(
              name: 'hospitalName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'contactName': _is.ParameterDescription(
              name: 'contactName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'area': _is.ParameterDescription(
              name: 'area',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['joinRequest'] as _ivjmmce8.JoinRequestEndpoint)
                      .submit(
                        session,
                        params['hospitalName'],
                        params['contactName'],
                        params['phone'],
                        params['area'],
                        message: params['message'],
                      ),
        ),
      },
    );
    connectors['onboarding'] = _is.EndpointConnector(
      name: 'onboarding',
      endpoint: endpoints['onboarding']!,
      methodConnectors: {
        'myFacilities': _is.MethodConnector(
          name: 'myFacilities',
          params: {
            'lat': _is.ParameterDescription(
              name: 'lat',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'lng': _is.ParameterDescription(
              name: 'lng',
              type: _is.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .myFacilities(
                        session,
                        lat: params['lat'],
                        lng: params['lng'],
                      ),
        ),
        'checklist': _is.MethodConnector(
          name: 'checklist',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .checklist(
                        session,
                        params['facilityId'],
                      ),
        ),
        'setStage': _is.MethodConnector(
          name: 'setStage',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stage': _is.ParameterDescription(
              name: 'stage',
              type: _is.getType<_ic7x89it.OnboardingStage>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .setStage(
                        session,
                        params['facilityId'],
                        params['stage'],
                        note: params['note'],
                      ),
        ),
        'updateRecord': _is.MethodConnector(
          name: 'updateRecord',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'nextActionAt': _is.ParameterDescription(
              name: 'nextActionAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .updateRecord(
                        session,
                        params['facilityId'],
                        notes: params['notes'],
                        nextActionAt: params['nextActionAt'],
                      ),
        ),
        'submitForVerification': _is.MethodConnector(
          name: 'submitForVerification',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .submitForVerification(
                        session,
                        params['facilityId'],
                        notes: params['notes'],
                      ),
        ),
        'requestDeskPhoneCode': _is.MethodConnector(
          name: 'requestDeskPhoneCode',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .requestDeskPhoneCode(
                        session,
                        params['facilityId'],
                      ),
        ),
        'confirmDeskPhone': _is.MethodConnector(
          name: 'confirmDeskPhone',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .confirmDeskPhone(
                        session,
                        params['facilityId'],
                        params['code'],
                      ),
        ),
        'recordTestCall': _is.MethodConnector(
          name: 'recordTestCall',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['onboarding'] as _ify2xuof.OnboardingEndpoint)
                      .recordTestCall(
                        session,
                        params['facilityId'],
                        note: params['note'],
                      ),
        ),
      },
    );
    connectors['staff'] = _is.EndpointConnector(
      name: 'staff',
      endpoint: endpoints['staff']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['staff'] as _i162w4na.StaffEndpoint).list(
                session,
                params['facilityId'],
              ),
        ),
        'remove': _is.MethodConnector(
          name: 'remove',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_ijg5vzn8.UserRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['staff'] as _i162w4na.StaffEndpoint).remove(
                session,
                params['facilityId'],
                params['userId'],
                params['role'],
              ),
        ),
      },
    );
    connectors['firstAid'] = _is.EndpointConnector(
      name: 'firstAid',
      endpoint: endpoints['firstAid']!,
      methodConnectors: {
        'cards': _is.MethodConnector(
          name: 'cards',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firstAid'] as _iuv1rm65.FirstAidEndpoint)
                  .cards(session),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'contacts': _is.MethodConnector(
          name: 'contacts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .contacts(session),
        ),
        'saveContact': _is.MethodConnector(
          name: 'saveContact',
          params: {
            'contact': _is.ParameterDescription(
              name: 'contact',
              type: _is.getType<_in56got1.EmergencyContact>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .saveContact(
                    session,
                    params['contact'],
                  ),
        ),
        'deleteContact': _is.MethodConnector(
          name: 'deleteContact',
          params: {
            'contactId': _is.ParameterDescription(
              name: 'contactId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .deleteContact(
                    session,
                    params['contactId'],
                  ),
        ),
        'medical': _is.MethodConnector(
          name: 'medical',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .medical(session),
        ),
        'saveMedical': _is.MethodConnector(
          name: 'saveMedical',
          params: {
            'data': _is.ParameterDescription(
              name: 'data',
              type: _is.getType<_ikei1cv9.MedicalProfileData>(),
              nullable: false,
            ),
            'consent': _is.ParameterDescription(
              name: 'consent',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .saveMedical(
                    session,
                    params['data'],
                    params['consent'],
                  ),
        ),
        'deleteMedical': _is.MethodConnector(
          name: 'deleteMedical',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .deleteMedical(session),
        ),
        'exportMyData': _is.MethodConnector(
          name: 'exportMyData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .exportMyData(session),
        ),
        'deleteMyAccount': _is.MethodConnector(
          name: 'deleteMyAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _iohh3cg0.ProfileEndpoint)
                  .deleteMyAccount(session),
        ),
      },
    );
    connectors['status'] = _is.EndpointConnector(
      name: 'status',
      endpoint: endpoints['status']!,
      methodConnectors: {
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_idur43kt.StatusInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['status'] as _iwwegfni.StatusEndpoint).update(
                    session,
                    params['facilityId'],
                    params['input'],
                  ),
        ),
        'confirm': _is.MethodConnector(
          name: 'confirm',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['status'] as _iwwegfni.StatusEndpoint).confirm(
                    session,
                    params['facilityId'],
                  ),
        ),
        'current': _is.MethodConnector(
          name: 'current',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['status'] as _iwwegfni.StatusEndpoint).current(
                    session,
                    params['facilityId'],
                  ),
        ),
        'practice': _is.MethodConnector(
          name: 'practice',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_idur43kt.StatusInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['status'] as _iwwegfni.StatusEndpoint).practice(
                    session,
                    params['facilityId'],
                    params['input'],
                  ),
        ),
        'auditLog': _is.MethodConnector(
          name: 'auditLog',
          params: {
            'facilityId': _is.ParameterDescription(
              name: 'facilityId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['status'] as _iwwegfni.StatusEndpoint).auditLog(
                    session,
                    params['facilityId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ivh67sjw.FutureCalls();
  }
}
