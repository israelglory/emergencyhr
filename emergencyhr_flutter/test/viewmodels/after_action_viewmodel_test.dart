import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/emergency/after_action/after_action_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockProfileApi profile;
  late MockSessionService session;
  late MockFirstAidService firstAid;
  late MockLauncherService launcher;
  late EmergencySessionService emergency;

  setUp(() {
    profile = MockProfileApi();
    session = MockSessionService();
    firstAid = MockFirstAidService();
    launcher = MockLauncherService();
    emergency = EmergencySessionService()
      ..setSearch(searchFixture())
      ..setType(EmergencyType.roadAccident)
      ..setActed(resultFixture(), EmergencyAction.call);
    when(() => session.isSignedIn).thenReturn(true);
    when(() => firstAid.forType(any())).thenReturn(
      FirstAidCard(
        type: EmergencyType.roadAccident,
        title: 'Road accident',
        summary: 'Stay safe.',
        doSteps: ['Call 112'],
        dontSteps: ['Do not move them'],
        version: 1,
      ),
    );
    when(() => launcher.canComposeSms).thenReturn(true);
  });

  AfterActionViewModel build() => AfterActionViewModel(
    profile: profile,
    emergency: emergency,
    session: session,
    firstAid: firstAid,
    navigation: MockNavigationService(),
    launcher: launcher,
    calls: MockPhoneCallService(),
    snackbar: MockSnackbarService(),
    sheets: MockBottomSheetService(),
  );

  EmergencyContact contact() => EmergencyContact(
    id: 1,
    userId: 1,
    name: 'Mum',
    phone: '+2348030000000',
    channel: ContactChannel.sms,
  );

  test('Given a call, then the heading names the hospital and first aid '
      'matches the type', () {
    final vm = build();
    expect(vm.heading, 'Calling Seed Trauma Centre');
    expect(vm.firstAid!.title, 'Road accident');
  });

  test(
    'Given no contacts, then the family state asks to add contacts',
    () async {
      when(() => profile.contacts()).thenAnswer((_) async => ok([]));
      final vm = build();
      await vm.onReady();
      expect(vm.familyState, FamilyAlertState.noContacts);
    },
  );

  test('Given a failed send, then the phone SMS fallback is offered', () async {
    when(() => profile.contacts()).thenAnswer((_) async => ok([contact()]));
    when(() => profile.notifyFamily(10, 'token')).thenAnswer(
      (_) async => ok(
        FamilyAlertResult(
          message: 'Alert',
          results: [ContactAlertResult(name: 'Mum', phone: '+2348030000000')],
        ),
      ),
    );
    final vm = build();
    await vm.onReady();
    expect(vm.familyState, FamilyAlertState.ready);
    await vm.notifyFamily();
    expect(vm.familyState, FamilyAlertState.sent);
    expect(vm.alertRows.single.label, 'Not sent');
    expect(vm.showSmsFallback, isTrue);
  });

  test('Given a guest, then the family state asks to sign in', () {
    when(() => session.isSignedIn).thenReturn(false);
    expect(build().familyState, FamilyAlertState.signedOut);
  });
}
