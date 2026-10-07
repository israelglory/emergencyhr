import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/cores.dart';
import '../../../../data/api/admin_api.dart';
import '../../../../data/models/hospital_import_file.dart';

enum ImportStep { choose, preview, importing, done }

/// Import hospitals from a CSV file: choose, preview what would happen,
/// then import in small batches.
class ImportSheetViewModel extends BaseViewModel {
  ImportSheetViewModel({
    AdminApi? api,
    FilePickService? files,
    BottomSheetService? sheets,
  }) : _api = api ?? adminApi,
       _files = files ?? filePickService,
       _sheets = sheets ?? bottomSheetService;

  final AdminApi _api;
  final FilePickService _files;
  final BottomSheetService _sheets;

  /// Matches the server's limit per request.
  static const batchSize = 250;

  static const title = 'Import hospitals';
  static const intro =
      'Choose a CSV file of hospitals (for example from '
      'tool/hospital_data). They are added as unverified listings. You can '
      'verify each one in the Directory once you have checked it.';

  ImportStep _step = ImportStep.choose;
  String? _fileName;
  List<FacilityImportRow> _rows = const [];
  List<String> _fileProblems = const [];
  FacilityImportSummary? _summary;
  int _sent = 0;
  String? _problem;

  ImportStep get step => _step;

  /// Why the file could not be read or imported, if it could not.
  String? get problem => _problem;
  String get fileLabel => _fileName == null
      ? ''
      : '$_fileName · ${Formatters.count(_rows.length, 'hospital')}';
  String get progressLabel => 'Importing $_sent of ${_rows.length}';
  double get progress => _rows.isEmpty ? 0 : _sent / _rows.length;

  /// Lines of the preview or result, ready to show.
  List<({String label, String value})> get summaryLines {
    final s = _summary;
    if (s == null) return const [];
    return [
      (
        label: s.dryRun ? 'Will be added' : 'Added',
        value: '${s.created}',
      ),
      (label: 'Already imported', value: '${s.alreadyImported}'),
      (
        label: 'Possible duplicates skipped',
        value: '${s.possibleDuplicates.length}',
      ),
      (
        label: 'Rows that cannot be used',
        value: '${s.invalid.length + _fileProblems.length}',
      ),
    ];
  }

  /// The first few skipped rows, so the admin can see why.
  List<String> get details => [
    ..._fileProblems,
    ...?_summary?.invalid,
    ...?_summary?.possibleDuplicates.map((d) => 'Possible duplicate: $d'),
  ].take(8).toList();

  bool get canImport => (_summary?.created ?? 0) > 0;
  String get importLabel =>
      'Import ${Formatters.count(_summary?.created ?? 0, 'hospital')}';

  Future<void> chooseFile() async {
    _problem = null;
    final picked = await _files.pickCsv();
    if (picked == null) return;
    final parsed = HospitalImportFile.parse(picked.bytes);
    _fileName = picked.name;
    _rows = parsed.rows;
    _fileProblems = parsed.problems;
    if (_rows.isEmpty) {
      _problem = parsed.problems.isEmpty
          ? 'No hospitals found in this file.'
          : parsed.problems.first;
      notifyListeners();
      return;
    }
    await _run(dryRun: true);
  }

  Future<void> import() => _run(dryRun: false);

  Future<void> _run({required bool dryRun}) async {
    _problem = null;
    _sent = 0;
    if (!dryRun) _step = ImportStep.importing;
    notifyListeners();
    var created = 0;
    var already = 0;
    final duplicates = <String>[];
    final invalid = <String>[];
    final response = await runBusyFuture(() async {
      for (var start = 0; start < _rows.length; start += batchSize) {
        final batch = _rows.skip(start).take(batchSize).toList();
        final result = await _api.importFacilities(batch, dryRun: dryRun);
        if (!result.success) return result.message;
        final s = result.data!;
        created += s.created;
        already += s.alreadyImported;
        duplicates.addAll(s.possibleDuplicates);
        invalid.addAll([
          for (final i in s.invalid)
            i.replaceFirstMapped(
              RegExp(r'^Row (\d+)'),
              (m) => 'Row ${int.parse(m[1]!) + start}',
            ),
        ]);
        _sent = start + batch.length;
        notifyListeners();
      }
      return null;
    }());
    if (response != null) {
      _problem = response;
      _step = dryRun ? ImportStep.choose : ImportStep.preview;
      notifyListeners();
      return;
    }
    _summary = FacilityImportSummary(
      dryRun: dryRun,
      created: created,
      alreadyImported: already,
      possibleDuplicates: duplicates,
      invalid: invalid,
    );
    _step = dryRun ? ImportStep.preview : ImportStep.done;
    notifyListeners();
  }

  void close() => _sheets.dismiss<bool>(_step == ImportStep.done);
}
