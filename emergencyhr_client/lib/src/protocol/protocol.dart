/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:emergencyhr_client/src/protocol/features/admin/models/agent_row.dart'
    as _i3t6hodj;
import 'package:emergencyhr_client/src/protocol/features/admin/models/claim_queue_item.dart'
    as _ib27qxyi;
import 'package:emergencyhr_client/src/protocol/features/admin/models/directory_row.dart'
    as _ilxv0wae;
import 'package:emergencyhr_client/src/protocol/features/admin/models/facility_import_row.dart'
    as _ifhgg7r5;
import 'package:emergencyhr_client/src/protocol/features/admin/models/freshness_row.dart'
    as _ik1xr38l;
import 'package:emergencyhr_client/src/protocol/features/admin/models/new_hospital_row.dart'
    as _ia6kw2vn;
import 'package:emergencyhr_client/src/protocol/features/admin/models/report_row.dart'
    as _i2zx97wu;
import 'package:emergencyhr_client/src/protocol/features/admin/models/user_row.dart'
    as _ij7c6bnu;
import 'package:emergencyhr_client/src/protocol/features/admin/models/verification_item.dart'
    as _ip6f1g6g;
import 'package:emergencyhr_client/src/protocol/features/assistant/models/ai_conversation.dart'
    as _ihn3q5hk;
import 'package:emergencyhr_client/src/protocol/features/assistant/models/chat_message_view.dart'
    as _irdvths1;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/duplicate_candidate.dart'
    as _i6bzf55j;
import 'package:emergencyhr_client/src/protocol/features/facilities/models/facility_search_result.dart'
    as _i7vk8exb;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/agent_facility.dart'
    as _i4l2530l;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/claim_request.dart'
    as _iy913k1i;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/facility_invite.dart'
    as _iowxn2fh;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/join_request.dart'
    as _iw37o6hv;
import 'package:emergencyhr_client/src/protocol/features/onboarding/models/staff_member.dart'
    as _ii3vg1nr;
import 'package:emergencyhr_client/src/protocol/features/profile/models/emergency_contact.dart'
    as _iu611yjn;
import 'package:emergencyhr_client/src/protocol/features/profile/models/first_aid_card.dart'
    as _i7aojmz9;
import 'package:emergencyhr_client/src/protocol/features/status/models/audit_entry.dart'
    as _i6yinprw;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'core/errors/app_error_code.dart' as _i4wtqx69;
import 'core/errors/conflict_exception.dart' as _i5epujyq;
import 'core/errors/invalid_state_exception.dart' as _if76hjxg;
import 'core/errors/not_authorized_exception.dart' as _id4j2cxo;
import 'core/errors/not_found_exception.dart' as _ixeh2c1z;
import 'core/errors/rate_limited_exception.dart' as _i5xzqpwc;
import 'core/errors/validation_exception.dart' as _io4t73gt;
import 'features/admin/models/admin_action_log.dart' as _id7ceaki;
import 'features/admin/models/agent_row.dart' as _iqju4b7m;
import 'features/admin/models/claim_queue_item.dart' as _i0snb6d6;
import 'features/admin/models/directory_row.dart' as _i54iiwsn;
import 'features/admin/models/facility_import_row.dart' as _ivyrrl9n;
import 'features/admin/models/facility_import_summary.dart' as _imphx5bj;
import 'features/admin/models/freshness_row.dart' as _id7thq0e;
import 'features/admin/models/new_hospital_row.dart' as _iq76skmt;
import 'features/admin/models/pipeline_board.dart' as _ivdreakr;
import 'features/admin/models/pipeline_row.dart' as _i3my1wkz;
import 'features/admin/models/platform_metrics.dart' as _ipvg0e5e;
import 'features/admin/models/report_row.dart' as _ilt9vmc8;
import 'features/admin/models/stage_count.dart' as _ie7pd3y5;
import 'features/admin/models/user_row.dart' as _irro0t1q;
import 'features/admin/models/verification_item.dart' as _is6wk0uj;
import 'features/assistant/models/ai_conversation.dart' as _im1lo42e;
import 'features/assistant/models/ai_message.dart' as _i60vlas3;
import 'features/assistant/models/chat_event.dart' as _iylcg5z2;
import 'features/assistant/models/chat_event_kind.dart' as _iezvwzp2;
import 'features/assistant/models/chat_message_view.dart' as _itf6z0wu;
import 'features/assistant/models/chat_role.dart' as _izjqdijg;
import 'features/auth/models/app_user.dart' as _i1uex9mj;
import 'features/auth/models/current_user.dart' as _inw81056;
import 'features/auth/models/otp_purpose.dart' as _isgq0pqt;
import 'features/auth/models/otp_request_result.dart' as _i4xeafvz;
import 'features/auth/models/role_assignment.dart' as _icv3d9my;
import 'features/auth/models/user_role.dart' as _ibzm4nkn;
import 'features/doctors/models/consultation.dart' as _ixl0qkip;
import 'features/doctors/models/consultation_status.dart' as _iz4df293;
import 'features/doctors/models/doctor_availability.dart' as _i36nxywn;
import 'features/doctors/models/doctor_profile.dart' as _isdduwtg;
import 'features/doctors/models/payment.dart' as _iwiaqbkd;
import 'features/doctors/models/payment_status.dart' as _imww6den;
import 'features/doctors/models/payout.dart' as _ioanksgy;
import 'features/doctors/models/payout_status.dart' as _iqydhu29;
import 'features/emergency/models/capability_match.dart' as _ia2dm2ho;
import 'features/emergency/models/emergency_action.dart' as _iahprb34;
import 'features/emergency/models/emergency_result.dart' as _i71ihctq;
import 'features/emergency/models/emergency_search.dart' as _ijkcj45d;
import 'features/emergency/models/emergency_session.dart' as _iotcqzr9;
import 'features/emergency/models/emergency_type.dart' as _ivcyj7k2;
import 'features/emergency/models/public_facility.dart' as _irwpf0tc;
import 'features/emergency/models/status_report.dart' as _iw6bfsfn;
import 'features/facilities/models/capability.dart' as _i8rvay2d;
import 'features/facilities/models/document_kind.dart' as _ikxpuibo;
import 'features/facilities/models/duplicate_candidate.dart' as _i79uvhsa;
import 'features/facilities/models/facility.dart' as _i1h3x911;
import 'features/facilities/models/facility_capability.dart' as _ixr3kk26;
import 'features/facilities/models/facility_detail.dart' as _iqdib9ab;
import 'features/facilities/models/facility_document.dart' as _i6urljsq;
import 'features/facilities/models/facility_profile_input.dart' as _iaay8q9z;
import 'features/facilities/models/facility_search_result.dart' as _irz2ysl3;
import 'features/facilities/models/facility_source.dart' as _icg7am50;
import 'features/facilities/models/facility_summary.dart' as _if8rrn88;
import 'features/facilities/models/facility_type.dart' as _ify8mon7;
import 'features/facilities/models/onboarding_stage.dart' as _i9lfcknc;
import 'features/facilities/models/opening_hours.dart' as _iuy7y9n1;
import 'features/facilities/models/opening_period.dart' as _ilazmsmc;
import 'features/facilities/models/upload_ticket.dart' as _iewoplrh;
import 'features/facilities/models/verification_status.dart' as _ilit88m4;
import 'features/onboarding/models/agent_facility.dart' as _ijsmpu5o;
import 'features/onboarding/models/checklist_item.dart' as _iudox9w5;
import 'features/onboarding/models/checklist_key.dart' as _invn6987;
import 'features/onboarding/models/claim_request.dart' as _i3lx31x8;
import 'features/onboarding/models/claim_status.dart' as _itk14vm7;
import 'features/onboarding/models/facility_invite.dart' as _it22gnmn;
import 'features/onboarding/models/field_agent_area.dart' as _inaz8u2w;
import 'features/onboarding/models/go_live_checklist.dart' as _inbb6zej;
import 'features/onboarding/models/invite_created.dart' as _it6a6dpx;
import 'features/onboarding/models/invite_preview.dart' as _ifovzbin;
import 'features/onboarding/models/join_request.dart' as _i98mrfo7;
import 'features/onboarding/models/join_request_status.dart' as _ilxmbwht;
import 'features/onboarding/models/onboarding_event.dart' as _idsjolhr;
import 'features/onboarding/models/onboarding_record.dart' as _iwakl52j;
import 'features/onboarding/models/staff_member.dart' as _i586qht0;
import 'features/profile/models/contact_alert_result.dart' as _iyulom36;
import 'features/profile/models/contact_channel.dart' as _iqbywrkt;
import 'features/profile/models/emergency_contact.dart' as _i1uqog83;
import 'features/profile/models/family_alert_result.dart' as _ipb37m2v;
import 'features/profile/models/first_aid_card.dart' as _iz9u6gbp;
import 'features/profile/models/medical_profile_data.dart' as _i6w06m19;
import 'features/status/models/audit_entry.dart' as _i3thy5dm;
import 'features/status/models/facility_status.dart' as _iqjk2hc4;
import 'features/status/models/facility_status_changed.dart' as _i1gorcse;
import 'features/status/models/freshness_tier.dart' as _itvk3dud;
import 'features/status/models/status_change_log.dart' as _ijeqxb1v;
import 'features/status/models/status_input.dart' as _iv1sb3gj;
export 'core/errors/app_error_code.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/invalid_state_exception.dart';
export 'core/errors/not_authorized_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/rate_limited_exception.dart';
export 'core/errors/validation_exception.dart';
export 'features/admin/models/admin_action_log.dart';
export 'features/admin/models/agent_row.dart';
export 'features/admin/models/claim_queue_item.dart';
export 'features/admin/models/directory_row.dart';
export 'features/admin/models/facility_import_row.dart';
export 'features/admin/models/facility_import_summary.dart';
export 'features/admin/models/freshness_row.dart';
export 'features/admin/models/new_hospital_row.dart';
export 'features/admin/models/pipeline_board.dart';
export 'features/admin/models/pipeline_row.dart';
export 'features/admin/models/platform_metrics.dart';
export 'features/admin/models/report_row.dart';
export 'features/admin/models/stage_count.dart';
export 'features/admin/models/user_row.dart';
export 'features/admin/models/verification_item.dart';
export 'features/assistant/models/ai_conversation.dart';
export 'features/assistant/models/ai_message.dart';
export 'features/assistant/models/chat_event.dart';
export 'features/assistant/models/chat_event_kind.dart';
export 'features/assistant/models/chat_message_view.dart';
export 'features/assistant/models/chat_role.dart';
export 'features/auth/models/app_user.dart';
export 'features/auth/models/current_user.dart';
export 'features/auth/models/otp_purpose.dart';
export 'features/auth/models/otp_request_result.dart';
export 'features/auth/models/role_assignment.dart';
export 'features/auth/models/user_role.dart';
export 'features/doctors/models/consultation.dart';
export 'features/doctors/models/consultation_status.dart';
export 'features/doctors/models/doctor_availability.dart';
export 'features/doctors/models/doctor_profile.dart';
export 'features/doctors/models/payment.dart';
export 'features/doctors/models/payment_status.dart';
export 'features/doctors/models/payout.dart';
export 'features/doctors/models/payout_status.dart';
export 'features/emergency/models/capability_match.dart';
export 'features/emergency/models/emergency_action.dart';
export 'features/emergency/models/emergency_result.dart';
export 'features/emergency/models/emergency_search.dart';
export 'features/emergency/models/emergency_session.dart';
export 'features/emergency/models/emergency_type.dart';
export 'features/emergency/models/public_facility.dart';
export 'features/emergency/models/status_report.dart';
export 'features/facilities/models/capability.dart';
export 'features/facilities/models/document_kind.dart';
export 'features/facilities/models/duplicate_candidate.dart';
export 'features/facilities/models/facility.dart';
export 'features/facilities/models/facility_capability.dart';
export 'features/facilities/models/facility_detail.dart';
export 'features/facilities/models/facility_document.dart';
export 'features/facilities/models/facility_profile_input.dart';
export 'features/facilities/models/facility_search_result.dart';
export 'features/facilities/models/facility_source.dart';
export 'features/facilities/models/facility_summary.dart';
export 'features/facilities/models/facility_type.dart';
export 'features/facilities/models/onboarding_stage.dart';
export 'features/facilities/models/opening_hours.dart';
export 'features/facilities/models/opening_period.dart';
export 'features/facilities/models/upload_ticket.dart';
export 'features/facilities/models/verification_status.dart';
export 'features/onboarding/models/agent_facility.dart';
export 'features/onboarding/models/checklist_item.dart';
export 'features/onboarding/models/checklist_key.dart';
export 'features/onboarding/models/claim_request.dart';
export 'features/onboarding/models/claim_status.dart';
export 'features/onboarding/models/facility_invite.dart';
export 'features/onboarding/models/field_agent_area.dart';
export 'features/onboarding/models/go_live_checklist.dart';
export 'features/onboarding/models/invite_created.dart';
export 'features/onboarding/models/invite_preview.dart';
export 'features/onboarding/models/join_request.dart';
export 'features/onboarding/models/join_request_status.dart';
export 'features/onboarding/models/onboarding_event.dart';
export 'features/onboarding/models/onboarding_record.dart';
export 'features/onboarding/models/staff_member.dart';
export 'features/profile/models/contact_alert_result.dart';
export 'features/profile/models/contact_channel.dart';
export 'features/profile/models/emergency_contact.dart';
export 'features/profile/models/family_alert_result.dart';
export 'features/profile/models/first_aid_card.dart';
export 'features/profile/models/medical_profile_data.dart';
export 'features/status/models/audit_entry.dart';
export 'features/status/models/facility_status.dart';
export 'features/status/models/facility_status_changed.dart';
export 'features/status/models/freshness_tier.dart';
export 'features/status/models/status_change_log.dart';
export 'features/status/models/status_input.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i4wtqx69.AppErrorCode) {
      return _i4wtqx69.AppErrorCode.fromJson(data) as T;
    }
    if (t == _i5epujyq.ConflictException) {
      return _i5epujyq.ConflictException.fromJson(data) as T;
    }
    if (t == _if76hjxg.InvalidStateException) {
      return _if76hjxg.InvalidStateException.fromJson(data) as T;
    }
    if (t == _id4j2cxo.NotAuthorizedException) {
      return _id4j2cxo.NotAuthorizedException.fromJson(data) as T;
    }
    if (t == _ixeh2c1z.NotFoundException) {
      return _ixeh2c1z.NotFoundException.fromJson(data) as T;
    }
    if (t == _i5xzqpwc.RateLimitedException) {
      return _i5xzqpwc.RateLimitedException.fromJson(data) as T;
    }
    if (t == _io4t73gt.ValidationException) {
      return _io4t73gt.ValidationException.fromJson(data) as T;
    }
    if (t == _id7ceaki.AdminActionLog) {
      return _id7ceaki.AdminActionLog.fromJson(data) as T;
    }
    if (t == _iqju4b7m.AgentRow) {
      return _iqju4b7m.AgentRow.fromJson(data) as T;
    }
    if (t == _i0snb6d6.ClaimQueueItem) {
      return _i0snb6d6.ClaimQueueItem.fromJson(data) as T;
    }
    if (t == _i54iiwsn.DirectoryRow) {
      return _i54iiwsn.DirectoryRow.fromJson(data) as T;
    }
    if (t == _ivyrrl9n.FacilityImportRow) {
      return _ivyrrl9n.FacilityImportRow.fromJson(data) as T;
    }
    if (t == _imphx5bj.FacilityImportSummary) {
      return _imphx5bj.FacilityImportSummary.fromJson(data) as T;
    }
    if (t == _id7thq0e.FreshnessRow) {
      return _id7thq0e.FreshnessRow.fromJson(data) as T;
    }
    if (t == _iq76skmt.NewHospitalRow) {
      return _iq76skmt.NewHospitalRow.fromJson(data) as T;
    }
    if (t == _ivdreakr.PipelineBoard) {
      return _ivdreakr.PipelineBoard.fromJson(data) as T;
    }
    if (t == _i3my1wkz.PipelineRow) {
      return _i3my1wkz.PipelineRow.fromJson(data) as T;
    }
    if (t == _ipvg0e5e.PlatformMetrics) {
      return _ipvg0e5e.PlatformMetrics.fromJson(data) as T;
    }
    if (t == _ilt9vmc8.ReportRow) {
      return _ilt9vmc8.ReportRow.fromJson(data) as T;
    }
    if (t == _ie7pd3y5.StageCount) {
      return _ie7pd3y5.StageCount.fromJson(data) as T;
    }
    if (t == _irro0t1q.UserRow) {
      return _irro0t1q.UserRow.fromJson(data) as T;
    }
    if (t == _is6wk0uj.VerificationItem) {
      return _is6wk0uj.VerificationItem.fromJson(data) as T;
    }
    if (t == _im1lo42e.AiConversation) {
      return _im1lo42e.AiConversation.fromJson(data) as T;
    }
    if (t == _i60vlas3.AiMessage) {
      return _i60vlas3.AiMessage.fromJson(data) as T;
    }
    if (t == _iylcg5z2.ChatEvent) {
      return _iylcg5z2.ChatEvent.fromJson(data) as T;
    }
    if (t == _iezvwzp2.ChatEventKind) {
      return _iezvwzp2.ChatEventKind.fromJson(data) as T;
    }
    if (t == _itf6z0wu.ChatMessageView) {
      return _itf6z0wu.ChatMessageView.fromJson(data) as T;
    }
    if (t == _izjqdijg.ChatRole) {
      return _izjqdijg.ChatRole.fromJson(data) as T;
    }
    if (t == _i1uex9mj.AppUser) {
      return _i1uex9mj.AppUser.fromJson(data) as T;
    }
    if (t == _inw81056.CurrentUser) {
      return _inw81056.CurrentUser.fromJson(data) as T;
    }
    if (t == _isgq0pqt.OtpPurpose) {
      return _isgq0pqt.OtpPurpose.fromJson(data) as T;
    }
    if (t == _i4xeafvz.OtpRequestResult) {
      return _i4xeafvz.OtpRequestResult.fromJson(data) as T;
    }
    if (t == _icv3d9my.RoleAssignment) {
      return _icv3d9my.RoleAssignment.fromJson(data) as T;
    }
    if (t == _ibzm4nkn.UserRole) {
      return _ibzm4nkn.UserRole.fromJson(data) as T;
    }
    if (t == _ixl0qkip.Consultation) {
      return _ixl0qkip.Consultation.fromJson(data) as T;
    }
    if (t == _iz4df293.ConsultationStatus) {
      return _iz4df293.ConsultationStatus.fromJson(data) as T;
    }
    if (t == _i36nxywn.DoctorAvailability) {
      return _i36nxywn.DoctorAvailability.fromJson(data) as T;
    }
    if (t == _isdduwtg.DoctorProfile) {
      return _isdduwtg.DoctorProfile.fromJson(data) as T;
    }
    if (t == _iwiaqbkd.Payment) {
      return _iwiaqbkd.Payment.fromJson(data) as T;
    }
    if (t == _imww6den.PaymentStatus) {
      return _imww6den.PaymentStatus.fromJson(data) as T;
    }
    if (t == _ioanksgy.Payout) {
      return _ioanksgy.Payout.fromJson(data) as T;
    }
    if (t == _iqydhu29.PayoutStatus) {
      return _iqydhu29.PayoutStatus.fromJson(data) as T;
    }
    if (t == _ia2dm2ho.CapabilityMatch) {
      return _ia2dm2ho.CapabilityMatch.fromJson(data) as T;
    }
    if (t == _iahprb34.EmergencyAction) {
      return _iahprb34.EmergencyAction.fromJson(data) as T;
    }
    if (t == _i71ihctq.EmergencyResult) {
      return _i71ihctq.EmergencyResult.fromJson(data) as T;
    }
    if (t == _ijkcj45d.EmergencySearch) {
      return _ijkcj45d.EmergencySearch.fromJson(data) as T;
    }
    if (t == _iotcqzr9.EmergencySession) {
      return _iotcqzr9.EmergencySession.fromJson(data) as T;
    }
    if (t == _ivcyj7k2.EmergencyType) {
      return _ivcyj7k2.EmergencyType.fromJson(data) as T;
    }
    if (t == _irwpf0tc.PublicFacility) {
      return _irwpf0tc.PublicFacility.fromJson(data) as T;
    }
    if (t == _iw6bfsfn.StatusReport) {
      return _iw6bfsfn.StatusReport.fromJson(data) as T;
    }
    if (t == _i8rvay2d.Capability) {
      return _i8rvay2d.Capability.fromJson(data) as T;
    }
    if (t == _ikxpuibo.DocumentKind) {
      return _ikxpuibo.DocumentKind.fromJson(data) as T;
    }
    if (t == _i79uvhsa.DuplicateCandidate) {
      return _i79uvhsa.DuplicateCandidate.fromJson(data) as T;
    }
    if (t == _i1h3x911.Facility) {
      return _i1h3x911.Facility.fromJson(data) as T;
    }
    if (t == _ixr3kk26.FacilityCapability) {
      return _ixr3kk26.FacilityCapability.fromJson(data) as T;
    }
    if (t == _iqdib9ab.FacilityDetail) {
      return _iqdib9ab.FacilityDetail.fromJson(data) as T;
    }
    if (t == _i6urljsq.FacilityDocument) {
      return _i6urljsq.FacilityDocument.fromJson(data) as T;
    }
    if (t == _iaay8q9z.FacilityProfileInput) {
      return _iaay8q9z.FacilityProfileInput.fromJson(data) as T;
    }
    if (t == _irz2ysl3.FacilitySearchResult) {
      return _irz2ysl3.FacilitySearchResult.fromJson(data) as T;
    }
    if (t == _icg7am50.FacilitySource) {
      return _icg7am50.FacilitySource.fromJson(data) as T;
    }
    if (t == _if8rrn88.FacilitySummary) {
      return _if8rrn88.FacilitySummary.fromJson(data) as T;
    }
    if (t == _ify8mon7.FacilityType) {
      return _ify8mon7.FacilityType.fromJson(data) as T;
    }
    if (t == _i9lfcknc.OnboardingStage) {
      return _i9lfcknc.OnboardingStage.fromJson(data) as T;
    }
    if (t == _iuy7y9n1.OpeningHours) {
      return _iuy7y9n1.OpeningHours.fromJson(data) as T;
    }
    if (t == _ilazmsmc.OpeningPeriod) {
      return _ilazmsmc.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _iewoplrh.UploadTicket) {
      return _iewoplrh.UploadTicket.fromJson(data) as T;
    }
    if (t == _ilit88m4.VerificationStatus) {
      return _ilit88m4.VerificationStatus.fromJson(data) as T;
    }
    if (t == _ijsmpu5o.AgentFacility) {
      return _ijsmpu5o.AgentFacility.fromJson(data) as T;
    }
    if (t == _iudox9w5.ChecklistItem) {
      return _iudox9w5.ChecklistItem.fromJson(data) as T;
    }
    if (t == _invn6987.ChecklistKey) {
      return _invn6987.ChecklistKey.fromJson(data) as T;
    }
    if (t == _i3lx31x8.ClaimRequest) {
      return _i3lx31x8.ClaimRequest.fromJson(data) as T;
    }
    if (t == _itk14vm7.ClaimStatus) {
      return _itk14vm7.ClaimStatus.fromJson(data) as T;
    }
    if (t == _it22gnmn.FacilityInvite) {
      return _it22gnmn.FacilityInvite.fromJson(data) as T;
    }
    if (t == _inaz8u2w.FieldAgentArea) {
      return _inaz8u2w.FieldAgentArea.fromJson(data) as T;
    }
    if (t == _inbb6zej.GoLiveChecklist) {
      return _inbb6zej.GoLiveChecklist.fromJson(data) as T;
    }
    if (t == _it6a6dpx.InviteCreated) {
      return _it6a6dpx.InviteCreated.fromJson(data) as T;
    }
    if (t == _ifovzbin.InvitePreview) {
      return _ifovzbin.InvitePreview.fromJson(data) as T;
    }
    if (t == _i98mrfo7.JoinRequest) {
      return _i98mrfo7.JoinRequest.fromJson(data) as T;
    }
    if (t == _ilxmbwht.JoinRequestStatus) {
      return _ilxmbwht.JoinRequestStatus.fromJson(data) as T;
    }
    if (t == _idsjolhr.OnboardingEvent) {
      return _idsjolhr.OnboardingEvent.fromJson(data) as T;
    }
    if (t == _iwakl52j.OnboardingRecord) {
      return _iwakl52j.OnboardingRecord.fromJson(data) as T;
    }
    if (t == _i586qht0.StaffMember) {
      return _i586qht0.StaffMember.fromJson(data) as T;
    }
    if (t == _iyulom36.ContactAlertResult) {
      return _iyulom36.ContactAlertResult.fromJson(data) as T;
    }
    if (t == _iqbywrkt.ContactChannel) {
      return _iqbywrkt.ContactChannel.fromJson(data) as T;
    }
    if (t == _i1uqog83.EmergencyContact) {
      return _i1uqog83.EmergencyContact.fromJson(data) as T;
    }
    if (t == _ipb37m2v.FamilyAlertResult) {
      return _ipb37m2v.FamilyAlertResult.fromJson(data) as T;
    }
    if (t == _iz9u6gbp.FirstAidCard) {
      return _iz9u6gbp.FirstAidCard.fromJson(data) as T;
    }
    if (t == _i6w06m19.MedicalProfileData) {
      return _i6w06m19.MedicalProfileData.fromJson(data) as T;
    }
    if (t == _i3thy5dm.AuditEntry) {
      return _i3thy5dm.AuditEntry.fromJson(data) as T;
    }
    if (t == _iqjk2hc4.FacilityStatus) {
      return _iqjk2hc4.FacilityStatus.fromJson(data) as T;
    }
    if (t == _i1gorcse.FacilityStatusChanged) {
      return _i1gorcse.FacilityStatusChanged.fromJson(data) as T;
    }
    if (t == _itvk3dud.FreshnessTier) {
      return _itvk3dud.FreshnessTier.fromJson(data) as T;
    }
    if (t == _ijeqxb1v.StatusChangeLog) {
      return _ijeqxb1v.StatusChangeLog.fromJson(data) as T;
    }
    if (t == _iv1sb3gj.StatusInput) {
      return _iv1sb3gj.StatusInput.fromJson(data) as T;
    }
    if (t == _isc.getType<_i4wtqx69.AppErrorCode?>()) {
      return (data != null ? _i4wtqx69.AppErrorCode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5epujyq.ConflictException?>()) {
      return (data != null ? _i5epujyq.ConflictException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_if76hjxg.InvalidStateException?>()) {
      return (data != null
              ? _if76hjxg.InvalidStateException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_id4j2cxo.NotAuthorizedException?>()) {
      return (data != null
              ? _id4j2cxo.NotAuthorizedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixeh2c1z.NotFoundException?>()) {
      return (data != null ? _ixeh2c1z.NotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5xzqpwc.RateLimitedException?>()) {
      return (data != null
              ? _i5xzqpwc.RateLimitedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_io4t73gt.ValidationException?>()) {
      return (data != null
              ? _io4t73gt.ValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_id7ceaki.AdminActionLog?>()) {
      return (data != null ? _id7ceaki.AdminActionLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqju4b7m.AgentRow?>()) {
      return (data != null ? _iqju4b7m.AgentRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0snb6d6.ClaimQueueItem?>()) {
      return (data != null ? _i0snb6d6.ClaimQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i54iiwsn.DirectoryRow?>()) {
      return (data != null ? _i54iiwsn.DirectoryRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivyrrl9n.FacilityImportRow?>()) {
      return (data != null ? _ivyrrl9n.FacilityImportRow.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imphx5bj.FacilityImportSummary?>()) {
      return (data != null
              ? _imphx5bj.FacilityImportSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_id7thq0e.FreshnessRow?>()) {
      return (data != null ? _id7thq0e.FreshnessRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iq76skmt.NewHospitalRow?>()) {
      return (data != null ? _iq76skmt.NewHospitalRow.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivdreakr.PipelineBoard?>()) {
      return (data != null ? _ivdreakr.PipelineBoard.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3my1wkz.PipelineRow?>()) {
      return (data != null ? _i3my1wkz.PipelineRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipvg0e5e.PlatformMetrics?>()) {
      return (data != null ? _ipvg0e5e.PlatformMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ilt9vmc8.ReportRow?>()) {
      return (data != null ? _ilt9vmc8.ReportRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ie7pd3y5.StageCount?>()) {
      return (data != null ? _ie7pd3y5.StageCount.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irro0t1q.UserRow?>()) {
      return (data != null ? _irro0t1q.UserRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_is6wk0uj.VerificationItem?>()) {
      return (data != null ? _is6wk0uj.VerificationItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_im1lo42e.AiConversation?>()) {
      return (data != null ? _im1lo42e.AiConversation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i60vlas3.AiMessage?>()) {
      return (data != null ? _i60vlas3.AiMessage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iylcg5z2.ChatEvent?>()) {
      return (data != null ? _iylcg5z2.ChatEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iezvwzp2.ChatEventKind?>()) {
      return (data != null ? _iezvwzp2.ChatEventKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_itf6z0wu.ChatMessageView?>()) {
      return (data != null ? _itf6z0wu.ChatMessageView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izjqdijg.ChatRole?>()) {
      return (data != null ? _izjqdijg.ChatRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1uex9mj.AppUser?>()) {
      return (data != null ? _i1uex9mj.AppUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inw81056.CurrentUser?>()) {
      return (data != null ? _inw81056.CurrentUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isgq0pqt.OtpPurpose?>()) {
      return (data != null ? _isgq0pqt.OtpPurpose.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4xeafvz.OtpRequestResult?>()) {
      return (data != null ? _i4xeafvz.OtpRequestResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icv3d9my.RoleAssignment?>()) {
      return (data != null ? _icv3d9my.RoleAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibzm4nkn.UserRole?>()) {
      return (data != null ? _ibzm4nkn.UserRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixl0qkip.Consultation?>()) {
      return (data != null ? _ixl0qkip.Consultation.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iz4df293.ConsultationStatus?>()) {
      return (data != null ? _iz4df293.ConsultationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i36nxywn.DoctorAvailability?>()) {
      return (data != null ? _i36nxywn.DoctorAvailability.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isdduwtg.DoctorProfile?>()) {
      return (data != null ? _isdduwtg.DoctorProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iwiaqbkd.Payment?>()) {
      return (data != null ? _iwiaqbkd.Payment.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imww6den.PaymentStatus?>()) {
      return (data != null ? _imww6den.PaymentStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ioanksgy.Payout?>()) {
      return (data != null ? _ioanksgy.Payout.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqydhu29.PayoutStatus?>()) {
      return (data != null ? _iqydhu29.PayoutStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ia2dm2ho.CapabilityMatch?>()) {
      return (data != null ? _ia2dm2ho.CapabilityMatch.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iahprb34.EmergencyAction?>()) {
      return (data != null ? _iahprb34.EmergencyAction.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i71ihctq.EmergencyResult?>()) {
      return (data != null ? _i71ihctq.EmergencyResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijkcj45d.EmergencySearch?>()) {
      return (data != null ? _ijkcj45d.EmergencySearch.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iotcqzr9.EmergencySession?>()) {
      return (data != null ? _iotcqzr9.EmergencySession.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivcyj7k2.EmergencyType?>()) {
      return (data != null ? _ivcyj7k2.EmergencyType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irwpf0tc.PublicFacility?>()) {
      return (data != null ? _irwpf0tc.PublicFacility.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iw6bfsfn.StatusReport?>()) {
      return (data != null ? _iw6bfsfn.StatusReport.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8rvay2d.Capability?>()) {
      return (data != null ? _i8rvay2d.Capability.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikxpuibo.DocumentKind?>()) {
      return (data != null ? _ikxpuibo.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i79uvhsa.DuplicateCandidate?>()) {
      return (data != null ? _i79uvhsa.DuplicateCandidate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1h3x911.Facility?>()) {
      return (data != null ? _i1h3x911.Facility.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixr3kk26.FacilityCapability?>()) {
      return (data != null ? _ixr3kk26.FacilityCapability.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqdib9ab.FacilityDetail?>()) {
      return (data != null ? _iqdib9ab.FacilityDetail.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6urljsq.FacilityDocument?>()) {
      return (data != null ? _i6urljsq.FacilityDocument.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iaay8q9z.FacilityProfileInput?>()) {
      return (data != null
              ? _iaay8q9z.FacilityProfileInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_irz2ysl3.FacilitySearchResult?>()) {
      return (data != null
              ? _irz2ysl3.FacilitySearchResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_icg7am50.FacilitySource?>()) {
      return (data != null ? _icg7am50.FacilitySource.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_if8rrn88.FacilitySummary?>()) {
      return (data != null ? _if8rrn88.FacilitySummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ify8mon7.FacilityType?>()) {
      return (data != null ? _ify8mon7.FacilityType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9lfcknc.OnboardingStage?>()) {
      return (data != null ? _i9lfcknc.OnboardingStage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iuy7y9n1.OpeningHours?>()) {
      return (data != null ? _iuy7y9n1.OpeningHours.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilazmsmc.OpeningPeriod?>()) {
      return (data != null ? _ilazmsmc.OpeningPeriod.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iewoplrh.UploadTicket?>()) {
      return (data != null ? _iewoplrh.UploadTicket.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilit88m4.VerificationStatus?>()) {
      return (data != null ? _ilit88m4.VerificationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijsmpu5o.AgentFacility?>()) {
      return (data != null ? _ijsmpu5o.AgentFacility.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iudox9w5.ChecklistItem?>()) {
      return (data != null ? _iudox9w5.ChecklistItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_invn6987.ChecklistKey?>()) {
      return (data != null ? _invn6987.ChecklistKey.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3lx31x8.ClaimRequest?>()) {
      return (data != null ? _i3lx31x8.ClaimRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itk14vm7.ClaimStatus?>()) {
      return (data != null ? _itk14vm7.ClaimStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it22gnmn.FacilityInvite?>()) {
      return (data != null ? _it22gnmn.FacilityInvite.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inaz8u2w.FieldAgentArea?>()) {
      return (data != null ? _inaz8u2w.FieldAgentArea.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inbb6zej.GoLiveChecklist?>()) {
      return (data != null ? _inbb6zej.GoLiveChecklist.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_it6a6dpx.InviteCreated?>()) {
      return (data != null ? _it6a6dpx.InviteCreated.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifovzbin.InvitePreview?>()) {
      return (data != null ? _ifovzbin.InvitePreview.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i98mrfo7.JoinRequest?>()) {
      return (data != null ? _i98mrfo7.JoinRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilxmbwht.JoinRequestStatus?>()) {
      return (data != null ? _ilxmbwht.JoinRequestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idsjolhr.OnboardingEvent?>()) {
      return (data != null ? _idsjolhr.OnboardingEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iwakl52j.OnboardingRecord?>()) {
      return (data != null ? _iwakl52j.OnboardingRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i586qht0.StaffMember?>()) {
      return (data != null ? _i586qht0.StaffMember.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyulom36.ContactAlertResult?>()) {
      return (data != null ? _iyulom36.ContactAlertResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqbywrkt.ContactChannel?>()) {
      return (data != null ? _iqbywrkt.ContactChannel.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1uqog83.EmergencyContact?>()) {
      return (data != null ? _i1uqog83.EmergencyContact.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipb37m2v.FamilyAlertResult?>()) {
      return (data != null ? _ipb37m2v.FamilyAlertResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iz9u6gbp.FirstAidCard?>()) {
      return (data != null ? _iz9u6gbp.FirstAidCard.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6w06m19.MedicalProfileData?>()) {
      return (data != null ? _i6w06m19.MedicalProfileData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3thy5dm.AuditEntry?>()) {
      return (data != null ? _i3thy5dm.AuditEntry.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqjk2hc4.FacilityStatus?>()) {
      return (data != null ? _iqjk2hc4.FacilityStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1gorcse.FacilityStatusChanged?>()) {
      return (data != null
              ? _i1gorcse.FacilityStatusChanged.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_itvk3dud.FreshnessTier?>()) {
      return (data != null ? _itvk3dud.FreshnessTier.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijeqxb1v.StatusChangeLog?>()) {
      return (data != null ? _ijeqxb1v.StatusChangeLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iv1sb3gj.StatusInput?>()) {
      return (data != null ? _iv1sb3gj.StatusInput.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ie7pd3y5.StageCount>) {
      return (data as List)
              .map((e) => deserialize<_ie7pd3y5.StageCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i3my1wkz.PipelineRow>) {
      return (data as List)
              .map((e) => deserialize<_i3my1wkz.PipelineRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ibzm4nkn.UserRole>) {
      return (data as List)
              .map((e) => deserialize<_ibzm4nkn.UserRole>(e))
              .toList()
          as T;
    }
    if (t == List<_i6urljsq.FacilityDocument>) {
      return (data as List)
              .map((e) => deserialize<_i6urljsq.FacilityDocument>(e))
              .toList()
          as T;
    }
    if (t == List<_icv3d9my.RoleAssignment>) {
      return (data as List)
              .map((e) => deserialize<_icv3d9my.RoleAssignment>(e))
              .toList()
          as T;
    }
    if (t == List<_if8rrn88.FacilitySummary>) {
      return (data as List)
              .map((e) => deserialize<_if8rrn88.FacilitySummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i8rvay2d.Capability>) {
      return (data as List)
              .map((e) => deserialize<_i8rvay2d.Capability>(e))
              .toList()
          as T;
    }
    if (t == List<_i71ihctq.EmergencyResult>) {
      return (data as List)
              .map((e) => deserialize<_i71ihctq.EmergencyResult>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ilazmsmc.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_ilazmsmc.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_iudox9w5.ChecklistItem>) {
      return (data as List)
              .map((e) => deserialize<_iudox9w5.ChecklistItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iyulom36.ContactAlertResult>) {
      return (data as List)
              .map((e) => deserialize<_iyulom36.ContactAlertResult>(e))
              .toList()
          as T;
    }
    if (t == List<_ip6f1g6g.VerificationItem>) {
      return (data as List)
              .map((e) => deserialize<_ip6f1g6g.VerificationItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ifhgg7r5.FacilityImportRow>) {
      return (data as List)
              .map((e) => deserialize<_ifhgg7r5.FacilityImportRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ilxv0wae.DirectoryRow>) {
      return (data as List)
              .map((e) => deserialize<_ilxv0wae.DirectoryRow>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ib27qxyi.ClaimQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_ib27qxyi.ClaimQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iw37o6hv.JoinRequest>) {
      return (data as List)
              .map((e) => deserialize<_iw37o6hv.JoinRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i3t6hodj.AgentRow>) {
      return (data as List)
              .map((e) => deserialize<_i3t6hodj.AgentRow>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ik1xr38l.FreshnessRow>) {
      return (data as List)
              .map((e) => deserialize<_ik1xr38l.FreshnessRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i2zx97wu.ReportRow>) {
      return (data as List)
              .map((e) => deserialize<_i2zx97wu.ReportRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ia6kw2vn.NewHospitalRow>) {
      return (data as List)
              .map((e) => deserialize<_ia6kw2vn.NewHospitalRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ij7c6bnu.UserRow>) {
      return (data as List)
              .map((e) => deserialize<_ij7c6bnu.UserRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ihn3q5hk.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_ihn3q5hk.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_irdvths1.ChatMessageView>) {
      return (data as List)
              .map((e) => deserialize<_irdvths1.ChatMessageView>(e))
              .toList()
          as T;
    }
    if (t == List<_i7vk8exb.FacilitySearchResult>) {
      return (data as List)
              .map((e) => deserialize<_i7vk8exb.FacilitySearchResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i6bzf55j.DuplicateCandidate>) {
      return (data as List)
              .map((e) => deserialize<_i6bzf55j.DuplicateCandidate>(e))
              .toList()
          as T;
    }
    if (t == List<_iy913k1i.ClaimRequest>) {
      return (data as List)
              .map((e) => deserialize<_iy913k1i.ClaimRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_iowxn2fh.FacilityInvite>) {
      return (data as List)
              .map((e) => deserialize<_iowxn2fh.FacilityInvite>(e))
              .toList()
          as T;
    }
    if (t == List<_i4l2530l.AgentFacility>) {
      return (data as List)
              .map((e) => deserialize<_i4l2530l.AgentFacility>(e))
              .toList()
          as T;
    }
    if (t == List<_ii3vg1nr.StaffMember>) {
      return (data as List)
              .map((e) => deserialize<_ii3vg1nr.StaffMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i7aojmz9.FirstAidCard>) {
      return (data as List)
              .map((e) => deserialize<_i7aojmz9.FirstAidCard>(e))
              .toList()
          as T;
    }
    if (t == List<_iu611yjn.EmergencyContact>) {
      return (data as List)
              .map((e) => deserialize<_iu611yjn.EmergencyContact>(e))
              .toList()
          as T;
    }
    if (t == List<_i6yinprw.AuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i6yinprw.AuditEntry>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i4wtqx69.AppErrorCode => 'AppErrorCode',
      _i5epujyq.ConflictException => 'ConflictException',
      _if76hjxg.InvalidStateException => 'InvalidStateException',
      _id4j2cxo.NotAuthorizedException => 'NotAuthorizedException',
      _ixeh2c1z.NotFoundException => 'NotFoundException',
      _i5xzqpwc.RateLimitedException => 'RateLimitedException',
      _io4t73gt.ValidationException => 'ValidationException',
      _id7ceaki.AdminActionLog => 'AdminActionLog',
      _iqju4b7m.AgentRow => 'AgentRow',
      _i0snb6d6.ClaimQueueItem => 'ClaimQueueItem',
      _i54iiwsn.DirectoryRow => 'DirectoryRow',
      _ivyrrl9n.FacilityImportRow => 'FacilityImportRow',
      _imphx5bj.FacilityImportSummary => 'FacilityImportSummary',
      _id7thq0e.FreshnessRow => 'FreshnessRow',
      _iq76skmt.NewHospitalRow => 'NewHospitalRow',
      _ivdreakr.PipelineBoard => 'PipelineBoard',
      _i3my1wkz.PipelineRow => 'PipelineRow',
      _ipvg0e5e.PlatformMetrics => 'PlatformMetrics',
      _ilt9vmc8.ReportRow => 'ReportRow',
      _ie7pd3y5.StageCount => 'StageCount',
      _irro0t1q.UserRow => 'UserRow',
      _is6wk0uj.VerificationItem => 'VerificationItem',
      _im1lo42e.AiConversation => 'AiConversation',
      _i60vlas3.AiMessage => 'AiMessage',
      _iylcg5z2.ChatEvent => 'ChatEvent',
      _iezvwzp2.ChatEventKind => 'ChatEventKind',
      _itf6z0wu.ChatMessageView => 'ChatMessageView',
      _izjqdijg.ChatRole => 'ChatRole',
      _i1uex9mj.AppUser => 'AppUser',
      _inw81056.CurrentUser => 'CurrentUser',
      _isgq0pqt.OtpPurpose => 'OtpPurpose',
      _i4xeafvz.OtpRequestResult => 'OtpRequestResult',
      _icv3d9my.RoleAssignment => 'RoleAssignment',
      _ibzm4nkn.UserRole => 'UserRole',
      _ixl0qkip.Consultation => 'Consultation',
      _iz4df293.ConsultationStatus => 'ConsultationStatus',
      _i36nxywn.DoctorAvailability => 'DoctorAvailability',
      _isdduwtg.DoctorProfile => 'DoctorProfile',
      _iwiaqbkd.Payment => 'Payment',
      _imww6den.PaymentStatus => 'PaymentStatus',
      _ioanksgy.Payout => 'Payout',
      _iqydhu29.PayoutStatus => 'PayoutStatus',
      _ia2dm2ho.CapabilityMatch => 'CapabilityMatch',
      _iahprb34.EmergencyAction => 'EmergencyAction',
      _i71ihctq.EmergencyResult => 'EmergencyResult',
      _ijkcj45d.EmergencySearch => 'EmergencySearch',
      _iotcqzr9.EmergencySession => 'EmergencySession',
      _ivcyj7k2.EmergencyType => 'EmergencyType',
      _irwpf0tc.PublicFacility => 'PublicFacility',
      _iw6bfsfn.StatusReport => 'StatusReport',
      _i8rvay2d.Capability => 'Capability',
      _ikxpuibo.DocumentKind => 'DocumentKind',
      _i79uvhsa.DuplicateCandidate => 'DuplicateCandidate',
      _i1h3x911.Facility => 'Facility',
      _ixr3kk26.FacilityCapability => 'FacilityCapability',
      _iqdib9ab.FacilityDetail => 'FacilityDetail',
      _i6urljsq.FacilityDocument => 'FacilityDocument',
      _iaay8q9z.FacilityProfileInput => 'FacilityProfileInput',
      _irz2ysl3.FacilitySearchResult => 'FacilitySearchResult',
      _icg7am50.FacilitySource => 'FacilitySource',
      _if8rrn88.FacilitySummary => 'FacilitySummary',
      _ify8mon7.FacilityType => 'FacilityType',
      _i9lfcknc.OnboardingStage => 'OnboardingStage',
      _iuy7y9n1.OpeningHours => 'OpeningHours',
      _ilazmsmc.OpeningPeriod => 'OpeningPeriod',
      _iewoplrh.UploadTicket => 'UploadTicket',
      _ilit88m4.VerificationStatus => 'VerificationStatus',
      _ijsmpu5o.AgentFacility => 'AgentFacility',
      _iudox9w5.ChecklistItem => 'ChecklistItem',
      _invn6987.ChecklistKey => 'ChecklistKey',
      _i3lx31x8.ClaimRequest => 'ClaimRequest',
      _itk14vm7.ClaimStatus => 'ClaimStatus',
      _it22gnmn.FacilityInvite => 'FacilityInvite',
      _inaz8u2w.FieldAgentArea => 'FieldAgentArea',
      _inbb6zej.GoLiveChecklist => 'GoLiveChecklist',
      _it6a6dpx.InviteCreated => 'InviteCreated',
      _ifovzbin.InvitePreview => 'InvitePreview',
      _i98mrfo7.JoinRequest => 'JoinRequest',
      _ilxmbwht.JoinRequestStatus => 'JoinRequestStatus',
      _idsjolhr.OnboardingEvent => 'OnboardingEvent',
      _iwakl52j.OnboardingRecord => 'OnboardingRecord',
      _i586qht0.StaffMember => 'StaffMember',
      _iyulom36.ContactAlertResult => 'ContactAlertResult',
      _iqbywrkt.ContactChannel => 'ContactChannel',
      _i1uqog83.EmergencyContact => 'EmergencyContact',
      _ipb37m2v.FamilyAlertResult => 'FamilyAlertResult',
      _iz9u6gbp.FirstAidCard => 'FirstAidCard',
      _i6w06m19.MedicalProfileData => 'MedicalProfileData',
      _i3thy5dm.AuditEntry => 'AuditEntry',
      _iqjk2hc4.FacilityStatus => 'FacilityStatus',
      _i1gorcse.FacilityStatusChanged => 'FacilityStatusChanged',
      _itvk3dud.FreshnessTier => 'FreshnessTier',
      _ijeqxb1v.StatusChangeLog => 'StatusChangeLog',
      _iv1sb3gj.StatusInput => 'StatusInput',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('emergencyhr.', '');
    }

    switch (data) {
      case _i4wtqx69.AppErrorCode():
        return 'AppErrorCode';
      case _i5epujyq.ConflictException():
        return 'ConflictException';
      case _if76hjxg.InvalidStateException():
        return 'InvalidStateException';
      case _id4j2cxo.NotAuthorizedException():
        return 'NotAuthorizedException';
      case _ixeh2c1z.NotFoundException():
        return 'NotFoundException';
      case _i5xzqpwc.RateLimitedException():
        return 'RateLimitedException';
      case _io4t73gt.ValidationException():
        return 'ValidationException';
      case _id7ceaki.AdminActionLog():
        return 'AdminActionLog';
      case _iqju4b7m.AgentRow():
        return 'AgentRow';
      case _i0snb6d6.ClaimQueueItem():
        return 'ClaimQueueItem';
      case _i54iiwsn.DirectoryRow():
        return 'DirectoryRow';
      case _ivyrrl9n.FacilityImportRow():
        return 'FacilityImportRow';
      case _imphx5bj.FacilityImportSummary():
        return 'FacilityImportSummary';
      case _id7thq0e.FreshnessRow():
        return 'FreshnessRow';
      case _iq76skmt.NewHospitalRow():
        return 'NewHospitalRow';
      case _ivdreakr.PipelineBoard():
        return 'PipelineBoard';
      case _i3my1wkz.PipelineRow():
        return 'PipelineRow';
      case _ipvg0e5e.PlatformMetrics():
        return 'PlatformMetrics';
      case _ilt9vmc8.ReportRow():
        return 'ReportRow';
      case _ie7pd3y5.StageCount():
        return 'StageCount';
      case _irro0t1q.UserRow():
        return 'UserRow';
      case _is6wk0uj.VerificationItem():
        return 'VerificationItem';
      case _im1lo42e.AiConversation():
        return 'AiConversation';
      case _i60vlas3.AiMessage():
        return 'AiMessage';
      case _iylcg5z2.ChatEvent():
        return 'ChatEvent';
      case _iezvwzp2.ChatEventKind():
        return 'ChatEventKind';
      case _itf6z0wu.ChatMessageView():
        return 'ChatMessageView';
      case _izjqdijg.ChatRole():
        return 'ChatRole';
      case _i1uex9mj.AppUser():
        return 'AppUser';
      case _inw81056.CurrentUser():
        return 'CurrentUser';
      case _isgq0pqt.OtpPurpose():
        return 'OtpPurpose';
      case _i4xeafvz.OtpRequestResult():
        return 'OtpRequestResult';
      case _icv3d9my.RoleAssignment():
        return 'RoleAssignment';
      case _ibzm4nkn.UserRole():
        return 'UserRole';
      case _ixl0qkip.Consultation():
        return 'Consultation';
      case _iz4df293.ConsultationStatus():
        return 'ConsultationStatus';
      case _i36nxywn.DoctorAvailability():
        return 'DoctorAvailability';
      case _isdduwtg.DoctorProfile():
        return 'DoctorProfile';
      case _iwiaqbkd.Payment():
        return 'Payment';
      case _imww6den.PaymentStatus():
        return 'PaymentStatus';
      case _ioanksgy.Payout():
        return 'Payout';
      case _iqydhu29.PayoutStatus():
        return 'PayoutStatus';
      case _ia2dm2ho.CapabilityMatch():
        return 'CapabilityMatch';
      case _iahprb34.EmergencyAction():
        return 'EmergencyAction';
      case _i71ihctq.EmergencyResult():
        return 'EmergencyResult';
      case _ijkcj45d.EmergencySearch():
        return 'EmergencySearch';
      case _iotcqzr9.EmergencySession():
        return 'EmergencySession';
      case _ivcyj7k2.EmergencyType():
        return 'EmergencyType';
      case _irwpf0tc.PublicFacility():
        return 'PublicFacility';
      case _iw6bfsfn.StatusReport():
        return 'StatusReport';
      case _i8rvay2d.Capability():
        return 'Capability';
      case _ikxpuibo.DocumentKind():
        return 'DocumentKind';
      case _i79uvhsa.DuplicateCandidate():
        return 'DuplicateCandidate';
      case _i1h3x911.Facility():
        return 'Facility';
      case _ixr3kk26.FacilityCapability():
        return 'FacilityCapability';
      case _iqdib9ab.FacilityDetail():
        return 'FacilityDetail';
      case _i6urljsq.FacilityDocument():
        return 'FacilityDocument';
      case _iaay8q9z.FacilityProfileInput():
        return 'FacilityProfileInput';
      case _irz2ysl3.FacilitySearchResult():
        return 'FacilitySearchResult';
      case _icg7am50.FacilitySource():
        return 'FacilitySource';
      case _if8rrn88.FacilitySummary():
        return 'FacilitySummary';
      case _ify8mon7.FacilityType():
        return 'FacilityType';
      case _i9lfcknc.OnboardingStage():
        return 'OnboardingStage';
      case _iuy7y9n1.OpeningHours():
        return 'OpeningHours';
      case _ilazmsmc.OpeningPeriod():
        return 'OpeningPeriod';
      case _iewoplrh.UploadTicket():
        return 'UploadTicket';
      case _ilit88m4.VerificationStatus():
        return 'VerificationStatus';
      case _ijsmpu5o.AgentFacility():
        return 'AgentFacility';
      case _iudox9w5.ChecklistItem():
        return 'ChecklistItem';
      case _invn6987.ChecklistKey():
        return 'ChecklistKey';
      case _i3lx31x8.ClaimRequest():
        return 'ClaimRequest';
      case _itk14vm7.ClaimStatus():
        return 'ClaimStatus';
      case _it22gnmn.FacilityInvite():
        return 'FacilityInvite';
      case _inaz8u2w.FieldAgentArea():
        return 'FieldAgentArea';
      case _inbb6zej.GoLiveChecklist():
        return 'GoLiveChecklist';
      case _it6a6dpx.InviteCreated():
        return 'InviteCreated';
      case _ifovzbin.InvitePreview():
        return 'InvitePreview';
      case _i98mrfo7.JoinRequest():
        return 'JoinRequest';
      case _ilxmbwht.JoinRequestStatus():
        return 'JoinRequestStatus';
      case _idsjolhr.OnboardingEvent():
        return 'OnboardingEvent';
      case _iwakl52j.OnboardingRecord():
        return 'OnboardingRecord';
      case _i586qht0.StaffMember():
        return 'StaffMember';
      case _iyulom36.ContactAlertResult():
        return 'ContactAlertResult';
      case _iqbywrkt.ContactChannel():
        return 'ContactChannel';
      case _i1uqog83.EmergencyContact():
        return 'EmergencyContact';
      case _ipb37m2v.FamilyAlertResult():
        return 'FamilyAlertResult';
      case _iz9u6gbp.FirstAidCard():
        return 'FirstAidCard';
      case _i6w06m19.MedicalProfileData():
        return 'MedicalProfileData';
      case _i3thy5dm.AuditEntry():
        return 'AuditEntry';
      case _iqjk2hc4.FacilityStatus():
        return 'FacilityStatus';
      case _i1gorcse.FacilityStatusChanged():
        return 'FacilityStatusChanged';
      case _itvk3dud.FreshnessTier():
        return 'FreshnessTier';
      case _ijeqxb1v.StatusChangeLog():
        return 'StatusChangeLog';
      case _iv1sb3gj.StatusInput():
        return 'StatusInput';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppErrorCode') {
      return deserialize<_i4wtqx69.AppErrorCode>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i5epujyq.ConflictException>(data['data']);
    }
    if (dataClassName == 'InvalidStateException') {
      return deserialize<_if76hjxg.InvalidStateException>(data['data']);
    }
    if (dataClassName == 'NotAuthorizedException') {
      return deserialize<_id4j2cxo.NotAuthorizedException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_ixeh2c1z.NotFoundException>(data['data']);
    }
    if (dataClassName == 'RateLimitedException') {
      return deserialize<_i5xzqpwc.RateLimitedException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_io4t73gt.ValidationException>(data['data']);
    }
    if (dataClassName == 'AdminActionLog') {
      return deserialize<_id7ceaki.AdminActionLog>(data['data']);
    }
    if (dataClassName == 'AgentRow') {
      return deserialize<_iqju4b7m.AgentRow>(data['data']);
    }
    if (dataClassName == 'ClaimQueueItem') {
      return deserialize<_i0snb6d6.ClaimQueueItem>(data['data']);
    }
    if (dataClassName == 'DirectoryRow') {
      return deserialize<_i54iiwsn.DirectoryRow>(data['data']);
    }
    if (dataClassName == 'FacilityImportRow') {
      return deserialize<_ivyrrl9n.FacilityImportRow>(data['data']);
    }
    if (dataClassName == 'FacilityImportSummary') {
      return deserialize<_imphx5bj.FacilityImportSummary>(data['data']);
    }
    if (dataClassName == 'FreshnessRow') {
      return deserialize<_id7thq0e.FreshnessRow>(data['data']);
    }
    if (dataClassName == 'NewHospitalRow') {
      return deserialize<_iq76skmt.NewHospitalRow>(data['data']);
    }
    if (dataClassName == 'PipelineBoard') {
      return deserialize<_ivdreakr.PipelineBoard>(data['data']);
    }
    if (dataClassName == 'PipelineRow') {
      return deserialize<_i3my1wkz.PipelineRow>(data['data']);
    }
    if (dataClassName == 'PlatformMetrics') {
      return deserialize<_ipvg0e5e.PlatformMetrics>(data['data']);
    }
    if (dataClassName == 'ReportRow') {
      return deserialize<_ilt9vmc8.ReportRow>(data['data']);
    }
    if (dataClassName == 'StageCount') {
      return deserialize<_ie7pd3y5.StageCount>(data['data']);
    }
    if (dataClassName == 'UserRow') {
      return deserialize<_irro0t1q.UserRow>(data['data']);
    }
    if (dataClassName == 'VerificationItem') {
      return deserialize<_is6wk0uj.VerificationItem>(data['data']);
    }
    if (dataClassName == 'AiConversation') {
      return deserialize<_im1lo42e.AiConversation>(data['data']);
    }
    if (dataClassName == 'AiMessage') {
      return deserialize<_i60vlas3.AiMessage>(data['data']);
    }
    if (dataClassName == 'ChatEvent') {
      return deserialize<_iylcg5z2.ChatEvent>(data['data']);
    }
    if (dataClassName == 'ChatEventKind') {
      return deserialize<_iezvwzp2.ChatEventKind>(data['data']);
    }
    if (dataClassName == 'ChatMessageView') {
      return deserialize<_itf6z0wu.ChatMessageView>(data['data']);
    }
    if (dataClassName == 'ChatRole') {
      return deserialize<_izjqdijg.ChatRole>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i1uex9mj.AppUser>(data['data']);
    }
    if (dataClassName == 'CurrentUser') {
      return deserialize<_inw81056.CurrentUser>(data['data']);
    }
    if (dataClassName == 'OtpPurpose') {
      return deserialize<_isgq0pqt.OtpPurpose>(data['data']);
    }
    if (dataClassName == 'OtpRequestResult') {
      return deserialize<_i4xeafvz.OtpRequestResult>(data['data']);
    }
    if (dataClassName == 'RoleAssignment') {
      return deserialize<_icv3d9my.RoleAssignment>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ibzm4nkn.UserRole>(data['data']);
    }
    if (dataClassName == 'Consultation') {
      return deserialize<_ixl0qkip.Consultation>(data['data']);
    }
    if (dataClassName == 'ConsultationStatus') {
      return deserialize<_iz4df293.ConsultationStatus>(data['data']);
    }
    if (dataClassName == 'DoctorAvailability') {
      return deserialize<_i36nxywn.DoctorAvailability>(data['data']);
    }
    if (dataClassName == 'DoctorProfile') {
      return deserialize<_isdduwtg.DoctorProfile>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_iwiaqbkd.Payment>(data['data']);
    }
    if (dataClassName == 'PaymentStatus') {
      return deserialize<_imww6den.PaymentStatus>(data['data']);
    }
    if (dataClassName == 'Payout') {
      return deserialize<_ioanksgy.Payout>(data['data']);
    }
    if (dataClassName == 'PayoutStatus') {
      return deserialize<_iqydhu29.PayoutStatus>(data['data']);
    }
    if (dataClassName == 'CapabilityMatch') {
      return deserialize<_ia2dm2ho.CapabilityMatch>(data['data']);
    }
    if (dataClassName == 'EmergencyAction') {
      return deserialize<_iahprb34.EmergencyAction>(data['data']);
    }
    if (dataClassName == 'EmergencyResult') {
      return deserialize<_i71ihctq.EmergencyResult>(data['data']);
    }
    if (dataClassName == 'EmergencySearch') {
      return deserialize<_ijkcj45d.EmergencySearch>(data['data']);
    }
    if (dataClassName == 'EmergencySession') {
      return deserialize<_iotcqzr9.EmergencySession>(data['data']);
    }
    if (dataClassName == 'EmergencyType') {
      return deserialize<_ivcyj7k2.EmergencyType>(data['data']);
    }
    if (dataClassName == 'PublicFacility') {
      return deserialize<_irwpf0tc.PublicFacility>(data['data']);
    }
    if (dataClassName == 'StatusReport') {
      return deserialize<_iw6bfsfn.StatusReport>(data['data']);
    }
    if (dataClassName == 'Capability') {
      return deserialize<_i8rvay2d.Capability>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_ikxpuibo.DocumentKind>(data['data']);
    }
    if (dataClassName == 'DuplicateCandidate') {
      return deserialize<_i79uvhsa.DuplicateCandidate>(data['data']);
    }
    if (dataClassName == 'Facility') {
      return deserialize<_i1h3x911.Facility>(data['data']);
    }
    if (dataClassName == 'FacilityCapability') {
      return deserialize<_ixr3kk26.FacilityCapability>(data['data']);
    }
    if (dataClassName == 'FacilityDetail') {
      return deserialize<_iqdib9ab.FacilityDetail>(data['data']);
    }
    if (dataClassName == 'FacilityDocument') {
      return deserialize<_i6urljsq.FacilityDocument>(data['data']);
    }
    if (dataClassName == 'FacilityProfileInput') {
      return deserialize<_iaay8q9z.FacilityProfileInput>(data['data']);
    }
    if (dataClassName == 'FacilitySearchResult') {
      return deserialize<_irz2ysl3.FacilitySearchResult>(data['data']);
    }
    if (dataClassName == 'FacilitySource') {
      return deserialize<_icg7am50.FacilitySource>(data['data']);
    }
    if (dataClassName == 'FacilitySummary') {
      return deserialize<_if8rrn88.FacilitySummary>(data['data']);
    }
    if (dataClassName == 'FacilityType') {
      return deserialize<_ify8mon7.FacilityType>(data['data']);
    }
    if (dataClassName == 'OnboardingStage') {
      return deserialize<_i9lfcknc.OnboardingStage>(data['data']);
    }
    if (dataClassName == 'OpeningHours') {
      return deserialize<_iuy7y9n1.OpeningHours>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_ilazmsmc.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'UploadTicket') {
      return deserialize<_iewoplrh.UploadTicket>(data['data']);
    }
    if (dataClassName == 'VerificationStatus') {
      return deserialize<_ilit88m4.VerificationStatus>(data['data']);
    }
    if (dataClassName == 'AgentFacility') {
      return deserialize<_ijsmpu5o.AgentFacility>(data['data']);
    }
    if (dataClassName == 'ChecklistItem') {
      return deserialize<_iudox9w5.ChecklistItem>(data['data']);
    }
    if (dataClassName == 'ChecklistKey') {
      return deserialize<_invn6987.ChecklistKey>(data['data']);
    }
    if (dataClassName == 'ClaimRequest') {
      return deserialize<_i3lx31x8.ClaimRequest>(data['data']);
    }
    if (dataClassName == 'ClaimStatus') {
      return deserialize<_itk14vm7.ClaimStatus>(data['data']);
    }
    if (dataClassName == 'FacilityInvite') {
      return deserialize<_it22gnmn.FacilityInvite>(data['data']);
    }
    if (dataClassName == 'FieldAgentArea') {
      return deserialize<_inaz8u2w.FieldAgentArea>(data['data']);
    }
    if (dataClassName == 'GoLiveChecklist') {
      return deserialize<_inbb6zej.GoLiveChecklist>(data['data']);
    }
    if (dataClassName == 'InviteCreated') {
      return deserialize<_it6a6dpx.InviteCreated>(data['data']);
    }
    if (dataClassName == 'InvitePreview') {
      return deserialize<_ifovzbin.InvitePreview>(data['data']);
    }
    if (dataClassName == 'JoinRequest') {
      return deserialize<_i98mrfo7.JoinRequest>(data['data']);
    }
    if (dataClassName == 'JoinRequestStatus') {
      return deserialize<_ilxmbwht.JoinRequestStatus>(data['data']);
    }
    if (dataClassName == 'OnboardingEvent') {
      return deserialize<_idsjolhr.OnboardingEvent>(data['data']);
    }
    if (dataClassName == 'OnboardingRecord') {
      return deserialize<_iwakl52j.OnboardingRecord>(data['data']);
    }
    if (dataClassName == 'StaffMember') {
      return deserialize<_i586qht0.StaffMember>(data['data']);
    }
    if (dataClassName == 'ContactAlertResult') {
      return deserialize<_iyulom36.ContactAlertResult>(data['data']);
    }
    if (dataClassName == 'ContactChannel') {
      return deserialize<_iqbywrkt.ContactChannel>(data['data']);
    }
    if (dataClassName == 'EmergencyContact') {
      return deserialize<_i1uqog83.EmergencyContact>(data['data']);
    }
    if (dataClassName == 'FamilyAlertResult') {
      return deserialize<_ipb37m2v.FamilyAlertResult>(data['data']);
    }
    if (dataClassName == 'FirstAidCard') {
      return deserialize<_iz9u6gbp.FirstAidCard>(data['data']);
    }
    if (dataClassName == 'MedicalProfileData') {
      return deserialize<_i6w06m19.MedicalProfileData>(data['data']);
    }
    if (dataClassName == 'AuditEntry') {
      return deserialize<_i3thy5dm.AuditEntry>(data['data']);
    }
    if (dataClassName == 'FacilityStatus') {
      return deserialize<_iqjk2hc4.FacilityStatus>(data['data']);
    }
    if (dataClassName == 'FacilityStatusChanged') {
      return deserialize<_i1gorcse.FacilityStatusChanged>(data['data']);
    }
    if (dataClassName == 'FreshnessTier') {
      return deserialize<_itvk3dud.FreshnessTier>(data['data']);
    }
    if (dataClassName == 'StatusChangeLog') {
      return deserialize<_ijeqxb1v.StatusChangeLog>(data['data']);
    }
    if (dataClassName == 'StatusInput') {
      return deserialize<_iv1sb3gj.StatusInput>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('emergencyhr', this);
    _iacc.Protocol().registerHostProtocol('emergencyhr', this);
  }

  @override
  String getModuleName() => 'emergencyhr';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
