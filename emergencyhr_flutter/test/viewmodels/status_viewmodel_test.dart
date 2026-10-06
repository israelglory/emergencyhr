import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/desk/status/status_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockStatusApi api;
  late MockFacilityApi facilities;
  late MockSnackbarService snackbar;

  StatusViewModel build({bool practice = false, int minutesSince = 5}) =>
      StatusViewModel(
        facilityId: 1,
        startInPractice: practice,
        statusApi: api,
        facilities: facilities,
        snackbar: snackbar,
        now: () => now.add(Duration(minutes: minutesSince - 5)),
      );

  setUp(() {
    api = MockStatusApi();
    facilities = MockFacilityApi();
    snackbar = MockSnackbarService();
    when(() => facilities.detail(1)).thenAnswer(
      (_) async => ok(detailFixture(status: statusFixture())),
    );
  });

  test(
    'Given a saved status, when loaded, then the draft matches it',
    () async {
      final vm = build();
      await vm.load();
      expect(vm.accepting, isTrue);
      expect(vm.erBeds, 3);
      expect(vm.hasChanges, isFalse);
      expect(vm.canConfirm, isTrue);
    },
  );

  test('Given ER beds at 0, then decrement is disabled', () async {
    when(() => facilities.detail(1)).thenAnswer(
      (_) async => ok(
        detailFixture(status: statusFixture().copyWith(erBedsFree: 0)),
      ),
    );
    final vm = build();
    await vm.load();
    expect(vm.decrementEr, isNull);
  });

  test('Given a change, when saving, then the update is sent and Still '
      'accurate is disabled until saved', () async {
    when(() => api.update(1, any())).thenAnswer(
      (_) async => ok(statusFixture().copyWith(accepting: false)),
    );
    final vm = build();
    await vm.load();
    vm.setAccepting(false);
    expect(vm.hasChanges, isTrue);
    expect(vm.onConfirm, isNull);
    await vm.save();
    final sent =
        verify(() => api.update(1, captureAny())).captured.single
            as StatusInput;
    expect(sent.accepting, isFalse);
    verify(() => snackbar.success(message: 'Status updated')).called(1);
  });

  test(
    'Given practice mode, when saving, then the practice endpoint is used',
    () async {
      when(() => api.practice(1, any())).thenAnswer((_) async => ok(true));
      final vm = build(practice: true);
      await vm.onReady();
      expect(vm.isPractice, isTrue);
      expect(vm.saveLabel, 'Send practice update');
      await vm.save();
      verify(() => api.practice(1, any())).called(1);
      verifyNever(() => api.update(any(), any()));
      vm.dispose();
    },
  );

  test('Given a 45 minute old status, then the age warns', () async {
    final vm = build(minutesSince: 45);
    await vm.load();
    expect(vm.ageTone, StatusTone.warning);
  });

  test(
    'Given a facility not yet live, then the not-public notice shows',
    () async {
      when(() => facilities.detail(1)).thenAnswer(
        (_) async => ok(detailFixture(stage: OnboardingStage.staffTrained)),
      );
      final vm = build();
      await vm.load();
      expect(vm.showNotLiveNotice, isTrue);
    },
  );
}
