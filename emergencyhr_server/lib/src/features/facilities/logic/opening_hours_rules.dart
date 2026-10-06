import '../../../generated/protocol.dart';

/// Opening hours are kept in Africa/Lagos time (UTC+1, no daylight saving).
abstract final class OpeningHoursRules {
  static const lagosOffset = Duration(hours: 1);

  /// Unknown hours count as open, so reminders still go out.
  static bool isOpen(OpeningHours? hours, DateTime utcNow) {
    if (hours == null || hours.alwaysOpen) return true;
    final local = utcNow.toUtc().add(lagosOffset);
    final minute = local.hour * 60 + local.minute;
    final today = local.weekday;
    final yesterday = today == 1 ? 7 : today - 1;
    for (final p in hours.periods) {
      final overnight = p.closeMinute <= p.openMinute;
      if (!overnight) {
        if (p.weekday == today &&
            minute >= p.openMinute &&
            minute < p.closeMinute) {
          return true;
        }
      } else {
        if (p.weekday == today && minute >= p.openMinute) return true;
        if (p.weekday == yesterday && minute < p.closeMinute) return true;
      }
    }
    return false;
  }

  static bool isValid(OpeningHours hours) {
    for (final p in hours.periods) {
      if (p.weekday < 1 || p.weekday > 7) return false;
      if (p.openMinute < 0 || p.openMinute >= 1440) return false;
      if (p.closeMinute < 0 || p.closeMinute > 1440) return false;
      if (p.openMinute == p.closeMinute) return false;
    }
    return hours.alwaysOpen || hours.periods.isNotEmpty;
  }
}
