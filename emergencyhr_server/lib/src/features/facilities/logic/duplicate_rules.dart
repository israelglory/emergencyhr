/// Pure duplicate-facility detection: name similarity plus distance.
abstract final class DuplicateRules {
  /// Within this distance any reasonably similar name is a duplicate.
  static const nearbyMeters = 300.0;

  /// Within this distance only a near-identical name is a duplicate.
  static const sameNameMeters = 2000.0;

  static const _stopWords = {
    'hospital',
    'hospitals',
    'clinic',
    'clinics',
    'medical',
    'centre',
    'center',
    'specialist',
    'general',
    'the',
    'ltd',
    'limited',
    'and',
    'of',
    'nig',
    'nigeria',
  };

  static List<String> tokens(String name) => name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ')
      .split(RegExp(r'\s+'))
      .where((t) => t.isNotEmpty && !_stopWords.contains(t))
      .toList();

  /// 0 (different) to 1 (same).
  static double similarity(String a, String b) {
    final ta = tokens(a);
    final tb = tokens(b);
    if (ta.isEmpty || tb.isEmpty) {
      return a.trim().toLowerCase() == b.trim().toLowerCase() ? 1 : 0;
    }
    final sa = ta.toSet();
    final sb = tb.toSet();
    final jaccard = sa.intersection(sb).length / sa.union(sb).length;
    final ja = ta.join(' ');
    final jb = tb.join(' ');
    final maxLen = ja.length > jb.length ? ja.length : jb.length;
    final edit = maxLen == 0 ? 1.0 : 1 - _levenshtein(ja, jb) / maxLen;
    return jaccard > edit ? jaccard : edit;
  }

  /// Strong matches block creating a new facility.
  static bool isStrongMatch(double similarity, double distanceMeters) =>
      (distanceMeters <= nearbyMeters && similarity >= 0.5) ||
      (distanceMeters <= sameNameMeters && similarity >= 0.85);

  /// Weak matches are shown so the user can pick an existing listing.
  static bool isCandidate(double similarity, double distanceMeters) =>
      distanceMeters <= nearbyMeters ||
      (distanceMeters <= sameNameMeters && similarity >= 0.6);

  static int _levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    var prev = List<int>.generate(b.length + 1, (i) => i);
    for (var i = 0; i < a.length; i++) {
      final curr = List<int>.filled(b.length + 1, 0)..[0] = i + 1;
      for (var j = 0; j < b.length; j++) {
        final cost = a.codeUnitAt(i) == b.codeUnitAt(j) ? 0 : 1;
        curr[j + 1] = [
          curr[j] + 1,
          prev[j + 1] + 1,
          prev[j] + cost,
        ].reduce((x, y) => x < y ? x : y);
      }
      prev = curr;
    }
    return prev[b.length];
  }
}
