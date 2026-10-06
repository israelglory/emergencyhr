import 'package:emergencyhr_server/src/features/assistant/ai_service.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart' show Session;
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

/// Replies with a fixed flag line and text.
class _FakeAi implements AiService {
  _FakeAi(this.flag);
  final String flag;

  @override
  Stream<AiChunk> reply(
    Session session, {
    required String system,
    required List<AiTurn> history,
  }) async* {
    yield AiText('[[flag:$flag]]\nRest and drink ');
    yield const AiText('water. See a doctor if it lasts.');
    yield const AiEnd(AiStop.complete);
  }
}

void main() {
  tearDown(() => AiProvider.override = null);

  withServerpod(
    'Given the Health Assistant',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test('when a guest sends a message then sign-in is required', () async {
        await expectLater(
          endpoints.assistant.send(sessionBuilder, 'Hello').toList(),
          throwsA(isA<NotAuthorizedException>()),
        );
      });

      test(
        'when the message is a red flag then the rules escalate first',
        () async {
          AiProvider.override = _FakeAi('none');
          final user = await createUser(
            sessionBuilder,
            phone: '+2348037770001',
          );
          final events = await endpoints.assistant
              .send(user.session, 'My father has crushing chest pain')
              .toList();
          expect(events.first.kind, ChatEventKind.started);
          expect(events[1].kind, ChatEventKind.redFlag);
          expect(events[1].emergencyType, EmergencyType.chestPain);
          expect(events.last.kind, ChatEventKind.done);
        },
      );

      test('when the model flags then a red flag event is sent and the flag '
          'line is hidden', () async {
        AiProvider.override = _FakeAi('breathingDifficulty');
        final user = await createUser(sessionBuilder, phone: '+2348037770002');
        final events = await endpoints.assistant
            .send(user.session, 'My mother is wheezing a little')
            .toList();
        expect(
          events
              .where((e) => e.kind == ChatEventKind.redFlag)
              .single
              .emergencyType,
          EmergencyType.breathingDifficulty,
        );
        final text = events
            .where((e) => e.kind == ChatEventKind.delta)
            .map((e) => e.text)
            .join();
        expect(text, isNot(contains('[[flag')));
        expect(text, startsWith('Rest and drink'));
      });

      test('when messages are stored then they are encrypted and only the '
          'owner can read or delete them', () async {
        AiProvider.override = _FakeAi('none');
        final owner = await createUser(sessionBuilder, phone: '+2348037770003');
        final other = await createUser(sessionBuilder, phone: '+2348037770004');
        final events = await endpoints.assistant
            .send(owner.session, 'How much water should I drink?')
            .toList();
        final id = events.first.conversationId!;
        final rows = await AiMessage.db.find(
          sessionBuilder.build(),
          where: (t) => t.conversationId.equals(id),
        );
        expect(rows, hasLength(2));
        expect(rows.first.contentEnc, isNot(contains('water')));
        final messages = await endpoints.assistant.messages(owner.session, id);
        expect(messages.first.content, 'How much water should I drink?');
        await expectLater(
          endpoints.assistant.messages(other.session, id),
          throwsA(isA<NotFoundException>()),
        );
        await endpoints.assistant.deleteConversation(owner.session, id);
        expect(await endpoints.assistant.conversations(owner.session), isEmpty);
      });
    },
  );
}
