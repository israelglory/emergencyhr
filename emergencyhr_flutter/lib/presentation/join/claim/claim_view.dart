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
          return Scaffold(
            body: SafeArea(
              child: MessagePage(
                icon: Icons.check_rounded,
                tone: IconTileTone.positive,
                title: ClaimViewModel.submittedTitle,
                message: ClaimViewModel.submittedMessage,
                children: [
                  AppButton.secondary(
                    title: 'Back to home',
                    onPressed: model.done,
                  ),
                ],
              ),
            ),
          );
        }
        return AppPage(
          title: ClaimViewModel.title,
          bottom: AppButton(
            title: 'Send claim',
            loading: model.isBusy,
            onPressed: model.submit,
          ),
          body: SectionColumn(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(model.heading),
                  const SizedBox(height: AppSpacing.x1),
                  const AppText(
                    ClaimViewModel.intro,
                    tone: AppTextTone.secondary,
                  ),
                ],
              ),
              AppTextField(
                label: 'Your full name',
                controller: model.contactNameController,
                textCapitalization: TextCapitalization.words,
                errorText: model.contactError,
              ),
              SectionColumn(
                gap: AppSpacing.tight,
                children: [
                  const AppText.label('Registration document'),
                  if (model.hasDocuments)
                    AppListCard(
                      children: [
                        for (final d in model.documents)
                          DocumentRow(
                            name: d.name,
                            meta: d.meta,
                            onRemove: d.onRemove,
                          ),
                      ],
                    ),
                  DocumentButtons(
                    canUseCamera: model.canUseCamera,
                    loading: model.isUploading,
                    onPhotograph: model.photograph,
                    onUpload: model.upload,
                  ),
                ],
              ),
              AppCard(
                child: SectionColumn(
                  gap: AppSpacing.small,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.title(ClaimViewModel.deskTitle),
                        SizedBox(height: 3),
                        AppText.caption(ClaimViewModel.deskHint),
                      ],
                    ),
                    if (model.codeSent)
                      AppText.caption(model.codeSentLabel)
                    else
                      AppButton.secondary(
                        title: 'Text a code to the listed desk phone',
                        size: AppButtonSize.medium,
                        loading: model.isSendingCode,
                        onPressed: model.sendDeskCode,
                      ),
                    if (model.deskCodeFailed)
                      const NoticeBanner(
                        message: ClaimViewModel.deskFailed,
                        tone: StatusTone.warning,
                      ),
                    if (model.codeSent)
                      AppTextField(
                        label: 'Code',
                        hintText: '6 digits',
                        controller: model.deskCodeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                        large: true,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
