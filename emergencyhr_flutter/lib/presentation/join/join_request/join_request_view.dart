import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'join_request_viewmodel.dart';

class JoinRequestView extends StatelessWidget {
  const JoinRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JoinRequestViewModel>.reactive(
      viewModelBuilder: JoinRequestViewModel.new,
      builder: (context, model, _) {
        if (model.sent) {
          return AppPage(
            title: JoinRequestViewModel.title,
            scrollable: false,
            body: EmptyState(
              icon: Icons.mark_email_read_outlined,
              title: JoinRequestViewModel.sentTitle,
              message: JoinRequestViewModel.sentMessage,
              actionLabel: 'Back to home',
              onAction: model.done,
            ),
          );
        }
        const gap = SizedBox(height: AppSpacing.x2);
        return AppPage(
          title: JoinRequestViewModel.title,
          bottom: AppButton(
            title: 'Send request',
            large: true,
            loading: model.isBusy,
            onPressed: model.submit,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText(
                JoinRequestViewModel.intro,
                tone: AppTextTone.secondary,
              ),
              const SizedBox(height: AppSpacing.x3),
              AppTextField(
                label: 'Hospital name',
                controller: model.hospitalController,
                textCapitalization: TextCapitalization.words,
                errorText: model.errorFor('hospitalName'),
              ),
              gap,
              AppTextField(
                label: 'Your name',
                controller: model.contactController,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                errorText: model.errorFor('contactName'),
              ),
              gap,
              AppTextField(
                label: 'Phone number',
                controller: model.phoneController,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                errorText: model.errorFor('phone'),
              ),
              gap,
              const AppText.label('Area'),
              const SizedBox(height: AppSpacing.x1),
              DropdownMenu<String>(
                initialSelection: model.area,
                expandedInsets: EdgeInsets.zero,
                onSelected: model.setArea,
                dropdownMenuEntries: [
                  for (final a in model.areaOptions)
                    DropdownMenuEntry(value: a, label: a),
                ],
              ),
              gap,
              AppTextField(
                label: 'Message (optional)',
                controller: model.messageController,
                maxLines: 4,
                minLines: 2,
                errorText: model.errorFor('message'),
              ),
            ],
          ),
        );
      },
    );
  }
}
