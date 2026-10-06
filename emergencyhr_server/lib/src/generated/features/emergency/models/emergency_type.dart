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
import 'package:serverpod/serverpod.dart' as _is;

enum EmergencyType implements _is.SerializableModel {
  roadAccident,
  severeBleeding,
  burns,
  chestPain,
  pregnancy,
  child,
  unconscious,
  breathingDifficulty,
  other,
  skipped;

  static EmergencyType fromJson(String name) {
    switch (name) {
      case 'roadAccident':
        return EmergencyType.roadAccident;
      case 'severeBleeding':
        return EmergencyType.severeBleeding;
      case 'burns':
        return EmergencyType.burns;
      case 'chestPain':
        return EmergencyType.chestPain;
      case 'pregnancy':
        return EmergencyType.pregnancy;
      case 'child':
        return EmergencyType.child;
      case 'unconscious':
        return EmergencyType.unconscious;
      case 'breathingDifficulty':
        return EmergencyType.breathingDifficulty;
      case 'other':
        return EmergencyType.other;
      case 'skipped':
        return EmergencyType.skipped;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "EmergencyType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
