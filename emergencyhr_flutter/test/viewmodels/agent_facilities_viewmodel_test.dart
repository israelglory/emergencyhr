import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/data/api/onboarding_api.dart';
import 'package:emergencyhr_flutter/presentation/agent/agent_facilities/agent_facilities_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _MockOnboardingApi extends Mock implements OnboardingApi {}

AgentFacility _item(int id, String name, String area, {String? address}) =>
    AgentFacility(
      facility: FacilitySummary(
        id: id,
        name: name,
        area: area,
        verificationStatus: VerificationStatus.seeded,
        onboardingStage: OnboardingStage.seeded,
      ),
      address: address ?? '1 Road, $area',
      checklistDone: 0,
      checklistTotal: 7,
      submitted: false,
    );

void main() {
  late _MockOnboardingApi api;

  Future<AgentFacilitiesViewModel> loaded(List<AgentFacility> items) async {
    when(() => api.myFacilities()).thenAnswer((_) async => ok(items));
    final vm = AgentFacilitiesViewModel(
      api: api,
      navigation: MockNavigationService(),
    );
    await vm.load();
    return vm;
  }

  setUp(() => api = _MockOnboardingApi());

  test('Given hospitals in two areas, when an area is picked, then only '
      'that area is listed and the count says so', () async {
    final vm = await loaded([
      _item(1, 'Alpha Hospital', 'Ikeja'),
      _item(2, 'Beta Clinic', 'Yaba'),
      _item(3, 'Gamma Hospital', 'Ikeja'),
    ]);
    expect(
      [for (final o in vm.areaOptions) o.value],
      [
        AgentFacilitiesViewModel.allAreas,
        'Ikeja',
        'Yaba',
      ],
    );
    vm.setArea('Ikeja');
    expect([for (final r in vm.rows) r.id], unorderedEquals([1, 3]));
    expect(vm.countLabel, '2 hospitals of 3');
  });

  test('Given a search, then name and address both match', () async {
    final vm = await loaded([
      _item(1, 'Alpha Hospital', 'Ikeja'),
      _item(2, 'Beta Clinic', 'Yaba', address: '5 Herbert Macaulay Way'),
    ]);
    vm.searchController.text = 'macaulay';
    vm.onSearchChanged('macaulay');
    expect([for (final r in vm.rows) r.id], [2]);
    vm.searchController.text = 'zzz';
    vm.onSearchChanged('zzz');
    expect(vm.noMatches, isTrue);
    vm.clearFilters();
    expect(vm.rows, hasLength(2));
  });

  test('Given 120 hospitals, then 50 show until Load more', () async {
    final vm = await loaded([
      for (var i = 1; i <= 120; i++) _item(i, 'Hospital $i', 'Alimosho'),
    ]);
    expect(vm.rows, hasLength(50));
    expect(vm.hasMore, isTrue);
    vm
      ..loadMore()
      ..loadMore();
    expect(vm.rows, hasLength(120));
    expect(vm.hasMore, isFalse);
  });
}
