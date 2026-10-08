import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// "Connect Telegram" for hospital staff, so they can update status from
/// the EmergencyHr Telegram bot.
class TelegramApi {
  TelegramApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'TelegramApi';

  Future<ApiResponse<TelegramConnection>> connection() =>
      ApiResponse.guard(_tag, () => _client.telegram.connection());

  /// A one-time link that opens the bot. It expires in 15 minutes.
  Future<ApiResponse<String>> createLink() =>
      ApiResponse.guard(_tag, () => _client.telegram.createLink());

  Future<ApiResponse<bool>> disconnect() =>
      ApiResponse.guardVoid(_tag, () => _client.telegram.disconnect());
}
