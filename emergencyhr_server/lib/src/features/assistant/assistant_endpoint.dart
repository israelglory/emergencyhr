import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../generated/protocol.dart';
import 'assistant_service.dart';

/// The Health Assistant. Who may call: signed-in users, for their own
/// conversations only. Rate limited.
class AssistantEndpoint extends Endpoint {
  static final _assistant = AssistantService();

  Stream<ChatEvent> send(
    Session session,
    String message, {
    int? conversationId,
  }) async* {
    final user = await AuthGuard.requireUser(session);
    yield* _assistant.send(
      session,
      user: user,
      conversationId: conversationId,
      message: message,
    );
  }

  Future<List<AiConversation>> conversations(Session session) async =>
      _assistant.conversations(session, await AuthGuard.requireUser(session));

  Future<List<ChatMessageView>> messages(
    Session session,
    int conversationId,
  ) async => _assistant.messages(
    session,
    await AuthGuard.requireUser(session),
    conversationId,
  );

  Future<void> deleteConversation(Session session, int conversationId) async =>
      _assistant.delete(
        session,
        await AuthGuard.requireUser(session),
        conversationId,
      );

  Future<void> deleteAllConversations(Session session) async =>
      _assistant.deleteAll(session, await AuthGuard.requireUser(session));
}
