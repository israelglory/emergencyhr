import '../../../generated/protocol.dart';

/// Which capability an emergency type needs.
abstract final class CapabilityRules {
  static CapabilityMatch match(
    EmergencyType type,
    Set<Capability> caps, {
    required bool doctorOnDuty,
  }) {
    final general = caps.contains(Capability.generalEmergency) && doctorOnDuty;
    Capability? specific;
    switch (type) {
      case EmergencyType.roadAccident:
      case EmergencyType.severeBleeding:
        specific = Capability.trauma;
      case EmergencyType.burns:
        if (caps.contains(Capability.burns)) return CapabilityMatch.full;
        specific = Capability.trauma;
      case EmergencyType.chestPain:
        if (caps.contains(Capability.cardiac) || general) {
          return CapabilityMatch.full;
        }
        return CapabilityMatch.none;
      case EmergencyType.pregnancy:
        specific = Capability.obstetrics;
      case EmergencyType.child:
        specific = Capability.paediatrics;
      case EmergencyType.unconscious:
      case EmergencyType.breathingDifficulty:
      case EmergencyType.other:
      case EmergencyType.skipped:
        return general ? CapabilityMatch.full : CapabilityMatch.none;
    }
    if (caps.contains(specific)) return CapabilityMatch.full;
    return general ? CapabilityMatch.partial : CapabilityMatch.none;
  }

  /// Within a tier, burns units come first for burns.
  static bool preferred(EmergencyType type, Set<Capability> caps) =>
      type == EmergencyType.burns && caps.contains(Capability.burns);
}
