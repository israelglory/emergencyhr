import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/local/emergency_cache.dart';
import 'package:emergencyhr_flutter/data/models/route_args.dart';
import 'package:emergencyhr_flutter/presentation/emergency/results/results_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockEmergencyApi api;
  late MockEmergencyCache cache;
  late EmergencySessionService emergency;
  late MockNavigationService navigation;
  late MockPhoneCallService calls;
  late MockLauncherService launcher;

  const args = EmergencyResultsArgs(
    lat: 6.6,
    lng: 3.35,
    type: EmergencyType.roadAccident,
  );

  ResultsViewModel build({int minutesLater = 0}) => ResultsViewModel(
    args: args,
    api: api,
    cache: cache,
    emergency: emergency,
    navigation: navigation,
    launcher: launcher,
    calls: calls,
    snackbar: MockSnackbarService(),
    now: () => now.add(Duration(minutes: minutesLater)),
  );

  setUp(() {
    api = MockEmergencyApi();
    cache = MockEmergencyCache();
    emergency = EmergencySessionService();
    navigation = MockNavigationService();
    calls = MockPhoneCallService();
    launcher = MockLauncherService();
    when(() => cache.save(any())).thenAnswer((_) async {});
    when(() => api.watch(any(), any())).thenAnswer((_) => silentStream());
    when(
      () => api.recordAction(
        any(),
        any(),
        any(),
        facilityId: any(named: 'facilityId'),
      ),
    ).thenAnswer((_) async => ok(true));
    when(
      () => navigation.pushNamed<void>(any(), args: any(named: 'args')),
    ).thenAnswer((_) async {});
    when(
      () => calls.callNumber(
        number: any(named: 'number'),
        title: any(named: 'title'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async => true);
  });

  void serve(EmergencySearch search) {
    when(
      () => api.start(
        lat: any(named: 'lat'),
        lng: any(named: 'lng'),
        type: any(named: 'type'),
        area: any(named: 'area'),
        tappedAt: any(named: 'tappedAt'),
      ),
    ).thenAnswer((_) async => ok(search));
  }

  test('Given ranked results, then rows show the freshness label', () async {
    serve(searchFixture());
    final vm = build();
    await vm.onReady();
    expect(
      vm.rows.single.status,
      'Accepting emergencies. Confirmed 4 min ago.',
    );
    expect(vm.rows.single.tone, StatusTone.positive);
    vm.dispose();
  });

  test('Given 40 minutes pass on screen, then the label turns stale without '
      'refetching', () async {
    serve(searchFixture());
    final vm = build(minutesLater: 40);
    await vm.onReady();
    expect(vm.rows.single.status, startsWith('Last confirmed 44 min ago'));
    expect(vm.rows.single.tone, StatusTone.warning);
    vm.dispose();
  });

  test(
    'Given paused or flagged hospitals, then they are hidden by default',
    () async {
      serve(
        searchFixture(
          results: [
            resultFixture(),
            resultFixture(id: 2, tier: 0, flagged: true),
          ],
        ),
      );
      final vm = build();
      await vm.onReady();
      expect(vm.rows, hasLength(1));
      expect(vm.hasHidden, isTrue);
      vm.toggleHidden();
      expect(vm.hiddenRows.single.status, 'Under review. Call before going.');
      vm.dispose();
    },
  );

  test(
    'Given no connection, then the last saved results show with a notice',
    () async {
      when(
        () => api.start(
          lat: any(named: 'lat'),
          lng: any(named: 'lng'),
          type: any(named: 'type'),
          area: any(named: 'area'),
          tappedAt: any(named: 'tappedAt'),
        ),
      ).thenAnswer((_) async => failed('offline', offline: true));
      when(() => cache.read()).thenReturn(CachedSearch(searchFixture(), now));
      final vm = build();
      await vm.onReady();
      expect(vm.isOffline, isTrue);
      expect(vm.offlineNotice, contains('saved at'));
      expect(vm.rows, hasLength(1));
      vm.dispose();
    },
  );

  test('Given nothing accepting, then Call 112 is prominent', () async {
    serve(searchFixture(call112: true, results: [resultFixture(tier: 3)]));
    final vm = build();
    await vm.onReady();
    expect(vm.showCall112, isTrue);
    vm.dispose();
  });

  test('Given a result, when Call is tapped, then the action is recorded, the '
      'number is called and next steps open', () async {
    serve(searchFixture());
    final vm = build();
    await vm.onReady();
    vm.rows.single.onCall!();
    await pumpEventQueue();
    verify(
      () => api.recordAction(10, 'token', EmergencyAction.call, facilityId: 1),
    ).called(1);
    verify(
      () => calls.callNumber(
        number: '+2348100000001',
        title: any(named: 'title'),
        message: any(named: 'message'),
      ),
    ).called(1);
    verify(
      () => navigation.pushNamed<void>(AppRoutes.emergencyAfter),
    ).called(1);
    expect(emergency.action, EmergencyAction.call);
    vm.dispose();
  });
}
