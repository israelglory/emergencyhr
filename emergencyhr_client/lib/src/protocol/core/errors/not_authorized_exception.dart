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
import '../../core/errors/app_error_code.dart' as _i5wvvza7;

/// Typed error sent to the client. Never carries stack traces or database errors.
abstract class NotAuthorizedException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  NotAuthorizedException._({
    required this.code,
    required this.message,
    this.field,
  });

  factory NotAuthorizedException({
    required _i5wvvza7.AppErrorCode code,
    required String message,
    String? field,
  }) = _NotAuthorizedExceptionImpl;

  factory NotAuthorizedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotAuthorizedException(
      code: _i5wvvza7.AppErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
      message: jsonSerialization['message'] as String,
      field: jsonSerialization['field'] as String?,
    );
  }

  _i5wvvza7.AppErrorCode code;

  String message;

  /// Optional name of the input field that failed, for form errors.
  String? field;

  /// Returns a shallow copy of this [NotAuthorizedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NotAuthorizedException copyWith({
    _i5wvvza7.AppErrorCode? code,
    String? message,
    String? field,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotAuthorizedException',
      'code': code.toJson(),
      'message': message,
      if (field != null) 'field': field,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NotAuthorizedException',
      'code': code.toJson(),
      'message': message,
      if (field != null) 'field': field,
    };
  }

  @override
  String toString() {
    return 'NotAuthorizedException(code: $code, message: $message, field: $field)';
  }
}

class _Undefined {}

class _NotAuthorizedExceptionImpl extends NotAuthorizedException {
  _NotAuthorizedExceptionImpl({
    required _i5wvvza7.AppErrorCode code,
    required String message,
    String? field,
  }) : super._(
         code: code,
         message: message,
         field: field,
       );

  /// Returns a shallow copy of this [NotAuthorizedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NotAuthorizedException copyWith({
    _i5wvvza7.AppErrorCode? code,
    String? message,
    Object? field = _Undefined,
  }) {
    return NotAuthorizedException(
      code: code ?? this.code,
      message: message ?? this.message,
      field: field is String? ? field : this.field,
    );
  }
}
