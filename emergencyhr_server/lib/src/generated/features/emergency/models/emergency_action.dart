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

enum EmergencyAction implements _is.SerializableModel {
  call,
  directions,
  call112,
  none;

  static EmergencyAction fromJson(String name) {
    switch (name) {
      case 'call':
        return EmergencyAction.call;
      case 'directions':
        return EmergencyAction.directions;
      case 'call112':
        return EmergencyAction.call112;
      case 'none':
        return EmergencyAction.none;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "EmergencyAction"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
