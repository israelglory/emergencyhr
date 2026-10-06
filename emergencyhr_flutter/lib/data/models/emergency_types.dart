import 'package:emergencyhr_client/emergencyhr_client.dart';

/// The nine choices shown in the emergency type picker, in display order.
abstract final class EmergencyTypes {
  static const picker = [
    EmergencyType.roadAccident,
    EmergencyType.severeBleeding,
    EmergencyType.chestPain,
    EmergencyType.breathingDifficulty,
    EmergencyType.unconscious,
    EmergencyType.pregnancy,
    EmergencyType.child,
    EmergencyType.burns,
    EmergencyType.other,
  ];
}
