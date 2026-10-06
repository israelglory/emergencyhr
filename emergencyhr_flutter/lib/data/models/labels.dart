import 'package:emergencyhr_client/emergencyhr_client.dart';

/// Plain-language names for server enums, shared by viewmodels.
extension UserRoleLabel on UserRole {
  String get label => switch (this) {
    UserRole.public => 'Public user',
    UserRole.hospitalAdmin => 'Hospital admin',
    UserRole.deskStaff => 'Desk staff',
    UserRole.fieldAgent => 'Field agent',
    UserRole.doctor => 'Doctor',
    UserRole.platformAdmin => 'Platform admin',
  };
}

extension CapabilityLabel on Capability {
  String get label => switch (this) {
    Capability.generalEmergency => 'General emergency',
    Capability.trauma => 'Trauma',
    Capability.obstetrics => 'Obstetrics',
    Capability.paediatrics => 'Paediatrics',
    Capability.cardiac => 'Cardiac',
    Capability.burns => 'Burns',
    Capability.icu => 'ICU',
    Capability.theatre => 'Theatre',
    Capability.bloodBank => 'Blood bank',
    Capability.oxygen => 'Oxygen',
    Capability.ambulance => 'Ambulance',
  };
}

extension EmergencyTypeLabel on EmergencyType {
  String get label => switch (this) {
    EmergencyType.roadAccident => 'Road accident',
    EmergencyType.severeBleeding => 'Severe bleeding',
    EmergencyType.burns => 'Burns',
    EmergencyType.chestPain => 'Chest pain',
    EmergencyType.pregnancy => 'Pregnancy',
    EmergencyType.child => 'Child',
    EmergencyType.unconscious => 'Unconscious',
    EmergencyType.breathingDifficulty => 'Breathing difficulty',
    EmergencyType.other => 'Something else',
    EmergencyType.skipped => 'Not specified',
  };
}

extension FacilityTypeLabel on FacilityType {
  String get label => switch (this) {
    FacilityType.public => 'Public hospital',
    FacilityType.private => 'Private hospital',
    FacilityType.mission => 'Mission hospital',
  };
}

extension OnboardingStageLabel on OnboardingStage {
  String get label => switch (this) {
    OnboardingStage.seeded => 'Seeded',
    OnboardingStage.contacted => 'Contacted',
    OnboardingStage.visited => 'Visited',
    OnboardingStage.staffTrained => 'Staff trained',
    OnboardingStage.verified => 'Verified',
    OnboardingStage.live => 'Live',
    OnboardingStage.paused => 'Paused',
    OnboardingStage.declined => 'Declined',
  };
}

extension VerificationStatusLabel on VerificationStatus {
  String get label => switch (this) {
    VerificationStatus.seeded => 'Seeded listing',
    VerificationStatus.pending => 'Pending verification',
    VerificationStatus.verified => 'Verified',
    VerificationStatus.rejected => 'Rejected',
    VerificationStatus.suspended => 'Suspended',
  };
}
