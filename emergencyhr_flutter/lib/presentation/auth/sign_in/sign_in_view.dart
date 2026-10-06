import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          title: 'Send code',
          loading: model.isBusy,
          onPressed: model.sendCode,
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
                label: 'Phone number',
                hintText: '0803 123 4567',
                controller: model.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.telephoneNumber],
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d+ ]')),
                ],
                errorText: model.phoneError,
                onChanged: model.onPhoneChanged,
                onSubmitted: (_) => model.sendCode(),
                autofocus: true,
                large: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
