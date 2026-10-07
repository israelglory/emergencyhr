import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'reset_password_viewmodel.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(email: email),
      builder: (context, model, _) => AppPage(
        title: ResetPasswordViewModel.title,
        bottom: AppButton(
          title: model.primaryLabel,
          loading: model.isBusy,
          onPressed: model.continueStep,
          large: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.headline(model.heading),
            const SizedBox(height: AppSpacing.x1),
            AppText(model.explainer, tone: AppTextTone.secondary),
            const SizedBox(height: AppSpacing.x3),
            switch (model.step) {
              ResetStep.email => AppTextField(
                label: 'Email',
                controller: model.emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                errorText: model.errorFor('email'),
                onChanged: model.onChanged,
                onSubmitted: (_) => model.continueStep(),
                autofocus: true,
              ),
              ResetStep.code => AppTextField(
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
              ResetStep.password => AppTextField(
                label: 'New password',
                controller: model.passwordController,
                obscureText: true,
                autofillHints: const [AutofillHints.newPassword],
                errorText: model.errorFor('password'),
                onChanged: model.onChanged,
                onSubmitted: (_) => model.continueStep(),
                autofocus: true,
              ),
            },
          ],
        ),
      ),
    );
  }
}
