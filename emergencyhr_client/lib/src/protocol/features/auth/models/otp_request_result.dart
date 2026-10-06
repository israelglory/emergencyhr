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

/// Returned after a code is sent.
abstract class OtpRequestResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OtpRequestResult._({
    required this.phone,
    required this.expiresAt,
    required this.codeLength,
    required this.resendAvailableAt,
  });

  factory OtpRequestResult({
    required String phone,
    required DateTime expiresAt,
    required int codeLength,
    required DateTime resendAvailableAt,
  }) = _OtpRequestResultImpl;

  factory OtpRequestResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtpRequestResult(
      phone: jsonSerialization['phone'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      codeLength: jsonSerialization['codeLength'] as int,
      resendAvailableAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['resendAvailableAt'],
      ),
    );
  }

  String phone;

  DateTime expiresAt;

  int codeLength;

  DateTime resendAvailableAt;

  /// Returns a shallow copy of this [OtpRequestResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OtpRequestResult copyWith({
    String? phone,
    DateTime? expiresAt,
    int? codeLength,
    DateTime? resendAvailableAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtpRequestResult',
      'phone': phone,
      'expiresAt': expiresAt.toJson(),
      'codeLength': codeLength,
      'resendAvailableAt': resendAvailableAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OtpRequestResult',
      'phone': phone,
      'expiresAt': expiresAt.toJson(),
      'codeLength': codeLength,
      'resendAvailableAt': resendAvailableAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OtpRequestResultImpl extends OtpRequestResult {
  _OtpRequestResultImpl({
    required String phone,
    required DateTime expiresAt,
    required int codeLength,
    required DateTime resendAvailableAt,
  }) : super._(
         phone: phone,
         expiresAt: expiresAt,
         codeLength: codeLength,
         resendAvailableAt: resendAvailableAt,
       );

  /// Returns a shallow copy of this [OtpRequestResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OtpRequestResult copyWith({
    String? phone,
    DateTime? expiresAt,
    int? codeLength,
    DateTime? resendAvailableAt,
  }) {
    return OtpRequestResult(
      phone: phone ?? this.phone,
      expiresAt: expiresAt ?? this.expiresAt,
      codeLength: codeLength ?? this.codeLength,
      resendAvailableAt: resendAvailableAt ?? this.resendAvailableAt,
    );
  }
}
