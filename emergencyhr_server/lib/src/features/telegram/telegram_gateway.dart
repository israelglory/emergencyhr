import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../../core/app_config.dart';
import 'logic/bot_message.dart';

/// Talks to Telegram. Selected by `telegramAdapter` in app_settings.yaml.
abstract class TelegramGateway {
  Future<void> send(Session session, int chatId, BotMessage message);

  /// Replaces an earlier bot message (used when a button is tapped).
  Future<void> edit(
    Session session,
    int chatId,
    int messageId,
    BotMessage message,
  );

  /// Stops the button's loading spinner, optionally with a short toast.
  Future<void> answerTap(Session session, String tapId, {String? text});

  /// Picks the configured gateway. Tests set [override].
  static TelegramGateway? override;

  static TelegramGateway of(Session session) {
    if (override != null) return override!;
    if (AppConfig.instance.telegramAdapter != AdapterKind.live) {
      return const DevTelegramGateway();
    }
    final token = session.passwords['telegramBotToken'];
    if (token == null || token.isEmpty) {
      session.log(
        'telegramBotToken missing; Telegram replies are not sent',
        level: LogLevel.warning,
      );
      return const DevTelegramGateway();
    }
    return LiveTelegramGateway(token);
  }

  /// The secret Telegram sends with every webhook call, derived from the
  /// bot token so there is only one secret to manage.
  static String webhookSecret(String token) => Hmac(
    sha256,
    utf8.encode(token),
  ).convert(utf8.encode('emergencyhr-telegram-webhook')).toString();
}

/// Logs what the bot would send. Never logs search results' places.
class DevTelegramGateway implements TelegramGateway {
  const DevTelegramGateway();

  @override
  Future<void> send(Session session, int chatId, BotMessage message) async =>
      session.log('[DEV TELEGRAM] to $chatId: ${message.text}');

  @override
  Future<void> edit(
    Session session,
    int chatId,
    int messageId,
    BotMessage message,
  ) async => session.log('[DEV TELEGRAM] edit $chatId: ${message.text}');

  @override
  Future<void> answerTap(Session session, String tapId, {String? text}) async {}
}

/// The Telegram Bot API.
class LiveTelegramGateway implements TelegramGateway {
  const LiveTelegramGateway(this.token);

  final String token;

  @override
  Future<void> send(Session session, int chatId, BotMessage message) =>
      call(session, 'sendMessage', {'chat_id': chatId, ...message.toJson()});

  @override
  Future<void> edit(
    Session session,
    int chatId,
    int messageId,
    BotMessage message,
  ) {
    final json = message.toJson();
    // Only button rows can be kept when editing, not a phone keyboard.
    if (message.buttons.isEmpty) json.remove('reply_markup');
    return call(session, 'editMessageText', {
      'chat_id': chatId,
      'message_id': messageId,
      ...json,
    });
  }

  @override
  Future<void> answerTap(Session session, String tapId, {String? text}) =>
      call(session, 'answerCallbackQuery', {
        'callback_query_id': tapId,
        'text': ?text,
      });

  /// Calls one Bot API method. Returns the result, or null on failure.
  Future<Object?> call(
    Session? session,
    String method,
    Map<String, Object?> body,
  ) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.postUrl(
        Uri.https('api.telegram.org', '/bot$token/$method'),
      );
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
      final response = await request.close();
      final text = await response.transform(utf8.decoder).join();
      final json = jsonDecode(text) as Map<String, dynamic>;
      if (json['ok'] == true) return json['result'];
      // Telegram refuses edits that change nothing; that is not a problem.
      final description = json['description']?.toString() ?? '';
      if (!description.contains('message is not modified')) {
        session?.log(
          'Telegram $method failed: $description',
          level: LogLevel.warning,
        );
      }
      return null;
    } on Exception catch (e) {
      session?.log(
        'Telegram $method failed',
        level: LogLevel.warning,
        exception: e,
      );
      return null;
    } finally {
      client.close();
    }
  }

  /// Points Telegram at this server and sets the bot's command menu.
  /// Safe to repeat on every start.
  Future<bool> register(Session session, {required String webhookUrl}) async {
    final ok = await call(session, 'setWebhook', {
      'url': webhookUrl,
      'secret_token': TelegramGateway.webhookSecret(token),
      'allowed_updates': ['message', 'callback_query'],
    });
    await call(session, 'setMyCommands', {
      'commands': [
        {'command': 'start', 'description': 'Find a hospital near you'},
        {'command': 'area', 'description': 'Pick your area'},
        {'command': 'status', 'description': 'Update hospital status (staff)'},
      ],
    });
    await call(session, 'setMyShortDescription', {
      'short_description':
          'Find a hospital near you that can take a patient now. In danger? '
          'Call 112.',
    });
    await call(session, 'setMyDescription', {
      'description':
          'EmergencyHr shows hospitals near you ranked by who can receive a '
          'patient right now, with their phone numbers and directions.\n\n'
          'Tap Start, then share your location or pick your area.\n\n'
          'If someone is in immediate danger, call 112.',
    });
    return ok == true;
  }
}
