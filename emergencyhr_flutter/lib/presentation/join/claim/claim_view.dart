import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/route_args.dart';
import 'claim_viewmodel.dart';

class ClaimView extends StatelessWidget {
  const ClaimView({super.key, this.args});

  final ClaimArgs? args;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClaimViewModel>.reactive(
      viewModelBuilder: () => ClaimViewModel(args: args),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        if (model.submitted) {
          return AppPage(
            title: model.title,
            scrollable: false,
            body: EmptyState(
              icon: Icons.mark_email_read_outlined,
              title: ClaimViewModel.submittedTitle,
              message: ClaimViewModel.submittedMessage,
              actionLabel: 'Back to home',
              onAction: model.done,
            ),
          );
        }
        return AppPage(
          title: model.title,
          bottom: AppButton(
            title: 'Send claim',
            large: true,
            loading: model.isBusy,
            onPressed: model.submit,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText(ClaimViewModel.intro, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x3),
              AppTextField(
                label: 'Your full name',
                controller: model.contactNameController,
                textCapitalization: TextCapitalization.words,
                errorText: model.contactError,
              ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Registration document'),
              for (final name in model.documentNames)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.x1),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined),
                      const SizedBox(width: AppSpacing.x1),
                      Expanded(child: AppText.label(name)),
                    ],
                  ),
                ),
              AppButton.secondary(
                title: model.addDocumentLabel,
                icon: Icons.upload_file_outlined,
                loading: model.isUploading,
                onPressed: model.addDocument,
              ),
              if (model.canUseCamera)
                AppButton.text(
                  title: 'Choose a file instead',
                  onPressed: model.addDocumentFile,
                ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader(
                'Desk phone check (recommended)',
                subtitle: 'Speeds up approval.',
              ),
              if (model.codeSent) ...[
                AppText(model.codeSentLabel, tone: AppTextTone.secondary),
                const SizedBox(height: AppSpacing.x1),
                AppTextField(
                  label: 'Code from the desk phone',
                  controller: model.deskCodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 6,
                  large: true,
                ),
              ] else
                AppButton.secondary(
                  title: 'Text a code to the listed desk phone',
                  icon: Icons.sms_outlined,
                  loading: model.isSendingCode,
                  onPressed: model.sendDeskCode,
                ),
            ],
          ),
        );
      },
    );
  }
}
