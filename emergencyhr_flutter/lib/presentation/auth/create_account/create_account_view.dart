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
        title: model.stepTitle,
        bottom: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppButton(
              title: model.primaryLabel,
              loading: model.isBusy,
              onPressed: model.continueStep,
            ),
            if (model.showBack) ...[
              const SizedBox(height: AppSpacing.x1),
              AppButton.text(
                title: 'Back',
                color: context.palette.text,
                expand: true,
                onPressed: model.back,
              ),
            ],
          ],
        ),
        body: AutofillGroup(
          child: SectionColumn(
            gap: 18,
            children: [
              StepProgress(
                current: model.stepNumber,
                total: CreateAccountViewModel.stepCount,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(model.heading),
                  const SizedBox(height: AppSpacing.x1),
                  AppText(model.explainer, tone: AppTextTone.secondary),
                ],
              ),
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
                    label: 'Code',
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
                      color: context.palette.textSecondary,
                      icon: Icon(model.passwordIcon),
                      onPressed: model.togglePassword,
                    ),
                  ),
                ],
              },
            ],
          ),
        ),
      ),
    );
  }
}
