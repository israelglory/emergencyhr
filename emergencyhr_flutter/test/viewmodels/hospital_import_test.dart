import 'dart:convert';
import 'dart:io';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/api/admin_api.dart';
import 'package:emergencyhr_flutter/data/models/hospital_import_file.dart';
import 'package:emergencyhr_flutter/presentation/admin/directory/import_sheet/import_sheet_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _MockAdminApi extends Mock implements AdminApi {}

class _MockFiles extends Mock implements FilePickService {}

class _MockSheets extends Mock implements BottomSheetService {}

void main() {
  setUpAll(() {
    registerFallbacks();
    registerFallbackValue(<FacilityImportRow>[]);
  });

  group('Given a hospital import file', () {
    test('when cells have commas and quotes, then they are read correctly', () {
      const csv =
          'source_ref,name,type,address,area,lat,lng,level\n'
          'grid3:1,"St ""Mary"" Hospital",mission,"Sabo, Ogbomoso North LGA",'
          'Ogbomoso,8.13,4.24,Secondary\r\n'
          'grid3:2,Bad Row,unknown,Somewhere,Ikeja,x,3.3,\n';
      final parsed = HospitalImportFile.parse(utf8.encode(csv));
      expect(parsed.rows, hasLength(1));
      final row = parsed.rows.single;
      expect(row.name, 'St "Mary" Hospital');
      expect(row.address, 'Sabo, Ogbomoso North LGA');
      expect(row.type, FacilityType.mission);
      expect(parsed.problems.single, contains('Line 3'));
    });

    test('when a column is missing, then it says which', () {
      final parsed = HospitalImportFile.parse(
        utf8.encode('source_ref,name,area\ng:1,X,Ikeja\n'),
      );
      expect(parsed.rows, isEmpty);
      expect(parsed.problems.single, contains('type'));
    });

    test('the Lagos and Ogbomoso files in the server tools read cleanly', () {
      for (final name in ['lagos_hospitals.csv', 'ogbomoso_hospitals.csv']) {
        final file = File('../emergencyhr_server/tool/hospital_data/$name');
        final parsed = HospitalImportFile.parse(file.readAsBytesSync());
        expect(parsed.problems, isEmpty, reason: name);
        expect(parsed.rows, isNotEmpty, reason: name);
        expect(
          parsed.rows.map((r) => r.sourceRef).toSet(),
          hasLength(parsed.rows.length),
          reason: '$name has repeated source ids',
        );
      }
    });
  });

  test('Given a file of 300 hospitals, when previewed and imported, then it '
      'goes in batches of 250 and reports the totals', () async {
    final api = _MockAdminApi();
    final files = _MockFiles();
    final lines = [
      'source_ref,name,type,address,area,lat,lng',
      for (var i = 0; i < 300; i++)
        'g:$i,Hospital $i,private,Somewhere,Ikeja,6.6,3.35',
    ];
    when(() => files.pickCsv()).thenAnswer(
      (_) async => PickedDocument(
        name: 'lagos.csv',
        bytes: utf8.encode(lines.join('\n')),
      ),
    );
    when(
      () => api.importFacilities(any(), dryRun: any(named: 'dryRun')),
    ).thenAnswer((call) async {
      final rows = call.positionalArguments.first as List<FacilityImportRow>;
      return ok(
        FacilityImportSummary(
          dryRun: call.namedArguments[#dryRun] as bool,
          created: rows.length,
          alreadyImported: 0,
          possibleDuplicates: [],
          invalid: [],
        ),
      );
    });
    final vm = ImportSheetViewModel(
      api: api,
      files: files,
      sheets: _MockSheets(),
    );

    await vm.chooseFile();
    expect(vm.step, ImportStep.preview);
    expect(vm.importLabel, 'Import 300 hospitals');
    verify(() => api.importFacilities(any(), dryRun: true)).called(2);

    await vm.import();
    expect(vm.step, ImportStep.done);
    expect(vm.summaryLines.first, (label: 'Added', value: '300'));
    verify(() => api.importFacilities(any(), dryRun: false)).called(2);
  });
}
