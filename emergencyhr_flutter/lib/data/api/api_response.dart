import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../core/utilities/error_messages.dart';
import '../../core/utilities/logger.dart';

/// Result of an API call. Viewmodels check [success] and show [message].
class ApiResponse<T> {
  const ApiResponse.ok(T this.data)
    : success = true,
      message = null,
      errorCode = null,
      field = null,
      offline = false;

  const ApiResponse.failure({
    required String this.message,
    this.errorCode,
    this.field,
    this.offline = false,
  }) : success = false,
       data = null;

  final bool success;
  final T? data;
  final String? message;
  final AppErrorCode? errorCode;

  /// The input field that failed validation, if any.
  final String? field;
  final bool offline;

  /// For calls that return nothing: success carries `true`.
  static Future<ApiResponse<bool>> guardVoid(
    String tag,
    Future<void> Function() call,
  ) => guard(tag, () async {
    await call();
    return true;
  });

  /// Runs [call] and converts any error into a failed response.
  static Future<ApiResponse<T>> guard<T>(
    String tag,
    Future<T> Function() call,
  ) async {
    try {
      return ApiResponse.ok(await call());
    } catch (e) {
      Console.log(tag, 'call failed', error: e);
      final info = ErrorMessages.describe(e);
      return ApiResponse.failure(
        message: info.message,
        errorCode: info.code,
        field: info.field,
        offline: info.offline,
      );
    }
  }
}
