import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../generated/protocol.dart';
import 'messaging.dart';

/// Sends SMS through the configured gateway and records every message, so
/// reminders can be rate limited per facility.
abstract final class Notifier {
  static Future<bool> sms(
    Session session, {
    required String to,
    required String message,
    required String kind,
    int? facilityId,
  }) async {
    final ok = await Messaging.sms(session).send(
      session,
      to: to,
      message: message,
    );
    await NotificationLog.db.insertRow(
      session,
      NotificationLog(
        facilityId: facilityId,
        toPhone: to,
        kind: kind,
        channel: ContactChannel.sms,
        success: ok,
        sentAt: clock.now(),
      ),
    );
    return ok;
  }

  /// WhatsApp first, SMS if WhatsApp fails.
  static Future<ContactChannel?> whatsAppOrSms(
    Session session, {
    required String to,
    required String message,
    required String kind,
    int? facilityId,
  }) async {
    final ok = await Messaging.whatsApp(session).send(
      session,
      to: to,
      message: message,
    );
    await NotificationLog.db.insertRow(
      session,
      NotificationLog(
        facilityId: facilityId,
        toPhone: to,
        kind: kind,
        channel: ContactChannel.whatsapp,
        success: ok,
        sentAt: clock.now(),
      ),
    );
    if (ok) return ContactChannel.whatsapp;
    final sms = await Notifier.sms(
      session,
      to: to,
      message: message,
      kind: kind,
      facilityId: facilityId,
    );
    return sms ? ContactChannel.sms : null;
  }

  /// True if a message of [kind] went to this facility within [window].
  static Future<bool> sentRecently(
    Session session, {
    required int facilityId,
    required String kind,
    required Duration window,
  }) async {
    final since = clock.now().subtract(window);
    final count = await NotificationLog.db.count(
      session,
      where: (t) =>
          t.facilityId.equals(facilityId) &
          t.kind.equals(kind) &
          (t.sentAt > since),
    );
    return count > 0;
  }
}
