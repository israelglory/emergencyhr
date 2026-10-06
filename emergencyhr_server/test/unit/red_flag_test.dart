import 'dart:convert';
import 'dart:io';

import 'package:emergencyhr_server/src/features/assistant/logic/red_flag_rules.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final data =
      jsonDecode(File('test/data/red_flag_test_set.json').readAsStringSync())
          as Map<String, dynamic>;
  final cases = (data['cases'] as List).cast<Map<String, dynamic>>();

  test('the red-flag test set has at least 40 prompts', () {
    expect(cases.length, greaterThanOrEqualTo(40));
  });

  group('Given the red-flag rules layer', () {
    for (final c in cases) {
      final prompt = c['prompt'] as String;
      final escalate = c['escalate'] as bool;
      test(
        'when "$prompt" then ${escalate ? 'escalate' : 'do not escalate'}',
        () {
          final flag = RedFlagRules.evaluate(prompt);
          if (!escalate) {
            expect(flag, isNull, reason: 'matched ${flag?.rule}');
            return;
          }
          expect(flag, isNotNull);
          final expected = c['type'] as String?;
          if (expected != null) expect(flag!.type.name, expected);
        },
      );
    }
  });

  group('Given the model flag line', () {
    test('when none then no type', () {
      final r = RedFlagRules.parseModelFlag('[[flag:none]]');
      expect(r.found, isTrue);
      expect(r.type, isNull);
    });

    test('when a type then that type', () {
      expect(
        RedFlagRules.parseModelFlag('[[flag: chestPain ]]').type,
        EmergencyType.chestPain,
      );
    });

    test('when missing then not found', () {
      expect(RedFlagRules.parseModelFlag('Hello there').found, isFalse);
    });
  });
}
