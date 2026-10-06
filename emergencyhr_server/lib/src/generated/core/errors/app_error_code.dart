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

/// Stable error codes the client maps to user-facing messages.
enum AppErrorCode implements _is.SerializableModel {
  notAuthenticated,
  notAuthorized,
  validation,
  notFound,
  rateLimited,
  conflict,
  invalidState,
  otpInvalid,
  otpExpired,
  featureDisabled;

  static AppErrorCode fromJson(String name) {
    switch (name) {
      case 'notAuthenticated':
        return AppErrorCode.notAuthenticated;
      case 'notAuthorized':
        return AppErrorCode.notAuthorized;
      case 'validation':
        return AppErrorCode.validation;
      case 'notFound':
        return AppErrorCode.notFound;
      case 'rateLimited':
        return AppErrorCode.rateLimited;
      case 'conflict':
        return AppErrorCode.conflict;
      case 'invalidState':
        return AppErrorCode.invalidState;
      case 'otpInvalid':
        return AppErrorCode.otpInvalid;
      case 'otpExpired':
        return AppErrorCode.otpExpired;
      case 'featureDisabled':
        return AppErrorCode.featureDisabled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AppErrorCode"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
