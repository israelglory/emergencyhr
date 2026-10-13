import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/presentation/admin/directory/directory_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockAdminApi api;
  late MockDialogService dialogs;
  late MockSnackbarService snackbar;

  DirectoryViewModel build() => DirectoryViewModel(
    api: api,
    navigation: MockNavigationService(),
    dialogs: dialogs,
    snackbar: snackbar,
  );

  setUp(() {
    api = MockAdminApi();
    dialogs = MockDialogService();
    snackbar = MockSnackbarService();
    when(
      () => api.directory(
        query: any(named: 'query'),
        area: any(named: 'area'),
        unverifiedOnly: any(named: 'unverifiedOnly'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => ok(<DirectoryRow>[]));
    when(
      () => dialogs.confirm(
        title: any(named: 'title'),
        message: any(named: 'message'),
        confirmLabel: any(named: 'confirmLabel'),
      ),
    ).thenAnswer((_) async => true);
    when(
      () => snackbar.success(message: any(named: 'message')),
    ).thenReturn(null);
  });

  test(
    'Given 250 hospitals selected in an area, when Verify is confirmed, '
    'then they are sent in batches of 100 and the total is reported',
    () async {
      final ids = [for (var i = 1; i <= 250; i++) i];
      when(
        () => api.directoryVerifiableIds(
          query: any(named: 'query'),
          area: 'Ikeja',
        ),
      ).thenAnswer((_) async => ok(ids));
      final batches = <int>[];
      when(() => api.verifyListings(any())).thenAnswer((call) async {
        final batch = call.positionalArguments.first as List<int>;
        batches.add(batch.length);
        return ok(
          BulkVerifySummary(
            verified: batch.length,
            alreadyVerified: 0,
            skipped: [],
          ),
        );
      });

      final vm = build();
      vm.setArea('Ikeja');
      await vm.selectAllVerifiable();
      expect(vm.selectionLabel, '250 selected');

      await vm.verifySelected();

      expect(batches, [100, 100, 50]);
      expect(vm.hasSelection, isFalse);
      verify(() => snackbar.success(message: '250 verified')).called(1);
    },
  );

  test('Given nothing is confirmed, then nothing is verified', () async {
    when(
      () => dialogs.confirm(
        title: any(named: 'title'),
        message: any(named: 'message'),
        confirmLabel: any(named: 'confirmLabel'),
      ),
    ).thenAnswer((_) async => false);
    final vm = build()..toggle(7);
    await vm.verifySelected();
    verifyNever(() => api.verifyListings(any()));
    expect(vm.hasSelection, isTrue);
  });
}
