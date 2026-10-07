import 'errors.dart';

/// Server-side input validation. Every endpoint validates its input here even
/// when the client validates too.
abstract final class Validate {
  static final _digits = RegExp(r'\D');

  /// Normalises a phone number to E.164. Nigerian local formats
  /// (0803..., 803..., 234803...) become +234803...
  static String phone(String input, {String field = 'phone'}) {
    final trimmed = input.trim();
    final digits = trimmed.replaceAll(_digits, '');
    String? normalised;
    if (digits.length == 11 && digits.startsWith('0')) {
      normalised = '+234${digits.substring(1)}';
    } else if (digits.length == 10 && RegExp(r'^[789]').hasMatch(digits)) {
      normalised = '+234$digits';
    } else if (digits.length == 13 && digits.startsWith('234')) {
      normalised = '+$digits';
    } else if (trimmed.startsWith('+') &&
        !digits.startsWith('234') &&
        digits.length >= 8 &&
        digits.length <= 15) {
      normalised = '+$digits';
    }
    if (normalised == null ||
        (normalised.startsWith('+234') &&
            !RegExp(r'^\+234[789]\d{9}$').hasMatch(normalised))) {
      throw Errors.validation('Enter a valid phone number.', field: field);
    }
    return normalised;
  }

  static String? optionalPhone(String? input, {String field = 'phone'}) {
    if (input == null || input.trim().isEmpty) return null;
    return phone(input, field: field);
  }

  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String email(String input, {String field = 'email'}) {
    final value = input.trim().toLowerCase();
    if (value.length > 254 || !_email.hasMatch(value)) {
      throw Errors.validation('Enter a valid email address.', field: field);
    }
    return value;
  }

  static String? optionalEmail(String? input, {String field = 'email'}) {
    if (input == null || input.trim().isEmpty) return null;
    return email(input, field: field);
  }

  static String text(
    String input, {
    required String field,
    int min = 1,
    int max = 200,
  }) {
    final value = input.trim();
    if (value.length < min) {
      throw Errors.validation('This field is required.', field: field);
    }
    if (value.length > max) {
      throw Errors.validation(
        'Keep this under $max characters.',
        field: field,
      );
    }
    return value;
  }

  static String? optionalText(
    String? input, {
    required String field,
    int max = 1000,
  }) {
    if (input == null || input.trim().isEmpty) return null;
    return text(input, field: field, max: max);
  }

  static void latitude(double lat) {
    if (lat.isNaN || lat < -90 || lat > 90) {
      throw Errors.validation('Latitude is out of range.', field: 'lat');
    }
  }

  static void longitude(double lng) {
    if (lng.isNaN || lng < -180 || lng > 180) {
      throw Errors.validation('Longitude is out of range.', field: 'lng');
    }
  }

  static void coordinates(double lat, double lng) {
    latitude(lat);
    longitude(lng);
  }

  static int count(int value, {required String field, int max = 10000}) {
    if (value < 0) {
      throw Errors.validation('This cannot be negative.', field: field);
    }
    if (value > max) {
      throw Errors.validation('This number is too large.', field: field);
    }
    return value;
  }

  static void otpCode(String code) {
    if (!RegExp(r'^\d{6}$').hasMatch(code.trim())) {
      throw Errors.validation('Enter the 6-digit code.', field: 'code');
    }
  }

  static ({int limit, int offset}) page(int limit, int offset) {
    if (limit < 1 || limit > 100) {
      throw Errors.validation('Page size must be 1 to 100.', field: 'limit');
    }
    if (offset < 0) {
      throw Errors.validation('Offset cannot be negative.', field: 'offset');
    }
    return (limit: limit, offset: offset);
  }
}
