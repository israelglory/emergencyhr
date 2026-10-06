import 'package:emergencyhr_client/emergencyhr_client.dart';

/// Turns any error into plain, user-facing copy. Server errors carry a
/// stable [AppErrorCode] and a message written for users.
abstract final class ErrorMessages {
  static const offline =
      'No internet connection. Check your connection and try again.';
  static const generic = 'Something went wrong. Please try again.';

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
