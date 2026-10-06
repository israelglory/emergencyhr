import 'package:emergencyhr_client/emergencyhr_client.dart';

import '../../client.dart' as app;
import 'api_response.dart';

/// The Health Assistant. Replies stream token by token.
class AssistantApi {
  AssistantApi({Client? client}) : _clientOverride = client;

  final Client? _clientOverride;
  Client get _client => _clientOverride ?? app.client;
  static const _tag = 'AssistantApi';

  Stream<ChatEvent> send(String message, {int? conversationId}) =>
      _client.assistant.send(message, conversationId: conversationId);

  Future<ApiResponse<List<AiConversation>>> conversations() =>
      ApiResponse.guard(_tag, () => _client.assistant.conversations());

  Future<ApiResponse<List<ChatMessageView>>> messages(int conversationId) =>
      ApiResponse.guard(
        _tag,
        () => _client.assistant.messages(conversationId),
      );

  Future<ApiResponse<bool>> delete(int conversationId) => ApiResponse.guardVoid(
    _tag,
    () => _client.assistant.deleteConversation(conversationId),
  );

  Future<ApiResponse<bool>> deleteAll() => ApiResponse.guardVoid(
    _tag,
    () => _client.assistant.deleteAllConversations(),
  );
}
