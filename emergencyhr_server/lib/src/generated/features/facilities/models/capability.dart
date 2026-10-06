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

enum Capability implements _is.SerializableModel {
  generalEmergency,
  trauma,
  obstetrics,
  paediatrics,
  cardiac,
  burns,
  icu,
  theatre,
  bloodBank,
  oxygen,
  ambulance;

  static Capability fromJson(String name) {
    switch (name) {
      case 'generalEmergency':
        return Capability.generalEmergency;
      case 'trauma':
        return Capability.trauma;
      case 'obstetrics':
        return Capability.obstetrics;
      case 'paediatrics':
        return Capability.paediatrics;
      case 'cardiac':
        return Capability.cardiac;
      case 'burns':
        return Capability.burns;
      case 'icu':
        return Capability.icu;
      case 'theatre':
        return Capability.theatre;
      case 'bloodBank':
        return Capability.bloodBank;
      case 'oxygen':
        return Capability.oxygen;
      case 'ambulance':
        return Capability.ambulance;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "Capability"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
