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

  /// "Just now", "4 min ago", "2 h ago", "3 days ago".
  static String ago(DateTime then, DateTime now) {
    final diff = now.difference(then);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 48) return '${diff.inHours} h ago';
    return '${diff.inDays} days ago';
  }

  static String minutes(int value) => '$value min';

  static String distanceKm(double km) =>
      km < 1 ? '${(km * 1000).round()} m' : '${km.toStringAsFixed(1)} km';

  static String dateTime(DateTime utc) =>
      DateFormat('d MMM y, HH:mm').format(toLagos(utc));

  static String date(DateTime utc) =>
      DateFormat('d MMM y').format(toLagos(utc));

  static String time(DateTime utc) => DateFormat('HH:mm').format(toLagos(utc));

  static String yesNo(bool value) => value ? 'Yes' : 'No';

  static String count(int value, String singular, [String? plural]) =>
      '$value ${value == 1 ? singular : (plural ?? '${singular}s')}';
}
