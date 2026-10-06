import '../../../generated/protocol.dart';

/// A deterministic red-flag match.
class RedFlag {
  const RedFlag(this.rule, this.type, {this.crisis = false});

  final String rule;
  final EmergencyType type;

  /// Self-harm: show crisis guidance as well as Emergency.
  final bool crisis;
}

/// Rules are checked in order, most specific first (pregnancy and children
/// before general bleeding or breathing).
///
/// First red-flag layer: deterministic rules that run on every user message
/// before the model sees it. Kept deliberately broad: a false alarm costs a
/// tap, a miss can cost a life.
abstract final class RedFlagRules {
  static final _rules = <(String, EmergencyType, List<String>, bool)>[
    (
      'suicidal statement',
      EmergencyType.other,
      [
        r'kill (my ?self|myself)',
        r'end(ing)? (my life|it all)',
        r'suicid',
        r'want to die',
        r'don.?t want to (live|be alive)',
        r'take my (own )?life',
        r'hurt myself',
      ],
      true,
    ),
    (
      'pregnancy bleeding',
      EmergencyType.pregnancy,
      [
        r'pregnan\w*.{0,40}(bleed|blood|severe pain|water broke|fits?|convuls)',
        r'(bleed|bleeding|blood).{0,40}pregnan',
        r'(water|waters) (has |have )?broke',
        r'baby is coming',
        r'labou?r pains?',
      ],
      false,
    ),
    (
      'child emergency',
      EmergencyType.child,
      [
        r'(baby|child|toddler|infant|my son|my daughter).{0,30}(not breathing|choking|unconscious|fitting|convuls|swallowed)',
        r'(baby|child).{0,30}(very hot|high fever).{0,30}(fit|convuls|stiff)',
      ],
      false,
    ),
    (
      'chest pain',
      EmergencyType.chestPain,
      [
        r'chest (pain|tight|tightness|pressure|hurts?|hurting)',
        r'pain (in|on) (my|his|her|the) chest',
        r'heart attack',
        r'crushing pain',
        r'pain (spreading|going) (to|down) (my|his|her|the) (left )?arm',
      ],
      false,
    ),
    (
      'heavy bleeding',
      EmergencyType.severeBleeding,
      [
        r'(bleeding|blood) (a lot|heavily|badly|everywhere|won.?t stop|not stopping|can.?t stop)',
        r'(heavy|severe|serious|massive) bleeding',
        r'(won.?t|will not|can.?t|cannot) stop (the )?bleeding',
        r'losing (a lot of )?blood',
        r'deep cut',
        r'(stabbed|gunshot|shot)',
      ],
      false,
    ),
    (
      'difficulty breathing',
      EmergencyType.breathingDifficulty,
      [
        r'(can.?t|cannot|can not|unable to|struggling to|hard to|difficult(y)? (to )?) ?breath',
        r'(not|isn.?t|stopped) breathing',
        r'short(ness)? of breath',
        r'gasping',
        r'choking',
        r'lips (are )?(turning )?(blue|grey|gray)',
        r'asthma attack',
      ],
      false,
    ),
    (
      'unconscious',
      EmergencyType.unconscious,
      [
        r'unconscious',
        r'passed out',
        r'fainted and',
        r'(not|isn.?t) (responding|waking|waking up)',
        r'(won.?t|will not|can.?t) wake',
        r'collapsed',
        r'unresponsive',
      ],
      false,
    ),
    (
      'stroke signs',
      EmergencyType.other,
      [
        r'stroke',
        r'face (is )?(drooping|droop|fallen)',
        r'slurred speech',
        r'(speech|talking) (is )?slurred',
        r'(one side|half) of (my|his|her|the) (face|body) (is )?(numb|weak|drooping)',
        r'sudden (weakness|numbness)',
      ],
      false,
    ),
    (
      'seizure',
      EmergencyType.other,
      [
        r'seizure',
        r'convuls',
        r'\b(having|had|has|having a|had a|has a|is having) fits?\b',
        r'\bfitting\b',
        r'jerking and',
        r'epileptic attack',
      ],
      false,
    ),
    (
      'burns',
      EmergencyType.burns,
      [
        r'(badly|severely|seriously) burn',
        r'burn(ed|t)? (all over|face|large)',
        r'caught fire',
        r'acid (attack|burn)',
      ],
      false,
    ),
    (
      'accident',
      EmergencyType.roadAccident,
      [
        r'(car|road|motor|bike|okada|keke|bus) (accident|crash)',
        r'hit by an? (car|bus|vehicle|okada|keke|lorry|truck)',
        r'knocked down by',
      ],
      false,
    ),
    (
      'poisoning or overdose',
      EmergencyType.other,
      [
        r'overdos',
        r'poison',
        r'drank (bleach|kerosene|petrol|sniper|insecticide)',
        r'swallowed (pills|tablets|bleach|chemical)',
        r'snake ?bite',
        r'bitten by a snake',
      ],
      false,
    ),
  ];

  static final _compiled = [
    for (final (name, type, patterns, crisis) in _rules)
      (
        name,
        type,
        [for (final p in patterns) RegExp(p, caseSensitive: false)],
        crisis,
      ),
  ];

  static final _negation = RegExp(
    r"\b(no|not|never|without|denies|deny|don't have|do not have|isn't)\s+(\w+\s+){0,2}$",
    caseSensitive: false,
  );

  /// The first matching rule, or null. Ignores simple negations such as
  /// "no chest pain".
  static RedFlag? evaluate(String text) {
    final normalised = text.replaceAll('’', "'");
    for (final (name, type, patterns, crisis) in _compiled) {
      for (final p in patterns) {
        for (final m in p.allMatches(normalised)) {
          final before = normalised.substring(0, m.start);
          final window = before.length > 40
              ? before.substring(before.length - 40)
              : before;
          if (_negation.hasMatch(window) && !crisis) continue;
          return RedFlag(name, type, crisis: crisis);
        }
      }
    }
    return null;
  }

  /// Parses the model's structured flag line: `[[flag:none]]` or
  /// `[[flag:chestPain]]`. Unknown types count as `other`.
  static ({EmergencyType? type, bool found}) parseModelFlag(String line) {
    final m = RegExp(r'^\s*\[\[flag:\s*([A-Za-z]+)\s*\]\]').firstMatch(line);
    if (m == null) return (type: null, found: false);
    final value = m.group(1)!;
    if (value.toLowerCase() == 'none') return (type: null, found: true);
    final type = EmergencyType.values
        .where((t) => t.name.toLowerCase() == value.toLowerCase())
        .firstOrNull;
    return (type: type ?? EmergencyType.other, found: true);
  }
}
