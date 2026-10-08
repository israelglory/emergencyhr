import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../../core/app_config.dart';
import '../../features/auth/otp_codes.dart';
import '../../features/telegram/telegram_bot_service.dart';
import '../../features/telegram/telegram_gateway.dart';

/// Telegram bot webhook. Telegram sends the secret derived from the bot
/// token in X-Telegram-Bot-Api-Secret-Token; anything else is refused.
class TelegramWebhookRoute extends Route {
  TelegramWebhookRoute() : super(methods: {Method.post});

  static const _bot = TelegramBotService();

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final token = session.passwords['telegramBotToken'];
    final sent =
        request.headers['x-telegram-bot-api-secret-token']?.firstOrNull ?? '';
    if (AppConfig.instance.telegramAdapter == AdapterKind.off ||
        token == null ||
        token.isEmpty ||
        !OtpCodes.matches(sent, TelegramGateway.webhookSecret(token))) {
      return Response.forbidden();
    }
    try {
      final update = jsonDecode(await request.readAsString());
      if (update is Map<String, dynamic>) await _bot.handle(session, update);
    } on Object catch (e, st) {
      // Telegram retries failed deliveries, so answer OK and log the error
      // (never the message itself).
      session.log(
        'Telegram update failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
    }
    return Response.ok();
  }
}
