import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'create_account_viewmodel.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key, this.next});

  final String? next;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountViewModel>.reactive(
      viewModelBuilder: () => CreateAccountViewModel(next: next),
      builder: (context, model, _) => AppPage(
        title: CreateAccountViewModel.title,
        bottom: AppButton(
          title: model.primaryLabel,
          loading: model.isBusy,
          onPressed: model.continueStep,
          large: true,
        ),
        body: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.headline(model.heading),
              const SizedBox(height: AppSpacing.x1),
              AppText(model.explainer, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x3),
              ...switch (model.step) {
                CreateAccountStep.email => [
                  AppTextField(
                    label: 'Email',
                    hintText: 'you@example.com',
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    errorText: model.errorFor('email'),
                    onChanged: model.onChanged,
                    onSubmitted: (_) => model.continueStep(),
                    autofocus: true,
                  ),
                ],
                CreateAccountStep.code => [
                  AppTextField(
                    label: 'Code from the email',
                    controller: model.codeController,
                    keyboardType: TextInputType.number,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    errorText: model.errorFor('code'),
                    onChanged: model.onChanged,
                    onSubmitted: (_) => model.continueStep(),
                    autofocus: true,
                    large: true,
                  ),
                  const SizedBox(height: AppSpacing.x1),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton.text(
                      title: 'Send a new code',
                      onPressed: model.resendCode,
                    ),
                  ),
                ],
                CreateAccountStep.details => [
                  AppTextField(
                    label: 'Your name',
                    controller: model.nameController,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.name],
                    errorText: model.errorFor('name'),
                    onChanged: model.onChanged,
                    autofocus: true,
                  ),
                  const SizedBox(height: AppSpacing.x2),
                  AppTextField(
                    label: 'Password',
                    helperText: CreateAccountViewModel.passwordHint,
                    controller: model.passwordController,
                    obscureText: model.hidePassword,
                    autofillHints: const [AutofillHints.newPassword],
                    errorText: model.errorFor('password'),
                    onChanged: model.onChanged,
                    onSubmitted: (_) => model.continueStep(),
                    suffixIcon: IconButton(
                      tooltip: model.passwordToggleLabel,
                      icon: Icon(model.passwordIcon),
                      onPressed: model.togglePassword,
                    ),
                  ),
                ],
              },
              if (model.showBack) ...[
                const SizedBox(height: AppSpacing.x2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppButton.text(
                    title: 'Back',
                    icon: Icons.arrow_back,
                    onPressed: model.back,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
