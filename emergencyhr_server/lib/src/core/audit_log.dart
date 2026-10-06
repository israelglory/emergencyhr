import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'clock.dart';

/// Records every admin and agent action with actor and time.
abstract final class AuditLog {
  static Future<void> record(
    Session session, {
    required int actorUserId,
    required String action,
    required String targetType,
    required int targetId,
    String? reason,
    Transaction? transaction,
  }) async {
    await AdminActionLog.db.insertRow(
      session,
      AdminActionLog(
        actorUserId: actorUserId,
        action: action,
        targetType: targetType,
        targetId: targetId,
        reason: reason,
        at: clock.now(),
      ),
      transaction: transaction,
    );
    session.log(
      'action=$action target=$targetType:$targetId actor=$actorUserId',
      level: LogLevel.info,
    );
  }
}
