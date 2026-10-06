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
import 'package:emergencyhr_server/src/generated/protocol.dart' as _ilvcm0hz;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/profile/models/contact_alert_result.dart'
    as _imkil9xa;

abstract class FamilyAlertResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FamilyAlertResult._({
    required this.message,
    required this.results,
  });

  factory FamilyAlertResult({
    required String message,
    required List<_imkil9xa.ContactAlertResult> results,
  }) = _FamilyAlertResultImpl;

  factory FamilyAlertResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyAlertResult(
      message: jsonSerialization['message'] as String,
      results: _ilvcm0hz.Protocol()
          .deserialize<List<_imkil9xa.ContactAlertResult>>(
            jsonSerialization['results'],
          ),
    );
  }

  String message;

  List<_imkil9xa.ContactAlertResult> results;

  /// Returns a shallow copy of this [FamilyAlertResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FamilyAlertResult copyWith({
    String? message,
    List<_imkil9xa.ContactAlertResult>? results,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FamilyAlertResult',
      'message': message,
      'results': results.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FamilyAlertResult',
      'message': message,
      'results': results.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FamilyAlertResultImpl extends FamilyAlertResult {
  _FamilyAlertResultImpl({
    required String message,
    required List<_imkil9xa.ContactAlertResult> results,
  }) : super._(
         message: message,
         results: results,
       );

  /// Returns a shallow copy of this [FamilyAlertResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FamilyAlertResult copyWith({
    String? message,
    List<_imkil9xa.ContactAlertResult>? results,
  }) {
    return FamilyAlertResult(
      message: message ?? this.message,
      results: results ?? this.results.map((e0) => e0.copyWith()).toList(),
    );
  }
}
