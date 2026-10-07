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
          return Scaffold(
            body: SafeArea(
              child: MessagePage(
                icon: Icons.check_rounded,
                tone: IconTileTone.positive,
                title: JoinRequestViewModel.sentTitle,
                message: JoinRequestViewModel.sentMessage,
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
          title: JoinRequestViewModel.title,
          bottom: AppButton(
            title: 'Send request',
            loading: model.isBusy,
            onPressed: model.submit,
          ),
          body: SectionColumn(
            gap: 14,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(JoinRequestViewModel.heading),
                  SizedBox(height: 6),
                  AppText(
                    JoinRequestViewModel.intro,
                    tone: AppTextTone.secondary,
                  ),
                ],
              ),
              AppTextField(
                label: 'Hospital name',
                controller: model.hospitalController,
                textCapitalization: TextCapitalization.words,
                errorText: model.errorFor('hospitalName'),
              ),
              AppTextField(
                label: 'Your name',
                controller: model.contactController,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                errorText: model.errorFor('contactName'),
              ),
              AppTextField(
                label: 'Phone number',
                controller: model.phoneController,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                errorText: model.errorFor('phone'),
              ),
              AppDropdown<String>(
                label: 'Area',
                value: model.area,
                options: model.areaOptions,
                onSelected: model.setArea,
              ),
              AppTextField(
                label: 'Message (optional)',
                hintText: 'Best time to visit, who to ask for',
                controller: model.messageController,
                maxLines: 4,
                minLines: 3,
                errorText: model.errorFor('message'),
              ),
            ],
          ),
        );
      },
    );
  }
}
