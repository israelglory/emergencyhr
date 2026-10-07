import 'package:emergencyhr_server/src/features/assistant/ai_service.dart';
import 'package:test/test.dart';

void main() {
  group('Given GeminiAiService', () {
    test('when the model is 2.5 then thinking is turned off', () {
      expect(GeminiAiService.thinkingFor('gemini-2.5-flash'), {
        'thinkingBudget': 0,
      });
    });

    test('when the model is newer then thinking is low', () {
      expect(GeminiAiService.thinkingFor('gemini-3.8-flash'), {
        'thinkingLevel': 'low',
      });
    });

    test('when the model is a moving alias then thinking is left default', () {
      expect(GeminiAiService.thinkingFor('gemini-flash-latest'), isNull);
    });

    test('when building a request then assistant turns become model turns '
        'and the system prompt is separate', () {
      final body = GeminiAiService.body(
        model: 'gemini-2.5-flash',
        system: 'Be brief.',
        history: [
          (role: 'user', content: 'Hi'),
          (role: 'assistant', content: 'Hello'),
          (role: 'user', content: 'Fever?'),
        ],
      );
      final contents = body['contents']! as List;
      expect(
        [for (final c in contents) (c as Map)['role']],
        [
          'user',
          'model',
          'user',
        ],
      );
      expect(
        ((body['system_instruction']! as Map)['parts'] as List).single,
        {'text': 'Be brief.'},
      );
    });
  });
}
