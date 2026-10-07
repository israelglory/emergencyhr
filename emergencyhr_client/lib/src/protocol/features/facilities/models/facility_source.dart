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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

enum FacilitySource implements _isc.SerializableModel {
  seeded,
  fieldAgent,
  selfSignup,
  claim,
  imported;

  static FacilitySource fromJson(String name) {
    switch (name) {
      case 'seeded':
        return FacilitySource.seeded;
      case 'fieldAgent':
        return FacilitySource.fieldAgent;
      case 'selfSignup':
        return FacilitySource.selfSignup;
      case 'claim':
        return FacilitySource.claim;
      case 'imported':
        return FacilitySource.imported;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "FacilitySource"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
