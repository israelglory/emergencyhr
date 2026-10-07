import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/assistant/assistant_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(registerFallbacks);

  late MockAssistantApi api;
  late MockSessionService session;
  late MockNavigationService navigation;
  late MockLocationService location;
  late EmergencySessionService emergency;

  setUp(() {
    api = MockAssistantApi();
    session = MockSessionService();
    navigation = MockNavigationService();
    location = MockLocationService();
    emergency = EmergencySessionService();
    when(() => session.isSignedIn).thenReturn(true);
    when(() => api.conversations()).thenAnswer((_) async => ok([]));
    when(
      () => navigation.pushNamed<void>(any(), args: any(named: 'args')),
    ).thenAnswer((_) async {});
    when(
      () => location.current(),
    ).thenAnswer((_) async => const LocationFound(6.6, 3.35));
  });

  AssistantViewModel build() => AssistantViewModel(
    api: api,
    session: session,
    emergency: emergency,
    location: location,
    navigation: navigation,
    calls: MockPhoneCallService(),
    snackbar: MockSnackbarService(),
    dialogs: MockDialogService(),
  );

  test('Given a streamed reply with a red flag, then a red flag card appears '
      'before the reply text', () async {
    when(
      () => api.send(any(), conversationId: any(named: 'conversationId')),
    ).thenAnswer(
      (_) => Stream.fromIterable([
        ChatEvent(kind: ChatEventKind.started, conversationId: 5),
        ChatEvent(
          kind: ChatEventKind.redFlag,
          emergencyType: EmergencyType.chestPain,
          crisis: false,
        ),
        ChatEvent(kind: ChatEventKind.delta, text: 'Call 112 '),
        ChatEvent(kind: ChatEventKind.delta, text: 'now.'),
        ChatEvent(kind: ChatEventKind.done),
      ]),
    );
    final vm = build();
    vm.inputController.text = 'My chest hurts';
    vm.send();
    await pumpEventQueue();
    expect(vm.items[0], isA<ChatText>());
    expect(vm.items[1], isA<ChatRedFlag>());
    expect((vm.items[2] as ChatText).text, 'Call 112 now.');
    expect(vm.isReplying, isFalse);
    vm.dispose();
  });

  test('Given a red flag, when Find emergency care is tapped, then '
      'Hospitals near you opens for all types', () {
    final vm = build();
    vm.findCare();
    expect(emergency.type, EmergencyType.skipped);
    verify(() => navigation.pushNamed<void>(AppRoutes.emergency)).called(1);
    vm.dispose();
  });

  test('Given a stream error, then the reply shows a plain message', () async {
    when(
      () => api.send(any(), conversationId: any(named: 'conversationId')),
    ).thenAnswer((_) => Stream.error(Exception('boom')));
    final vm = build();
    vm.inputController.text = 'Hello';
    vm.send();
    await pumpEventQueue();
    expect((vm.items.last as ChatText).text, ErrorMessages.generic);
    vm.dispose();
  });
}
