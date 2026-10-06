import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/route_args.dart';
import 'verify_code_viewmodel.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key, this.args});

  final VerifyCodeArgs? args;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyCodeViewModel>.reactive(
      viewModelBuilder: () => VerifyCodeViewModel(args: args),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) => AppPage(
        title: 'Sign in',
        bottom: AppButton(
          title: 'Verify',
          loading: model.isBusy,
          onPressed: model.verify,
          large: true,
        ),
        body: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText.headline(VerifyCodeViewModel.heading),
              const SizedBox(height: AppSpacing.x1),
              AppText(model.sentToLabel, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x3),
              AppTextField(
                label: '6-digit code',
                controller: model.codeController,
                keyboardType: TextInputType.number,
                autofillHints: const [AutofillHints.oneTimeCode],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
                errorText: model.codeError,
                onChanged: model.onCodeChanged,
                onSubmitted: (_) => model.verify(),
                autofocus: true,
                large: true,
              ),
              const SizedBox(height: AppSpacing.x2),
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton.text(
                  title: model.resendLabel,
                  onPressed: model.onResend,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
