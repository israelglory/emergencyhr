@Tags(['live'])
library;

import 'dart:io';

import 'package:emergencyhr_server/src/features/assistant/ai_service.dart';
import 'package:emergencyhr_server/src/features/assistant/logic/red_flag_rules.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import '../integration/test_tools/serverpod_test_tools.dart';

/// Calls the real Gemini API. Skipped unless GEMINI_API_KEY is set:
/// `GEMINI_API_KEY=... dart test -t live`
void main() {
  final key = Platform.environment['GEMINI_API_KEY'];

  withServerpod('Given the live Gemini adapter', (sessionBuilder, _) {
    test(
      'when asked about chest pain then it streams a reply with a chest pain '
      'flag line',
      () async {
        final chunks =
            await GeminiAiService(
                  apiKey: key!,
                  models: ['gemini-2.5-flash', 'gemini-flash-latest'],
                )
                .reply(
                  sessionBuilder.build(),
                  system:
                      'The very first line of every reply must be [[flag:none]] or '
                      '[[flag:chestPain]], then a short answer on the next line.',
                  history: [
                    (
                      role: 'user',
                      content: 'My father has crushing chest pain',
                    ),
                  ],
                )
                .toList();
        final text = chunks.whereType<AiText>().map((c) => c.text).join();
        expect(chunks.last, isA<AiEnd>());
        expect((chunks.last as AiEnd).stop, AiStop.complete);
        final flag = RedFlagRules.parseModelFlag(text.split('\n').first);
        expect(flag.type, EmergencyType.chestPain, reason: text);
      },
      skip: key == null ? 'GEMINI_API_KEY not set' : false,
    );
  });
}
