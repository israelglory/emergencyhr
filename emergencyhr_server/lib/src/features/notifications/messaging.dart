import 'package:serverpod/serverpod.dart';

import '../../core/app_config.dart';
import 'sms_gateway.dart';
import 'whatsapp_gateway.dart';

/// Picks the configured adapters. Tests may override [smsOverride].
abstract final class Messaging {
  static SmsGateway? smsOverride;
  static WhatsAppGateway? whatsAppOverride;

  static WhatsAppGateway whatsApp(Session session) {
    if (whatsAppOverride != null) return whatsAppOverride!;
    switch (AppConfig.instance.whatsappAdapter) {
      case AdapterKind.dev:
        return const DevWhatsAppGateway();
      case AdapterKind.off:
        return const UnavailableWhatsAppGateway();
      case AdapterKind.live:
        break;
    }
    final token = session.passwords['whatsappAccessToken'];
    final phoneId = session.passwords['whatsappPhoneNumberId'];
    if (token == null || phoneId == null) {
      session.log(
        'WhatsApp credentials missing; WhatsApp messages are not sent',
        level: LogLevel.warning,
      );
      return const UnavailableWhatsAppGateway();
    }
    return MetaWhatsAppGateway(accessToken: token, phoneNumberId: phoneId);
  }

  static SmsGateway sms(Session session) {
    if (smsOverride != null) return smsOverride!;
    final config = AppConfig.instance;
    switch (config.smsAdapter) {
      case AdapterKind.dev:
        return const DevSmsGateway();
      case AdapterKind.off:
        return const UnavailableSmsGateway();
      case AdapterKind.live:
        break;
    }
    final apiKey = session.passwords['termiiApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      session.log(
        'termiiApiKey missing from passwords; SMS is not sent',
        level: LogLevel.warning,
      );
      return const UnavailableSmsGateway();
    }
    return TermiiSmsGateway(apiKey: apiKey, senderId: config.smsSenderId);
  }
}
