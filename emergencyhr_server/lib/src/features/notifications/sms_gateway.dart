import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// Sends a plain SMS. Selected by `smsAdapter` in config/app_settings.yaml.
abstract class SmsGateway {
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  });
}

/// Logs messages to the server console instead of sending them.
class DevSmsGateway implements SmsGateway {
  const DevSmsGateway();

  @override
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  }) async {
    session.log('[DEV SMS] to $to: $message', level: LogLevel.info);
    return true;
  }
}

/// Termii (https://termii.com), widely used for SMS in Nigeria.
class TermiiSmsGateway implements SmsGateway {
  TermiiSmsGateway({required this.apiKey, required this.senderId});

  final String apiKey;
  final String senderId;

  static final _endpoint = Uri.parse('https://api.ng.termii.com/api/sms/send');

  @override
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  }) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.postUrl(_endpoint);
      request.headers.contentType = ContentType.json;
      request.write(
        jsonEncode({
          'to': to.replaceFirst('+', ''),
          'from': senderId,
          'sms': message,
          'type': 'plain',
          'channel': 'generic',
          'api_key': apiKey,
        }),
      );
      final response = await request.close();
      await response.drain<void>();
      final ok = response.statusCode >= 200 && response.statusCode < 300;
      if (!ok) {
        session.log(
          'SMS send failed with status ${response.statusCode}',
          level: LogLevel.warning,
        );
      }
      return ok;
    } on Exception catch (e) {
      session.log('SMS send failed', level: LogLevel.warning, exception: e);
      return false;
    } finally {
      client.close();
    }
  }
}
