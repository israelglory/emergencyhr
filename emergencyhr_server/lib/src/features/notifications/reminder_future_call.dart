import 'package:serverpod/serverpod.dart';

import 'reminder_service.dart';

/// Runs every 5 minutes. Idempotent: each reminder kind is rate limited per
/// facility in [ReminderService], so a repeated or overlapping run sends
/// nothing twice.
class ReminderFutureCall extends FutureCall {
  static const identifier = 'reminders';

  Future<void> run(Session session) async {
    const reminders = ReminderService();
    try {
      final stale = await reminders.sendStaleReminders(session);
      final quiet = await reminders.sendQuietNewcomerAlerts(session);
      if (stale + quiet > 0) {
        session.log('reminders sent: stale=$stale quiet=$quiet');
      }
    } catch (e, st) {
      session.log(
        'Reminder run failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
    }
  }
}
