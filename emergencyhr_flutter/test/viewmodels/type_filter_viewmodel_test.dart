import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/presentation/emergency/type_filter/type_filter_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockNavigationService navigation;

  setUp(() => navigation = MockNavigationService());

  test('Given no filter yet, then All types is selected and nine types are '
      'offered', () {
    final vm = TypeFilterViewModel(
      current: EmergencyType.skipped,
      navigation: navigation,
    );
    expect(vm.allSelected, isTrue);
    expect(vm.options, hasLength(9));
    expect(vm.options.where((o) => o.selected), isEmpty);
  });

  test('When a type is tapped, then it is returned to the list', () {
    final vm = TypeFilterViewModel(
      current: EmergencyType.skipped,
      navigation: navigation,
    );
    vm.options.first.onTap();
    verify(
      () => navigation.pop<EmergencyType>(EmergencyType.roadAccident),
    ).called(1);
  });

  test('When Show all hospitals is tapped, then the filter is cleared', () {
    final vm = TypeFilterViewModel(
      current: EmergencyType.chestPain,
      navigation: navigation,
    );
    expect(vm.options.singleWhere((o) => o.selected).label, 'Chest pain');
    vm.showAll();
    verify(
      () => navigation.pop<EmergencyType>(EmergencyType.skipped),
    ).called(1);
  });
}
