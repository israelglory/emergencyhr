import 'dart:convert';
import 'dart:io';

import '../../core/app_config.dart';
import '../../generated/protocol.dart';

/// Loads first-aid cards from `content/first_aid/`. Cached in memory.
class FirstAidService {
  FirstAidService._();

  static List<FirstAidCard>? _cache;

  static List<FirstAidCard> cards() {
    final cached = _cache;
    if (cached != null) return cached;
    final dir = Directory(AppConfig.instance.firstAidPath);
    if (!dir.existsSync()) return const [];
    final cards = <FirstAidCard>[
      for (final f in dir.listSync().whereType<File>())
        if (f.path.endsWith('.json'))
          FirstAidCard.fromJson(
            jsonDecode(f.readAsStringSync()) as Map<String, dynamic>,
          ),
    ]..sort((a, b) => a.type.index.compareTo(b.type.index));
    for (final c in cards) {
      if (c.doSteps.length > 6) {
        throw StateError('First-aid card ${c.type.name} has more than 6 steps');
      }
    }
    return _cache = cards;
  }

  static FirstAidCard? forType(EmergencyType type) =>
      cards().where((c) => c.type == type).firstOrNull;

  /// For tests.
  static void reset() => _cache = null;
}
