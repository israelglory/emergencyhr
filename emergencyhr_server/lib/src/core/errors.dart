import '../generated/protocol.dart';

/// Short constructors for the typed exceptions sent to the client.
abstract final class Errors {
  static NotAuthorizedException notAuthenticated() => NotAuthorizedException(
    code: AppErrorCode.notAuthenticated,
    message: 'Please sign in to continue.',
  );

  static NotAuthorizedException notAuthorized([
    String message = 'You do not have access to this.',
  ]) => NotAuthorizedException(
    code: AppErrorCode.notAuthorized,
    message: message,
  );

  static ValidationException validation(String message, {String? field}) =>
      ValidationException(
        code: AppErrorCode.validation,
        message: message,
        field: field,
      );

  static NotFoundException notFound(String what) => NotFoundException(
    code: AppErrorCode.notFound,
    message: '$what was not found.',
  );

  static ConflictException conflict(String message) =>
      ConflictException(code: AppErrorCode.conflict, message: message);

  static InvalidStateException invalidState(String message) =>
      InvalidStateException(code: AppErrorCode.invalidState, message: message);

  static RateLimitedException rateLimited({int? retryAfterSeconds}) =>
      RateLimitedException(
        code: AppErrorCode.rateLimited,
        message: 'Too many attempts. Please wait and try again.',
        retryAfterSeconds: retryAfterSeconds,
      );

  static InvalidStateException featureDisabled() => InvalidStateException(
    code: AppErrorCode.featureDisabled,
    message: 'This feature is not available yet.',
  );
}
