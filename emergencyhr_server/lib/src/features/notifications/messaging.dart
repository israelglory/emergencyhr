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
    if (AppConfig.instance.whatsappAdapter == AdapterKind.dev) {
      return const DevWhatsAppGateway();
    }
    final token = session.passwords['whatsappAccessToken'];
    final phoneId = session.passwords['whatsappPhoneNumberId'];
    if (token == null || phoneId == null) {
      session.log(
        'WhatsApp credentials missing; falling back to dev WhatsApp',
        level: LogLevel.warning,
      );
      return const DevWhatsAppGateway();
    }
    return MetaWhatsAppGateway(accessToken: token, phoneNumberId: phoneId);
  }

  static SmsGateway sms(Session session) {
    if (smsOverride != null) return smsOverride!;
    final config = AppConfig.instance;
    if (config.smsAdapter == AdapterKind.dev) return const DevSmsGateway();
    final apiKey = session.passwords['termiiApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      session.log(
        'termiiApiKey missing from passwords; falling back to dev SMS',
        level: LogLevel.warning,
      );
      return const DevSmsGateway();
    }
    return TermiiSmsGateway(apiKey: apiKey, senderId: config.smsSenderId);
  }
}
