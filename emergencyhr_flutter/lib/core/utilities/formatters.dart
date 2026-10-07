import 'package:intl/intl.dart';

/// Display formatting shared by viewmodels. Times are stored in UTC and shown
/// in Africa/Lagos time (UTC+1, no daylight saving).
abstract final class Formatters {
  static const lagosOffset = Duration(hours: 1);

  static DateTime toLagos(DateTime utc) => utc.toUtc().add(lagosOffset);

  /// +2348031234567 -> +234 803 123 4567
  static String phone(String e164) {
    final m = RegExp(r'^\+234(\d{3})(\d{3})(\d{4})$').firstMatch(e164);
    if (m == null) return e164;
    return '+234 ${m[1]} ${m[2]} ${m[3]}';
  }

  /// +2348031234567 -> 0803 ••• 4567, for contact lists.
  static String maskedPhone(String e164) {
    final m = RegExp(r'^\+234(\d{3})(\d{3})(\d{4})$').firstMatch(e164);
    if (m == null) return e164;
    return '0${m[1]} ••• ${m[3]}';
  }

  /// 1.2 MB, 340 KB.
  static String fileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1024).ceil()} KB';
  }

  /// Up to two capital letters for an avatar, from the name or the email.
  static String initials(String? name, String? email) {
    final n = name?.trim() ?? '';
    if (n.isNotEmpty) {
      return n
          .split(RegExp(r'\s+'))
          .take(2)
          .map((p) => p[0].toUpperCase())
          .join();
    }
    final e = email?.trim() ?? '';
    return e.isEmpty ? '?' : e[0].toUpperCase();
  }

  /// "Just now", "4 min ago", "2 h ago", "3 days ago".
  static String ago(DateTime then, DateTime now) {
    final diff = now.difference(then);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 48) return '${diff.inHours} h ago';
    return '${diff.inDays} days ago';
  }

  /// Email if known, else the formatted phone, else an empty string.
  static String contact({String? email, String? phone}) =>
      email ?? (phone == null ? '' : Formatters.phone(phone));

  /// Name, else email, else phone.
  static String person({String? name, String? email, String? phone}) =>
      name ?? contact(email: email, phone: phone);

  static String minutes(int value) => '$value min';

  static String distanceKm(double km) =>
      km < 1 ? '${(km * 1000).round()} m' : '${km.toStringAsFixed(1)} km';

  static String dateTime(DateTime utc) =>
      DateFormat('d MMM y, HH:mm').format(toLagos(utc));

  /// Audit times: "4 min ago" within a day, otherwise "7 Oct, 10:40".
  static String auditTime(DateTime utc, DateTime now) =>
      now.difference(utc) < const Duration(hours: 24)
      ? ago(utc, now)
      : DateFormat('d MMM, HH:mm').format(toLagos(utc));

  /// "10 Oct", for near dates such as invite expiry.
  static String dayMonth(DateTime utc) =>
      DateFormat('d MMM').format(toLagos(utc));

  static String date(DateTime utc) =>
      DateFormat('d MMM y').format(toLagos(utc));

  static String time(DateTime utc) => DateFormat('HH:mm').format(toLagos(utc));

  static String yesNo(bool value) => value ? 'Yes' : 'No';

  static String count(int value, String singular, [String? plural]) =>
      '$value ${value == 1 ? singular : (plural ?? '${singular}s')}';
}
