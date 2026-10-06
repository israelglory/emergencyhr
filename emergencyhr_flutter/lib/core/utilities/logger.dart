import 'dart:developer' as developer;

/// Debug logging. Never log health data or phone numbers.
class Console {
  static void log(String tag, Object? msg, {Object? error}) {
    developer.log('$msg', time: DateTime.now(), name: tag, error: error);
  }
}
