import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../../core/app_config.dart';

/// One turn of conversation history sent to the model.
typedef AiTurn = ({String role, String content});

/// Why a reply stopped.
enum AiStop { complete, refused, failed }

sealed class AiChunk {
  const AiChunk();
}

class AiText extends AiChunk {
  const AiText(this.text);
  final String text;
}

class AiEnd extends AiChunk {
  const AiEnd(this.stop);
  final AiStop stop;
}

/// The Health Assistant's model behind an interface. Selected by
/// `aiAdapter` and `aiProvider` in config/app_settings.yaml.
abstract class AiService {
  Stream<AiChunk> reply(
    Session session, {
    required String system,
    required List<AiTurn> history,
  });
}

/// Runs without an API key. Gives safe, fixed guidance so the whole flow
/// can be tried locally.
class DevAiService implements AiService {
  const DevAiService();

  @override
  Stream<AiChunk> reply(
    Session session, {
    required String system,
    required List<AiTurn> history,
  }) async* {
    final last = history.isEmpty ? '' : history.last.content.toLowerCase();
    final flag = last.contains('pain') && last.contains('chest')
        ? 'chestPain'
        : 'none';
    final text =
        '[[flag:$flag]]\n'
        'This is the development assistant, so this answer is a fixed '
        'example. For general health questions, rest, drink water and watch '
        'how you feel. See a doctor if symptoms last more than two days or '
        'get worse. If you have severe pain, trouble breathing, heavy '
        'bleeding or feel faint, use the Emergency button now.';
    for (final word in text.split(' ')) {
      await Future<void>.delayed(const Duration(milliseconds: 15));
      yield AiText('$word ');
    }
    yield const AiEnd(AiStop.complete);
  }
}

/// Anthropic Messages API over HTTPS with server-sent events. Dart has no
/// official SDK, so this uses raw HTTP.
class AnthropicAiService implements AiService {
  AnthropicAiService({
    required this.apiKey,
    required this.model,
    required this.effort,
  });

  final String apiKey;
  final String model;
  final String effort;

  static final _endpoint = Uri.https('api.anthropic.com', '/v1/messages');

  @override
  Stream<AiChunk> reply(
    Session session, {
    required String system,
    required List<AiTurn> history,
  }) async* {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15);
    try {
      final request = await client.postUrl(_endpoint);
      request.headers
        ..contentType = ContentType.json
        ..set('x-api-key', apiKey)
        ..set('anthropic-version', '2023-06-01')
        // Re-runs a declined request on Anthropic's recommended fallback.
        ..set('anthropic-beta', 'server-side-fallback-2026-07-01');
      request.write(
        jsonEncode({
          'model': model,
          'max_tokens': 4096,
          'stream': true,
          'output_config': {'effort': effort},
          'fallbacks': 'default',
          'system': system,
          'messages': [
            for (final t in history) {'role': t.role, 'content': t.content},
          ],
        }),
      );
      final response = await request.close();
      if (response.statusCode != 200) {
        await response.drain<void>();
        session.log(
          'AI request failed with status ${response.statusCode}',
          level: LogLevel.warning,
        );
        yield const AiEnd(AiStop.failed);
        return;
      }

      var stop = AiStop.complete;
      var buffer = '';
      await for (final chunk in response.transform(utf8.decoder)) {
        buffer += chunk;
        while (true) {
          final end = buffer.indexOf('\n\n');
          if (end == -1) break;
          final event = buffer.substring(0, end);
          buffer = buffer.substring(end + 2);
          final dataLine = event
              .split('\n')
              .where((l) => l.startsWith('data:'))
              .map((l) => l.substring(5).trim())
              .join();
          if (dataLine.isEmpty) continue;
          final data = jsonDecode(dataLine) as Map<String, dynamic>;
          switch (data['type']) {
            case 'content_block_delta':
              final delta = data['delta'] as Map<String, dynamic>;
              if (delta['type'] == 'text_delta') {
                yield AiText(delta['text'] as String);
              }
            case 'message_delta':
              final reason = (data['delta'] as Map)['stop_reason'];
              if (reason == 'refusal') stop = AiStop.refused;
            case 'error':
              stop = AiStop.failed;
          }
        }
      }
      yield AiEnd(stop);
    } on Exception catch (e) {
      session.log('AI request failed', level: LogLevel.warning, exception: e);
      yield const AiEnd(AiStop.failed);
    } finally {
      client.close();
    }
  }
}

/// Google Gemini API over HTTPS with server-sent events (raw HTTP).
/// Tries each model in turn when one is overloaded or rate limited.
class GeminiAiService implements AiService {
  GeminiAiService({required this.apiKey, required this.models});

  final String apiKey;

  /// Primary model first, then fallbacks.
  final List<String> models;

  /// Finish reasons that mean Gemini's safety filters stopped the reply.
  static const _blocked = {
    'SAFETY',
    'PROHIBITED_CONTENT',
    'BLOCKLIST',
    'SPII',
    'RECITATION',
  };

  /// Keeps replies fast: thinking off on 2.5 models, low on newer ones,
  /// left to the default on moving aliases such as `gemini-flash-latest`.
  static Map<String, Object>? thinkingFor(String model) {
    if (model.startsWith('gemini-2.5')) return {'thinkingBudget': 0};
    if (RegExp(r'^gemini-\d').hasMatch(model)) return {'thinkingLevel': 'low'};
    return null;
  }

  static Map<String, Object> body({
    required String model,
    required String system,
    required List<AiTurn> history,
  }) {
    final thinking = thinkingFor(model);
    return {
      'system_instruction': {
        'parts': [
          {'text': system},
        ],
      },
      'contents': [
        for (final t in history)
          {
            'role': t.role == 'assistant' ? 'model' : 'user',
            'parts': [
              {'text': t.content},
            ],
          },
      ],
      'generationConfig': {
        'maxOutputTokens': 4096,
        'thinkingConfig': ?thinking,
      },
    };
  }

  @override
  Stream<AiChunk> reply(
    Session session, {
    required String system,
    required List<AiTurn> history,
  }) async* {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15);
    try {
      for (final model in models) {
        final request = await client.postUrl(
          Uri.https(
            'generativelanguage.googleapis.com',
            '/v1beta/models/$model:streamGenerateContent',
            {'alt': 'sse'},
          ),
        );
        request.headers
          ..contentType = ContentType.json
          ..set('x-goog-api-key', apiKey);
        request.write(
          jsonEncode(body(model: model, system: system, history: history)),
        );
        final response = await request.close();
        final status = response.statusCode;
        if (status == 429 || status >= 500) {
          await response.drain<void>();
          session.log(
            'Gemini $model unavailable (status $status), trying the next model',
            level: LogLevel.warning,
          );
          continue;
        }
        if (status != 200) {
          await response.drain<void>();
          session.log(
            'Gemini request failed with status $status',
            level: LogLevel.warning,
          );
          yield const AiEnd(AiStop.failed);
          return;
        }

        var stop = AiStop.complete;
        var buffer = '';
        await for (final chunk in response.transform(utf8.decoder)) {
          buffer += chunk.replaceAll('\r\n', '\n');
          while (true) {
            final end = buffer.indexOf('\n\n');
            if (end == -1) break;
            final event = buffer.substring(0, end);
            buffer = buffer.substring(end + 2);
            final dataLine = event
                .split('\n')
                .where((l) => l.startsWith('data:'))
                .map((l) => l.substring(5).trim())
                .join();
            if (dataLine.isEmpty) continue;
            final data = jsonDecode(dataLine) as Map<String, dynamic>;
            if ((data['promptFeedback'] as Map?)?['blockReason'] != null) {
              stop = AiStop.refused;
            }
            final candidates = data['candidates'] as List? ?? const [];
            if (candidates.isEmpty) continue;
            final candidate = candidates.first as Map<String, dynamic>;
            final parts =
                (candidate['content'] as Map?)?['parts'] as List? ?? const [];
            for (final part in parts) {
              final p = part as Map<String, dynamic>;
              // Thought summaries are never shown to users.
              if (p['thought'] == true) continue;
              final text = p['text'];
              if (text is String && text.isNotEmpty) yield AiText(text);
            }
            if (_blocked.contains(candidate['finishReason'])) {
              stop = AiStop.refused;
            }
          }
        }
        yield AiEnd(stop);
        return;
      }
      // Every model was overloaded.
      yield const AiEnd(AiStop.failed);
    } on Exception catch (e) {
      session.log(
        'Gemini request failed',
        level: LogLevel.warning,
        exception: e,
      );
      yield const AiEnd(AiStop.failed);
    } finally {
      client.close();
    }
  }
}

abstract final class AiProvider {
  static AiService? override;

  static AiService of(Session session) {
    if (override != null) return override!;
    final config = AppConfig.instance;
    if (config.aiAdapter == AdapterKind.dev) return const DevAiService();
    if (config.aiProvider == AiProviderKind.gemini) {
      final key = session.passwords['geminiApiKey'];
      if (key == null || key.isEmpty) {
        session.log(
          'geminiApiKey missing; using the development assistant',
          level: LogLevel.warning,
        );
        return const DevAiService();
      }
      return GeminiAiService(
        apiKey: key,
        models: [config.aiModel, ...config.aiFallbackModels],
      );
    }
    final key = session.passwords['anthropicApiKey'];
    if (key == null || key.isEmpty) {
      session.log(
        'anthropicApiKey missing; using the development assistant',
        level: LogLevel.warning,
      );
      return const DevAiService();
    }
    return AnthropicAiService(
      apiKey: key,
      model: config.aiModel,
      effort: config.aiEffort,
    );
  }
}
