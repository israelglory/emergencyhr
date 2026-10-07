import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/api/api_response.dart';
import 'package:emergencyhr_flutter/data/models/shell_kind.dart';
import 'package:emergencyhr_flutter/presentation/auth/create_account/create_account_viewmodel.dart';
import 'package:emergencyhr_flutter/presentation/auth/sign_in/sign_in_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockAuthApi api;
  late MockSessionService session;
  late MockNavigationService navigation;
  late MockSnackbarService snackbar;

  setUp(() {
    api = MockAuthApi();
    session = MockSessionService();
    navigation = MockNavigationService();
    snackbar = MockSnackbarService();
    when(() => session.refresh()).thenAnswer(
      (_) async => const ApiResponse.failure(message: 'unused'),
    );
    when(() => session.preferredShell).thenReturn(ShellKind.public);
    when(
      () => navigation.clearStackAndShow<void>(any()),
    ).thenAnswer((_) async {});
  });

  group('Given the sign-in screen', () {
    SignInViewModel build({String? next}) => SignInViewModel(
      next: next,
      api: api,
      session: session,
      navigation: navigation,
      snackbar: snackbar,
    );

    test('when the email is missing then it asks for it without calling the '
        'server', () async {
      final vm = build();
      vm.passwordController.text = 'secret123';
      await vm.signIn();
      expect(vm.errorFor('email'), isNotNull);
      verifyNever(() => api.signIn(any(), any()));
    });

    test(
      'when the password is wrong then the error shows on the password',
      () async {
        when(() => api.signIn(any(), any())).thenAnswer(
          (_) async => const ApiResponse.failure(
            message: 'That email and password do not match.',
            field: 'password',
          ),
        );
        final vm = build();
        vm.emailController.text = 'ada@example.com';
        vm.passwordController.text = 'wrong-pass';
        await vm.signIn();
        expect(
          vm.errorFor('password'),
          'That email and password do not match.',
        );
      },
    );

    test('when sign-in works then it returns to the page that asked', () async {
      when(() => api.signIn(any(), any())).thenAnswer((_) async => ok(true));
      final vm = build(next: AppRoutes.assistant);
      vm.emailController.text = 'ada@example.com';
      vm.passwordController.text = 'Correct-1';
      await vm.signIn();
      verify(
        () => navigation.clearStackAndShow<void>(AppRoutes.assistant),
      ).called(1);
    });
  });

  group('Given account creation', () {
    CreateAccountViewModel build() => CreateAccountViewModel(
      api: api,
      session: session,
      navigation: navigation,
      snackbar: snackbar,
    );

    test('when the steps are completed then the account is created, named, '
        'and the user is signed in', () async {
      final requestId = UuidValue.fromString(
        '0190a3c8-7d3e-7c4a-8b1e-1234567890ab',
      );
      when(
        () => api.startRegistration('ada@example.com'),
      ).thenAnswer((_) async => ok(requestId));
      when(
        () => api.verifyRegistrationCode(requestId, '123456'),
      ).thenAnswer((_) async => ok('token'));
      when(
        () => api.finishRegistration('token', 'Correct-horse'),
      ).thenAnswer((_) async => ok(true));
      when(() => api.updateName('Ada')).thenAnswer(
        (_) async => const ApiResponse.failure(message: 'unused'),
      );

      final vm = build();
      vm.emailController.text = 'ada@example.com';
      await vm.continueStep();
      expect(vm.step, CreateAccountStep.code);
      expect(vm.explainer, contains('ada@example.com'));

      vm.codeController.text = '123456';
      await vm.continueStep();
      expect(vm.step, CreateAccountStep.details);

      vm.nameController.text = 'Ada';
      vm.passwordController.text = 'Correct-horse';
      await vm.continueStep();
      verify(() => api.updateName('Ada')).called(1);
      verify(
        () => navigation.clearStackAndShow<void>(AppRoutes.home),
      ).called(1);
    });

    test(
      'when the password is too short then it is refused before sending',
      () async {
        final vm = build();
        vm.emailController.text = 'ada@example.com';
        when(() => api.startRegistration(any())).thenAnswer(
          (_) async => ok(
            UuidValue.fromString(
              '0190a3c8-7d3e-7c4a-8b1e-1234567890ab',
            ),
          ),
        );
        when(
          () => api.verifyRegistrationCode(any(), any()),
        ).thenAnswer((_) async => ok('token'));
        await vm.continueStep();
        vm.codeController.text = '1';
        await vm.continueStep();
        vm.nameController.text = 'Ada';
        vm.passwordController.text = 'short';
        await vm.continueStep();
        expect(vm.errorFor('password'), CreateAccountViewModel.passwordHint);
        verifyNever(() => api.finishRegistration(any(), any()));
      },
    );
  });
}
