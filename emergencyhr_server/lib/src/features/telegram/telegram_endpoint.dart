import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../generated/protocol.dart';
import 'telegram_bot_service.dart';

/// "Connect Telegram" for hospital staff. Who may call: hospital admins and
/// desk staff of any hospital.
class TelegramEndpoint extends Endpoint {
  static const _bot = TelegramBotService();

  Future<TelegramConnection> connection(Session session) async =>
      _bot.connection(
        session,
        await AuthGuard.requireRole(session, AuthGuard.staff),
      );

  /// A one-time link that opens the bot and connects this account. It
  /// expires in 15 minutes.
  Future<String> createLink(Session session) async => _bot.createLink(
    session,
    await AuthGuard.requireRole(session, AuthGuard.staff),
  );

  Future<void> disconnect(Session session) async => _bot.disconnect(
    session,
    await AuthGuard.requireRole(session, AuthGuard.staff),
  );
}
