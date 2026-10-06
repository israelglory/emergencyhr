import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../../features/notifications/messaging.dart';
import '../../features/status/quick_update_service.dart';

/// Meta WhatsApp Cloud API webhook for quick status updates.
/// GET verifies the subscription; POST receives messages and is checked
/// against the X-Hub-Signature-256 HMAC.
class WhatsAppWebhookRoute extends Route {
  WhatsAppWebhookRoute() : super(methods: {Method.get, Method.post});

  static const _quick = QuickUpdateService();

  @override
  Future<Result> handleCall(Session session, Request request) async {
    if (request.method == Method.get) {
      final q = request.queryParameters.raw;
      final expected = session.passwords['whatsappVerifyToken'];
      if (expected != null &&
          q['hub.mode'] == 'subscribe' &&
          q['hub.verify_token'] == expected) {
        return Response.ok(body: Body.fromString(q['hub.challenge'] ?? ''));
      }
      return Response.forbidden();
    }

    final raw = await request.readAsString();
    final secret = session.passwords['whatsappAppSecret'];
    final signature = request.headers['x-hub-signature-256']?.firstOrNull;
    if (secret == null || !_validSignature(secret, raw, signature)) {
      return Response.forbidden();
    }

    try {
      final body = jsonDecode(raw) as Map<String, dynamic>;
      for (final entry in (body['entry'] as List? ?? const [])) {
        for (final change in ((entry as Map)['changes'] as List? ?? const [])) {
          final value = (change as Map)['value'] as Map? ?? const {};
          for (final m in (value['messages'] as List? ?? const [])) {
            final message = m as Map;
            if (message['type'] != 'text') continue;
            final from = message['from'] as String;
            final text = (message['text'] as Map)['body'] as String;
            final reply = await _quick.handle(
              session,
              fromPhone: from,
              text: text,
            );
            await Messaging.whatsApp(session).send(
              session,
              to: '+$from',
              message: reply,
            );
          }
        }
      }
    } on FormatException {
      return Response.badRequest();
    }
    // Always acknowledge so Meta does not retry.
    return Response.ok();
  }

  static bool _validSignature(String secret, String body, String? header) {
    if (header == null || !header.startsWith('sha256=')) return false;
    final digest = Hmac(sha256, utf8.encode(secret)).convert(utf8.encode(body));
    final expected = 'sha256=$digest';
    if (expected.length != header.length) return false;
    var diff = 0;
    for (var i = 0; i < expected.length; i++) {
      diff |= expected.codeUnitAt(i) ^ header.codeUnitAt(i);
    }
    return diff == 0;
  }
}
