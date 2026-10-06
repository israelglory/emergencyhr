import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Pure helpers for one-time codes. No database access.
abstract final class OtpCodes {
  static const length = 6;
  static const ttl = Duration(minutes: 5);
  static const maxAttempts = 5;
  static const resendCooldown = Duration(seconds: 30);

  static final _random = Random.secure();

  static String generate() =>
      List.generate(length, (_) => _random.nextInt(10)).join();

  /// HMAC of the code bound to the phone number, so a leaked hash cannot be
  /// replayed for another number.
  static String hash(String code, String phone, String pepper) {
    final hmac = Hmac(sha256, utf8.encode(pepper));
    return hmac.convert(utf8.encode('$phone:$code')).toString();
  }

  /// Constant-time comparison of two hex hashes.
  static bool matches(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}
