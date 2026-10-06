import 'dart:async';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/field_crypto.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import '../profile/first_aid_service.dart';
import 'ai_service.dart';
import 'logic/red_flag_rules.dart';
import 'system_prompt.dart';

/// Streams Health Assistant replies with two red-flag layers: deterministic
/// rules on the user's message, and a structured flag from the model.
class AssistantService {
  AssistantService();

  static const historyTurns = 20;
  static const crisisText =
      'If you are thinking about ending your life or hurting yourself, '
      'please call 112 now or talk to someone you trust. You are not alone.';
  static const failedText =
      'Sorry, the Health Assistant is not available right now. If this is '
      'urgent, use the Emergency button or call 112.';
  static const refusedText =
      'I cannot help with that here. If you are worried about your health, '
      'see a doctor, and in an emergency call 112.';

  final _limiter = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'assistant',
      source: 'user',
      maxAttempts: 30,
      timeframe: const Duration(hours: 1),
    ),
  );

  Future<AiConversation> _conversation(
    Session session,
    AppUser user,
    int? conversationId,
    String firstMessage,
  ) async {
    if (conversationId != null) {
      final c = await AiConversation.db.findById(session, conversationId);
      if (c == null || c.userId != user.id) {
        throw Errors.notFound('Conversation');
      }
      return c;
    }
    final title = firstMessage.length > 60
        ? '${firstMessage.substring(0, 57)}...'
        : firstMessage;
    return AiConversation.db.insertRow(
      session,
      AiConversation(
        userId: user.id!,
        title: title,
        createdAt: clock.now(),
        updatedAt: clock.now(),
      ),
    );
  }

  Stream<ChatEvent> send(
    Session session, {
    required AppUser user,
    int? conversationId,
    required String message,
  }) async* {
    final text = Validate.text(message, field: 'message', max: 2000);
    if (!await _limiter.tryRecordAttempt(session, key: '${user.id}')) {
      throw Errors.rateLimited(retryAfterSeconds: 600);
    }
    final crypto = FieldCrypto.fromSession(session);
    final conversation = await _conversation(
      session,
      user,
      conversationId,
      text,
    );
    yield ChatEvent(
      kind: ChatEventKind.started,
      conversationId: conversation.id,
    );

    // Layer 1: rules, before the model sees anything.
    final ruleFlag = RedFlagRules.evaluate(text);
    if (ruleFlag != null) {
      yield ChatEvent(
        kind: ChatEventKind.redFlag,
        conversationId: conversation.id,
        emergencyType: ruleFlag.type,
        crisis: ruleFlag.crisis,
      );
      session.log('assistant red flag (rule: ${ruleFlag.rule})');
    }

    await AiMessage.db.insertRow(
      session,
      AiMessage(
        conversationId: conversation.id!,
        role: ChatRole.user,
        contentEnc: await crypto.encrypt(text),
        redFlagDetected: ruleFlag != null,
        suggestedEmergencyType: ruleFlag?.type,
        createdAt: clock.now(),
      ),
    );

    final history = await _history(session, conversation.id!, crypto);
    final reply = StringBuffer();
    if (ruleFlag?.crisis ?? false) {
      reply.write('$crisisText\n\n');
      yield ChatEvent(
        kind: ChatEventKind.delta,
        conversationId: conversation.id,
        text: '$crisisText\n\n',
      );
    }

    // Layer 2: the model's structured flag on the first line.
    var head = '';
    var headDone = false;
    EmergencyType? modelFlag;
    var stop = AiStop.complete;
    await for (final chunk in AiProvider.of(session).reply(
      session,
      system: SystemPrompt.build(FirstAidService.cards()),
      history: history,
    )) {
      switch (chunk) {
        case AiText(:final text):
          if (headDone) {
            reply.write(text);
            yield ChatEvent(
              kind: ChatEventKind.delta,
              conversationId: conversation.id,
              text: text,
            );
            continue;
          }
          head += text;
          final newline = head.indexOf('\n');
          if (newline == -1 && head.length < 60) continue;
          headDone = true;
          final firstLine = newline == -1 ? head : head.substring(0, newline);
          final parsed = RedFlagRules.parseModelFlag(firstLine);
          final rest = parsed.found
              ? (newline == -1 ? '' : head.substring(newline + 1))
              : head;
          modelFlag = parsed.type;
          if (modelFlag != null && ruleFlag == null) {
            yield ChatEvent(
              kind: ChatEventKind.redFlag,
              conversationId: conversation.id,
              emergencyType: modelFlag,
              crisis: false,
            );
          }
          if (rest.isNotEmpty) {
            reply.write(rest);
            yield ChatEvent(
              kind: ChatEventKind.delta,
              conversationId: conversation.id,
              text: rest,
            );
          }
        case AiEnd(stop: final s):
          stop = s;
      }
    }
    if (!headDone && head.isNotEmpty) {
      final parsed = RedFlagRules.parseModelFlag(head);
      final rest = parsed.found ? '' : head;
      if (rest.isNotEmpty) {
        reply.write(rest);
        yield ChatEvent(
          kind: ChatEventKind.delta,
          conversationId: conversation.id,
          text: rest,
        );
      }
    }

    if (stop != AiStop.complete) {
      final fallback = stop == AiStop.refused ? refusedText : failedText;
      // A refused partial is discarded rather than kept as a complete answer.
      if (stop == AiStop.refused) reply.clear();
      reply.write(fallback);
      yield ChatEvent(
        kind: ChatEventKind.error,
        conversationId: conversation.id,
        text: fallback,
      );
    }

    final flagged = ruleFlag?.type ?? modelFlag;
    await AiMessage.db.insertRow(
      session,
      AiMessage(
        conversationId: conversation.id!,
        role: ChatRole.assistant,
        contentEnc: await crypto.encrypt(reply.toString().trim()),
        redFlagDetected: flagged != null,
        suggestedEmergencyType: flagged,
        createdAt: clock.now(),
      ),
    );
    await AiConversation.db.updateRow(
      session,
      conversation.copyWith(updatedAt: clock.now()),
    );
    yield ChatEvent(kind: ChatEventKind.done, conversationId: conversation.id);
  }

  Future<List<AiTurn>> _history(
    Session session,
    int conversationId,
    FieldCrypto crypto,
  ) async {
    final rows = await AiMessage.db.find(
      session,
      where: (t) => t.conversationId.equals(conversationId),
      orderBy: (t) => t.createdAt.desc(),
      limit: historyTurns,
    );
    final turns = <AiTurn>[];
    for (final m in rows.reversed) {
      final content = await crypto.decryptOptional(m.contentEnc) ?? '';
      if (content.isEmpty) continue;
      turns.add((
        role: m.role == ChatRole.user ? 'user' : 'assistant',
        content: content,
      ));
    }
    // The API needs the history to start with a user turn.
    while (turns.isNotEmpty && turns.first.role != 'user') {
      turns.removeAt(0);
    }
    return turns;
  }

  Future<List<AiConversation>> conversations(Session session, AppUser user) {
    return AiConversation.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      orderBy: (t) => t.updatedAt.desc(),
      limit: 50,
    );
  }

  Future<List<ChatMessageView>> messages(
    Session session,
    AppUser user,
    int conversationId,
  ) async {
    final c = await AiConversation.db.findById(session, conversationId);
    if (c == null || c.userId != user.id) throw Errors.notFound('Conversation');
    final crypto = FieldCrypto.fromSession(session);
    final rows = await AiMessage.db.find(
      session,
      where: (t) => t.conversationId.equals(conversationId),
      orderBy: (t) => t.createdAt,
    );
    return [
      for (final m in rows)
        ChatMessageView(
          id: m.id!,
          role: m.role,
          content: await crypto.decryptOptional(m.contentEnc) ?? '',
          redFlagDetected: m.redFlagDetected,
          suggestedEmergencyType: m.suggestedEmergencyType,
          createdAt: m.createdAt,
        ),
    ];
  }

  Future<void> delete(Session session, AppUser user, int conversationId) async {
    await AiConversation.db.deleteWhere(
      session,
      where: (t) => t.id.equals(conversationId) & t.userId.equals(user.id!),
    );
  }

  Future<void> deleteAll(Session session, AppUser user) async {
    await AiConversation.db.deleteWhere(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
  }
}
