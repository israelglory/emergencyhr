import 'dart:convert';

import 'package:emergencyhr_client/emergencyhr_client.dart';

/// Reads a hospital import file (CSV with a header row): source_ref, name,
/// type (public, private or mission), address, area, lat, lng. Extra
/// columns such as level are ignored. Files come from
/// `emergencyhr_server/tool/hospital_data/`.
abstract final class HospitalImportFile {
  static const requiredColumns = [
    'source_ref',
    'name',
    'type',
    'address',
    'area',
    'lat',
    'lng',
  ];

  static ({List<FacilityImportRow> rows, List<String> problems}) parse(
    List<int> bytes,
  ) {
    final lines = _csv(utf8.decode(bytes, allowMalformed: true));
    if (lines.isEmpty) {
      return (rows: const [], problems: const ['The file is empty.']);
    }
    final header = [for (final h in lines.first) h.trim().toLowerCase()];
    final missing = [
      for (final c in requiredColumns)
        if (!header.contains(c)) c,
    ];
    if (missing.isNotEmpty) {
      return (
        rows: const [],
        problems: ['Missing columns: ${missing.join(', ')}.'],
      );
    }
    String cell(List<String> line, String column) {
      final i = header.indexOf(column);
      return i < line.length ? line[i].trim() : '';
    }

    final rows = <FacilityImportRow>[];
    final problems = <String>[];
    for (final (i, line) in lines.skip(1).indexed) {
      if (line.every((c) => c.trim().isEmpty)) continue;
      final lat = double.tryParse(cell(line, 'lat'));
      final lng = double.tryParse(cell(line, 'lng'));
      final type = switch (cell(line, 'type').toLowerCase()) {
        'public' => FacilityType.public,
        'mission' => FacilityType.mission,
        'private' => FacilityType.private,
        _ => null,
      };
      if (lat == null || lng == null || type == null) {
        problems.add('Line ${i + 2}: check type, lat and lng.');
        continue;
      }
      rows.add(
        FacilityImportRow(
          sourceRef: cell(line, 'source_ref'),
          name: cell(line, 'name'),
          type: type,
          address: cell(line, 'address'),
          area: cell(line, 'area'),
          lat: lat,
          lng: lng,
        ),
      );
    }
    return (rows: rows, problems: problems);
  }

  /// Minimal CSV reader: commas, double-quoted cells, "" for a quote.
  static List<List<String>> _csv(String text) {
    final lines = <List<String>>[];
    var line = <String>[];
    final cell = StringBuffer();
    var quoted = false;
    for (var i = 0; i < text.length; i++) {
      final ch = text[i];
      if (quoted) {
        if (ch == '"') {
          if (i + 1 < text.length && text[i + 1] == '"') {
            cell.write('"');
            i++;
          } else {
            quoted = false;
          }
        } else {
          cell.write(ch);
        }
        continue;
      }
      switch (ch) {
        case '"':
          quoted = true;
        case ',':
          line.add(cell.toString());
          cell.clear();
        case '\r':
          break;
        case '\n':
          line.add(cell.toString());
          cell.clear();
          lines.add(line);
          line = <String>[];
        default:
          cell.write(ch);
      }
    }
    if (cell.isNotEmpty || line.isNotEmpty) {
      line.add(cell.toString());
      lines.add(line);
    }
    return lines;
  }
}
