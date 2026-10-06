import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// Sends a WhatsApp text. Selected by `whatsappAdapter` in app_settings.yaml.
abstract class WhatsAppGateway {
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  });
}

class DevWhatsAppGateway implements WhatsAppGateway {
  const DevWhatsAppGateway();

  @override
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  }) async {
    session.log('[DEV WHATSAPP] to $to: $message', level: LogLevel.info);
    return true;
  }
}

/// Meta WhatsApp Cloud API. Free-form text works inside the 24 hour service
/// window; outside it the send fails and callers fall back to SMS.
class MetaWhatsAppGateway implements WhatsAppGateway {
  MetaWhatsAppGateway({required this.accessToken, required this.phoneNumberId});

  final String accessToken;
  final String phoneNumberId;

  @override
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  }) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.postUrl(
        Uri.https('graph.facebook.com', '/v20.0/$phoneNumberId/messages'),
      );
      request.headers
        ..contentType = ContentType.json
        ..set(HttpHeaders.authorizationHeader, 'Bearer $accessToken');
      request.write(
        jsonEncode({
          'messaging_product': 'whatsapp',
          'to': to.replaceFirst('+', ''),
          'type': 'text',
          'text': {'body': message},
        }),
      );
      final response = await request.close();
      await response.drain<void>();
      return response.statusCode >= 200 && response.statusCode < 300;
    } on Exception catch (e) {
      session.log(
        'WhatsApp send failed',
        level: LogLevel.warning,
        exception: e,
      );
      return false;
    } finally {
      client.close();
    }
  }
}
