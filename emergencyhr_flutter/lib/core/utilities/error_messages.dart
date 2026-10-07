import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    show
        EmailAccountLoginException,
        EmailAccountLoginExceptionReason,
        EmailAccountPasswordResetException,
        EmailAccountPasswordResetExceptionReason,
        EmailAccountRequestException,
        EmailAccountRequestExceptionReason;

/// Turns any error into plain, user-facing copy. Server errors carry a
/// stable [AppErrorCode] and a message written for users.
abstract final class ErrorMessages {
  static const offline =
      'No internet connection. Check your connection and try again.';
  static const generic = 'Something went wrong. Please try again.';
  static const passwordRule =
      'Use at least 8 characters, with no spaces at the start or end.';

  static ({String message, AppErrorCode? code, String? field, bool offline})
  describe(Object error) {
    return switch (error) {
      final NotAuthorizedException e => (
        message: e.message,
        code: e.code,
        field: e.field,
        offline: false,
      ),
      final ValidationException e => (
        message: e.message,
        code: e.code,
        field: e.field,
        offline: false,
      ),
      final NotFoundException e => (
        message: e.message,
        code: e.code,
        field: e.field,
        offline: false,
      ),
      final ConflictException e => (
        message: e.message,
        code: e.code,
        field: e.field,
        offline: false,
      ),
      final InvalidStateException e => (
        message: e.message,
        code: e.code,
        field: e.field,
        offline: false,
      ),
      final RateLimitedException e => (
        message: e.retryAfterSeconds != null && e.retryAfterSeconds! < 120
            ? 'Please wait ${e.retryAfterSeconds} seconds and try again.'
            : e.message,
        code: e.code,
        field: null,
        offline: false,
      ),
      final EmailAccountLoginException e => (
        message: switch (e.reason) {
          EmailAccountLoginExceptionReason.invalidCredentials =>
            'That email and password do not match.',
          EmailAccountLoginExceptionReason.tooManyAttempts =>
            'Too many attempts. Wait a few minutes and try again.',
          EmailAccountLoginExceptionReason.unknown => generic,
        },
        code: null,
        field: 'password',
        offline: false,
      ),
      final EmailAccountRequestException e => (
        message: switch (e.reason) {
          EmailAccountRequestExceptionReason.invalid =>
            'That code is not correct.',
          EmailAccountRequestExceptionReason.expired =>
            'This code has expired. Start again to get a new one.',
          EmailAccountRequestExceptionReason.policyViolation => passwordRule,
          EmailAccountRequestExceptionReason.tooManyAttempts =>
            'Too many attempts. Start again to get a new code.',
          EmailAccountRequestExceptionReason.unknown => generic,
        },
        code: null,
        field: e.reason == EmailAccountRequestExceptionReason.policyViolation
            ? 'password'
            : 'code',
        offline: false,
      ),
      final EmailAccountPasswordResetException e => (
        message: switch (e.reason) {
          EmailAccountPasswordResetExceptionReason.invalid =>
            'That code is not correct.',
          EmailAccountPasswordResetExceptionReason.expired =>
            'This code has expired. Start again to get a new one.',
          EmailAccountPasswordResetExceptionReason.policyViolation =>
            passwordRule,
          EmailAccountPasswordResetExceptionReason.tooManyAttempts =>
            'Too many attempts. Wait an hour and try again.',
          EmailAccountPasswordResetExceptionReason.unknown => generic,
        },
        code: null,
        field:
            e.reason == EmailAccountPasswordResetExceptionReason.policyViolation
            ? 'password'
            : 'code',
        offline: false,
      ),
      ServerpodClientUnauthorized _ => (
        message: 'Please sign in again.',
        code: AppErrorCode.notAuthenticated,
        field: null,
        offline: false,
      ),
      ServerpodClientNetworkException _ => (
        message: offline,
        code: null,
        field: null,
        offline: true,
      ),
      _ => (message: generic, code: null, field: null, offline: false),
    };
  }
}
