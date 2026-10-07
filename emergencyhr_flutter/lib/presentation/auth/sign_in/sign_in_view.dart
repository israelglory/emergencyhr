import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'sign_in_viewmodel.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key, this.next});

  final String? next;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(next: next),
      builder: (context, model, _) => AppPage(
        title: SignInViewModel.title,
        bottom: AppButton(
          title: 'Sign in',
          loading: model.isBusy,
          onPressed: model.signIn,
          large: true,
        ),
        body: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText.headline(SignInViewModel.heading),
              const SizedBox(height: AppSpacing.x1),
              const AppText(
                SignInViewModel.explainer,
                tone: AppTextTone.secondary,
              ),
              const SizedBox(height: AppSpacing.x3),
              AppTextField(
                label: 'Email',
                hintText: 'you@example.com',
                controller: model.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                errorText: model.errorFor('email'),
                onChanged: model.onChanged,
                autofocus: true,
              ),
              const SizedBox(height: AppSpacing.x2),
              AppTextField(
                label: 'Password',
                controller: model.passwordController,
                obscureText: model.hidePassword,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                errorText: model.errorFor('password'),
                onChanged: model.onChanged,
                onSubmitted: (_) => model.signIn(),
                suffixIcon: IconButton(
                  tooltip: model.passwordToggleLabel,
                  icon: Icon(model.passwordIcon),
                  onPressed: model.togglePassword,
                ),
              ),
              const SizedBox(height: AppSpacing.x1),
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton.text(
                  title: 'Forgot password?',
                  onPressed: model.forgotPassword,
                ),
              ),
              const SizedBox(height: AppSpacing.x3),
              const Divider(),
              const SizedBox(height: AppSpacing.x2),
              const AppText('New to Emergencyhr?', tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x1),
              AppButton.secondary(
                title: 'Create an account',
                icon: Icons.person_add_alt_outlined,
                onPressed: model.createAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
