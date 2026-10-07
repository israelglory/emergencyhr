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
        bottom: AppButton(
          title: 'Sign in',
          loading: model.isBusy,
          onPressed: model.signIn,
        ),
        body: AutofillGroup(
          child: SectionColumn(
            gap: 18,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(SignInViewModel.heading),
                  SizedBox(height: AppSpacing.x1),
                  AppText(
                    SignInViewModel.explainer,
                    tone: AppTextTone.secondary,
                  ),
                ],
              ),
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
                  color: context.palette.textSecondary,
                  icon: Icon(model.passwordIcon),
                  onPressed: model.togglePassword,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton.text(
                  title: 'Forgot password?',
                  onPressed: model.forgotPassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.x1),
                child: AppCard(
                  child: Row(
                    children: [
                      const Expanded(
                        child: AppText.small(
                          SignInViewModel.newHere,
                          tone: AppTextTone.secondary,
                        ),
                      ),
                      AppButton.secondary(
                        title: 'Create an account',
                        size: AppButtonSize.small,
                        expand: false,
                        onPressed: model.createAccount,
                      ),
                    ],
                  ),
                ),
              ),
              AppButton.dangerOutline(
                title: 'Emergency, no account needed',
                size: AppButtonSize.medium,
                onPressed: model.startEmergency,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
