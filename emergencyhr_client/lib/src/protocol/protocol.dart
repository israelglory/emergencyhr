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
import 'features/assistant/models/ai_conversation.dart' as _im1lo42e;
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
import 'features/emergency/models/emergency_action.dart' as _iahprb34;
import 'features/emergency/models/emergency_type.dart' as _ivcyj7k2;
import 'features/emergency/models/status_report.dart' as _iw6bfsfn;
import 'features/facilities/models/capability.dart' as _i8rvay2d;
import 'features/facilities/models/document_kind.dart' as _ikxpuibo;
import 'features/facilities/models/facility.dart' as _i1h3x911;
import 'features/facilities/models/facility_capability.dart' as _ixr3kk26;
import 'features/facilities/models/facility_document.dart' as _i6urljsq;
import 'features/facilities/models/facility_source.dart' as _icg7am50;
import 'features/facilities/models/facility_summary.dart' as _if8rrn88;
import 'features/facilities/models/facility_type.dart' as _ify8mon7;
import 'features/facilities/models/onboarding_stage.dart' as _i9lfcknc;
import 'features/facilities/models/opening_hours.dart' as _iuy7y9n1;
import 'features/facilities/models/opening_period.dart' as _ilazmsmc;
import 'features/facilities/models/verification_status.dart' as _ilit88m4;
import 'features/onboarding/models/claim_request.dart' as _i3lx31x8;
import 'features/onboarding/models/claim_status.dart' as _itk14vm7;
import 'features/onboarding/models/field_agent_area.dart' as _inaz8u2w;
import 'features/onboarding/models/join_request.dart' as _i98mrfo7;
import 'features/onboarding/models/join_request_status.dart' as _ilxmbwht;
import 'features/onboarding/models/onboarding_event.dart' as _idsjolhr;
import 'features/onboarding/models/onboarding_record.dart' as _iwakl52j;
import 'features/profile/models/contact_channel.dart' as _iqbywrkt;
import 'features/profile/models/emergency_contact.dart' as _i1uqog83;
import 'features/profile/models/medical_profile_data.dart' as _i6w06m19;
import 'features/status/models/facility_status.dart' as _iqjk2hc4;
import 'features/status/models/status_change_log.dart' as _ijeqxb1v;
export 'core/errors/app_error_code.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/invalid_state_exception.dart';
export 'core/errors/not_authorized_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/rate_limited_exception.dart';
export 'core/errors/validation_exception.dart';
export 'features/admin/models/admin_action_log.dart';
export 'features/assistant/models/ai_conversation.dart';
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
export 'features/emergency/models/emergency_action.dart';
export 'features/emergency/models/emergency_type.dart';
export 'features/emergency/models/status_report.dart';
export 'features/facilities/models/capability.dart';
export 'features/facilities/models/document_kind.dart';
export 'features/facilities/models/facility.dart';
export 'features/facilities/models/facility_capability.dart';
export 'features/facilities/models/facility_document.dart';
export 'features/facilities/models/facility_source.dart';
export 'features/facilities/models/facility_summary.dart';
export 'features/facilities/models/facility_type.dart';
export 'features/facilities/models/onboarding_stage.dart';
export 'features/facilities/models/opening_hours.dart';
export 'features/facilities/models/opening_period.dart';
export 'features/facilities/models/verification_status.dart';
export 'features/onboarding/models/claim_request.dart';
export 'features/onboarding/models/claim_status.dart';
export 'features/onboarding/models/field_agent_area.dart';
export 'features/onboarding/models/join_request.dart';
export 'features/onboarding/models/join_request_status.dart';
export 'features/onboarding/models/onboarding_event.dart';
export 'features/onboarding/models/onboarding_record.dart';
export 'features/profile/models/contact_channel.dart';
export 'features/profile/models/emergency_contact.dart';
export 'features/profile/models/medical_profile_data.dart';
export 'features/status/models/facility_status.dart';
export 'features/status/models/status_change_log.dart';
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
    if (t == _im1lo42e.AiConversation) {
      return _im1lo42e.AiConversation.fromJson(data) as T;
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
    if (t == _iahprb34.EmergencyAction) {
      return _iahprb34.EmergencyAction.fromJson(data) as T;
    }
    if (t == _ivcyj7k2.EmergencyType) {
      return _ivcyj7k2.EmergencyType.fromJson(data) as T;
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
    if (t == _i1h3x911.Facility) {
      return _i1h3x911.Facility.fromJson(data) as T;
    }
    if (t == _ixr3kk26.FacilityCapability) {
      return _ixr3kk26.FacilityCapability.fromJson(data) as T;
    }
    if (t == _i6urljsq.FacilityDocument) {
      return _i6urljsq.FacilityDocument.fromJson(data) as T;
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
    if (t == _ilit88m4.VerificationStatus) {
      return _ilit88m4.VerificationStatus.fromJson(data) as T;
    }
    if (t == _i3lx31x8.ClaimRequest) {
      return _i3lx31x8.ClaimRequest.fromJson(data) as T;
    }
    if (t == _itk14vm7.ClaimStatus) {
      return _itk14vm7.ClaimStatus.fromJson(data) as T;
    }
    if (t == _inaz8u2w.FieldAgentArea) {
      return _inaz8u2w.FieldAgentArea.fromJson(data) as T;
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
    if (t == _iqbywrkt.ContactChannel) {
      return _iqbywrkt.ContactChannel.fromJson(data) as T;
    }
    if (t == _i1uqog83.EmergencyContact) {
      return _i1uqog83.EmergencyContact.fromJson(data) as T;
    }
    if (t == _i6w06m19.MedicalProfileData) {
      return _i6w06m19.MedicalProfileData.fromJson(data) as T;
    }
    if (t == _iqjk2hc4.FacilityStatus) {
      return _iqjk2hc4.FacilityStatus.fromJson(data) as T;
    }
    if (t == _ijeqxb1v.StatusChangeLog) {
      return _ijeqxb1v.StatusChangeLog.fromJson(data) as T;
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
    if (t == _isc.getType<_im1lo42e.AiConversation?>()) {
      return (data != null ? _im1lo42e.AiConversation.fromJson(data) : null)
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
    if (t == _isc.getType<_iahprb34.EmergencyAction?>()) {
      return (data != null ? _iahprb34.EmergencyAction.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivcyj7k2.EmergencyType?>()) {
      return (data != null ? _ivcyj7k2.EmergencyType.fromJson(data) : null)
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
    if (t == _isc.getType<_i1h3x911.Facility?>()) {
      return (data != null ? _i1h3x911.Facility.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixr3kk26.FacilityCapability?>()) {
      return (data != null ? _ixr3kk26.FacilityCapability.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6urljsq.FacilityDocument?>()) {
      return (data != null ? _i6urljsq.FacilityDocument.fromJson(data) : null)
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
    if (t == _isc.getType<_ilit88m4.VerificationStatus?>()) {
      return (data != null ? _ilit88m4.VerificationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3lx31x8.ClaimRequest?>()) {
      return (data != null ? _i3lx31x8.ClaimRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itk14vm7.ClaimStatus?>()) {
      return (data != null ? _itk14vm7.ClaimStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inaz8u2w.FieldAgentArea?>()) {
      return (data != null ? _inaz8u2w.FieldAgentArea.fromJson(data) : null)
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
    if (t == _isc.getType<_iqbywrkt.ContactChannel?>()) {
      return (data != null ? _iqbywrkt.ContactChannel.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1uqog83.EmergencyContact?>()) {
      return (data != null ? _i1uqog83.EmergencyContact.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6w06m19.MedicalProfileData?>()) {
      return (data != null ? _i6w06m19.MedicalProfileData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqjk2hc4.FacilityStatus?>()) {
      return (data != null ? _iqjk2hc4.FacilityStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijeqxb1v.StatusChangeLog?>()) {
      return (data != null ? _ijeqxb1v.StatusChangeLog.fromJson(data) : null)
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
    if (t == List<_ilazmsmc.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_ilazmsmc.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
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
      _im1lo42e.AiConversation => 'AiConversation',
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
      _iahprb34.EmergencyAction => 'EmergencyAction',
      _ivcyj7k2.EmergencyType => 'EmergencyType',
      _iw6bfsfn.StatusReport => 'StatusReport',
      _i8rvay2d.Capability => 'Capability',
      _ikxpuibo.DocumentKind => 'DocumentKind',
      _i1h3x911.Facility => 'Facility',
      _ixr3kk26.FacilityCapability => 'FacilityCapability',
      _i6urljsq.FacilityDocument => 'FacilityDocument',
      _icg7am50.FacilitySource => 'FacilitySource',
      _if8rrn88.FacilitySummary => 'FacilitySummary',
      _ify8mon7.FacilityType => 'FacilityType',
      _i9lfcknc.OnboardingStage => 'OnboardingStage',
      _iuy7y9n1.OpeningHours => 'OpeningHours',
      _ilazmsmc.OpeningPeriod => 'OpeningPeriod',
      _ilit88m4.VerificationStatus => 'VerificationStatus',
      _i3lx31x8.ClaimRequest => 'ClaimRequest',
      _itk14vm7.ClaimStatus => 'ClaimStatus',
      _inaz8u2w.FieldAgentArea => 'FieldAgentArea',
      _i98mrfo7.JoinRequest => 'JoinRequest',
      _ilxmbwht.JoinRequestStatus => 'JoinRequestStatus',
      _idsjolhr.OnboardingEvent => 'OnboardingEvent',
      _iwakl52j.OnboardingRecord => 'OnboardingRecord',
      _iqbywrkt.ContactChannel => 'ContactChannel',
      _i1uqog83.EmergencyContact => 'EmergencyContact',
      _i6w06m19.MedicalProfileData => 'MedicalProfileData',
      _iqjk2hc4.FacilityStatus => 'FacilityStatus',
      _ijeqxb1v.StatusChangeLog => 'StatusChangeLog',
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
      case _im1lo42e.AiConversation():
        return 'AiConversation';
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
      case _iahprb34.EmergencyAction():
        return 'EmergencyAction';
      case _ivcyj7k2.EmergencyType():
        return 'EmergencyType';
      case _iw6bfsfn.StatusReport():
        return 'StatusReport';
      case _i8rvay2d.Capability():
        return 'Capability';
      case _ikxpuibo.DocumentKind():
        return 'DocumentKind';
      case _i1h3x911.Facility():
        return 'Facility';
      case _ixr3kk26.FacilityCapability():
        return 'FacilityCapability';
      case _i6urljsq.FacilityDocument():
        return 'FacilityDocument';
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
      case _ilit88m4.VerificationStatus():
        return 'VerificationStatus';
      case _i3lx31x8.ClaimRequest():
        return 'ClaimRequest';
      case _itk14vm7.ClaimStatus():
        return 'ClaimStatus';
      case _inaz8u2w.FieldAgentArea():
        return 'FieldAgentArea';
      case _i98mrfo7.JoinRequest():
        return 'JoinRequest';
      case _ilxmbwht.JoinRequestStatus():
        return 'JoinRequestStatus';
      case _idsjolhr.OnboardingEvent():
        return 'OnboardingEvent';
      case _iwakl52j.OnboardingRecord():
        return 'OnboardingRecord';
      case _iqbywrkt.ContactChannel():
        return 'ContactChannel';
      case _i1uqog83.EmergencyContact():
        return 'EmergencyContact';
      case _i6w06m19.MedicalProfileData():
        return 'MedicalProfileData';
      case _iqjk2hc4.FacilityStatus():
        return 'FacilityStatus';
      case _ijeqxb1v.StatusChangeLog():
        return 'StatusChangeLog';
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
    if (dataClassName == 'AiConversation') {
      return deserialize<_im1lo42e.AiConversation>(data['data']);
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
    if (dataClassName == 'EmergencyAction') {
      return deserialize<_iahprb34.EmergencyAction>(data['data']);
    }
    if (dataClassName == 'EmergencyType') {
      return deserialize<_ivcyj7k2.EmergencyType>(data['data']);
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
    if (dataClassName == 'Facility') {
      return deserialize<_i1h3x911.Facility>(data['data']);
    }
    if (dataClassName == 'FacilityCapability') {
      return deserialize<_ixr3kk26.FacilityCapability>(data['data']);
    }
    if (dataClassName == 'FacilityDocument') {
      return deserialize<_i6urljsq.FacilityDocument>(data['data']);
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
    if (dataClassName == 'VerificationStatus') {
      return deserialize<_ilit88m4.VerificationStatus>(data['data']);
    }
    if (dataClassName == 'ClaimRequest') {
      return deserialize<_i3lx31x8.ClaimRequest>(data['data']);
    }
    if (dataClassName == 'ClaimStatus') {
      return deserialize<_itk14vm7.ClaimStatus>(data['data']);
    }
    if (dataClassName == 'FieldAgentArea') {
      return deserialize<_inaz8u2w.FieldAgentArea>(data['data']);
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
    if (dataClassName == 'ContactChannel') {
      return deserialize<_iqbywrkt.ContactChannel>(data['data']);
    }
    if (dataClassName == 'EmergencyContact') {
      return deserialize<_i1uqog83.EmergencyContact>(data['data']);
    }
    if (dataClassName == 'MedicalProfileData') {
      return deserialize<_i6w06m19.MedicalProfileData>(data['data']);
    }
    if (dataClassName == 'FacilityStatus') {
      return deserialize<_iqjk2hc4.FacilityStatus>(data['data']);
    }
    if (dataClassName == 'StatusChangeLog') {
      return deserialize<_ijeqxb1v.StatusChangeLog>(data['data']);
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
