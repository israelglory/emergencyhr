import 'dart:convert';
import 'dart:io';

/// Downloads hospitals for Lagos and Ogbomoso from GRID3 (CC BY 4.0) and
/// writes import files for Admin, Directory, Import hospitals.
///
/// Run from emergencyhr_server: `dart run tool/hospital_data/fetch_grid3.dart`
///
/// Only hospital-level facilities are kept: health posts, primary health
/// centres, pharmacies, laboratories and facilities marked not functional
/// are left out, so nobody is sent somewhere that cannot take an emergency.
Future<void> main() async {
  final lagos = await _lagos();
  final ogbomoso = await _ogbomoso();
  _write('tool/hospital_data/lagos_hospitals.csv', lagos);
  _write('tool/hospital_data/ogbomoso_hospitals.csv', ogbomoso);
  stdout.writeln(
    'Lagos: ${lagos.length} hospitals. Ogbomoso: ${ogbomoso.length}.',
  );
}

const _v2 =
    'https://services3.arcgis.com/BU6Aadhn6tbBEdyk/arcgis/rest/services/'
    'GRID3_NGA_health_facilities_v2_0/FeatureServer/0/query';
const _v3 =
    'https://services3.arcgis.com/BU6Aadhn6tbBEdyk/arcgis/rest/services/'
    'GRID3_NGA_health_facility_v3_0/FeatureServer/0/query';

/// Names that are not emergency hospitals even when graded secondary.
final _notAHospital = RegExp(
  r'\b(primary health\w*|phc|health post|pharmac\w*|chemist|laborator\w*|'
  r'diagnos\w*|dental|dentist\w*|eye|optical|optometr\w*|dispensar\w*|'
  r'scan\w*|imaging|fertility|ivf|cosmetic|physiotherap\w*|rehab\w*)\b',
  caseSensitive: false,
);

typedef Row = ({
  String sourceRef,
  String name,
  String type,
  String address,
  String area,
  double lat,
  double lng,
  String level,
});

Future<List<Row>> _lagos() async {
  final features = await _query(
    _v2,
    "state='Lagos' AND facility_level IN ('Secondary','Tertiary')"
    " AND facility_level_option <> 'Health Post'",
  );
  final extra = await _query(
    _v2,
    "state='Lagos' AND facility_level_option = 'General Hospital'",
  );
  final seen = <String>{};
  final rows = <Row>[];
  for (final a in [...features, ...extra]) {
    final id = '${a['globalid']}';
    if (!seen.add(id)) continue;
    final name = _tidyName('${a['facility_name'] ?? ''}');
    final lat = (a['latitude'] as num?)?.toDouble();
    final lng = (a['longitude'] as num?)?.toDouble();
    if (name.isEmpty || lat == null || lng == null) continue;
    if (_notAHospital.hasMatch(name)) continue;
    final lga = _lgaName('${a['lga'] ?? ''}');
    final ward = _tidyName('${a['ward'] ?? ''}');
    rows.add((
      sourceRef: 'grid3-nga-v2:$id',
      name: name,
      type: _type('${a['ownership'] ?? ''}', '${a['ownership_type'] ?? ''}'),
      address: [
        if (ward.isNotEmpty) ward,
        '$lga LGA',
        'Lagos State',
      ].join(', '),
      area: _lagosArea(lga, lng),
      lat: lat,
      lng: lng,
      level: '${a['facility_level'] ?? ''}',
    ));
  }
  return rows;
}

Future<List<Row>> _ogbomoso() async {
  const lgas =
      "'Ogbomosho North','Ogbomosho South','Ogo Oluwa','Ori Ire',"
      "'Surulere'";
  final features = await _query(
    _v3,
    "state_standard='Oyo' AND lga_standard IN ($lgas)"
    " AND functional <> 'Not-Functional'",
  );
  const hospitalTypes = {
    'General Hospital',
    'Hospital',
    'Medical Center',
    'Teaching/Tertiary Hospital',
    'Specialized Hospital',
  };
  const notHospitalTypes = {
    'Diagnostic / Laboratory Center',
    'Health Post',
    'Unclassified',
    '',
  };
  final rows = <Row>[];
  for (final a in features) {
    final type = '${a['facility_type'] ?? ''}'.trim();
    final level = '${a['facility_level'] ?? ''}'.trim();
    final isHospital =
        hospitalTypes.contains(type) ||
        ((level == 'Secondary' || level == 'Tertiary') &&
            !notHospitalTypes.contains(type));
    if (!isHospital) continue;
    final name = _tidyName('${a['facility_name'] ?? ''}');
    final lat = (a['latitude'] as num?)?.toDouble();
    final lng = (a['longitude'] as num?)?.toDouble();
    if (name.isEmpty || lat == null || lng == null) continue;
    if (_notAHospital.hasMatch(name)) continue;
    final lga = '${a['lga_standard'] ?? ''}'.replaceAll(
      'Ogbomosho',
      'Ogbomoso',
    );
    final place = _tidyName(
      '${a['settlement_name'] ?? a['ward_standard'] ?? ''}',
    );
    rows.add((
      sourceRef: 'grid3-nga-v3:${a['unique_id']}',
      name: name,
      type: _type(
        '${a['facility_ownership'] ?? ''}',
        '${a['facility_ownership_type'] ?? ''}',
      ),
      address: [
        if (place.isNotEmpty) place,
        '$lga LGA',
        'Oyo State',
      ].join(', '),
      area: 'Ogbomoso',
      lat: lat,
      lng: lng,
      level: level,
    ));
  }
  return rows;
}

Future<List<Map<String, dynamic>>> _query(String url, String where) async {
  final client = HttpClient();
  final out = <Map<String, dynamic>>[];
  try {
    for (var offset = 0; ; offset += 1000) {
      final uri = Uri.parse(url).replace(
        queryParameters: {
          'where': where,
          'outFields': '*',
          'returnGeometry': 'false',
          'resultOffset': '$offset',
          'resultRecordCount': '1000',
          'orderByFields': 'OBJECTID',
          'f': 'json',
        },
      );
      final res = await (await client.getUrl(uri)).close();
      final body = jsonDecode(await res.transform(utf8.decoder).join());
      if (body is Map && body['error'] != null) {
        throw StateError('GRID3 query failed: ${body['error']}');
      }
      final features = [
        for (final f in (body['features'] as List))
          (f['attributes'] as Map).cast<String, dynamic>(),
      ];
      out.addAll(features);
      if (features.length < 1000) break;
    }
  } finally {
    client.close();
  }
  return out;
}

String _type(String ownership, String ownershipType) {
  final t = ownershipType.toLowerCase();
  if (t.contains('faith') || t.contains('mission') || t.contains('relig')) {
    return 'mission';
  }
  return ownership.toLowerCase() == 'public' ? 'public' : 'private';
}

/// The app's pilot areas where the LGA matches; otherwise the LGA itself.
String _lagosArea(String lga, double lng) => switch (lga) {
  'Ikeja' => 'Ikeja',
  'Lagos Mainland' => 'Yaba',
  'Surulere' => 'Surulere',
  'Ikorodu' => 'Ikorodu',
  // Victoria Island and Ikoyi sit west of Lekki Phase 1.
  'Eti-Osa' => lng < 3.455 ? 'Victoria Island' : 'Lekki',
  _ => lga,
};

String _lgaName(String raw) => switch (raw.trim()) {
  'Ajeromi/Ifelodun' => 'Ajeromi-Ifelodun',
  'Ifako/Ijaye' => 'Ifako-Ijaiye',
  'Ibeju/Lekki' => 'Ibeju-Lekki',
  'Oshodi/Isolo' => 'Oshodi-Isolo',
  final other => other,
};

/// "GENERAL HOSPITAL IKEJA" -> "General Hospital Ikeja"; mixed case is kept.
String _tidyName(String raw) {
  final s = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  final letters = s.replaceAll(RegExp(r'[^A-Za-z]'), '');
  final shouting =
      letters.isNotEmpty &&
      (letters == letters.toUpperCase() || letters == letters.toLowerCase());
  if (!shouting) return s;
  const keepUpper = {'LGA', 'LUTH', 'LASUTH', 'FMC', 'UCH', 'II', 'III', 'ENT'};
  return s
      .split(' ')
      .map((w) {
        if (keepUpper.contains(w.toUpperCase())) return w.toUpperCase();
        if (w.isEmpty) return w;
        return w[0].toUpperCase() + w.substring(1).toLowerCase();
      })
      .join(' ');
}

void _write(String path, List<Row> rows) {
  String cell(Object v) {
    final s = '$v';
    return s.contains(RegExp(r'[",\n]')) ? '"${s.replaceAll('"', '""')}"' : s;
  }

  rows.sort(
    (a, b) => a.area.compareTo(b.area) != 0
        ? a.area.compareTo(b.area)
        : a.name.compareTo(b.name),
  );
  final buffer = StringBuffer(
    'source_ref,name,type,address,area,lat,lng,level\n',
  );
  for (final r in rows) {
    buffer.writeln(
      [
        r.sourceRef,
        r.name,
        r.type,
        r.address,
        r.area,
        r.lat.toStringAsFixed(6),
        r.lng.toStringAsFixed(6),
        r.level,
      ].map(cell).join(','),
    );
  }
  File(path).writeAsStringSync(buffer.toString());
}
