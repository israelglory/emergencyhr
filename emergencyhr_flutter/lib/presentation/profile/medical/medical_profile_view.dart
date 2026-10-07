import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'medical_profile_viewmodel.dart';

class MedicalProfileView extends StatelessWidget {
  const MedicalProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MedicalProfileViewModel>.reactive(
      viewModelBuilder: MedicalProfileViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) {
          return const AppPage(
            title: MedicalProfileViewModel.title,
            scrollable: false,
            body: LoadingState(),
          );
        }
        if (model.hasError) {
          return AppPage(
            title: MedicalProfileViewModel.title,
            scrollable: false,
            body: ErrorState(message: model.errorMessage!, onRetry: model.load),
          );
        }
        return AppPage(
          title: 'Profile',
          bottom: AppButton(
            title: 'Save medical details',
            loading: model.isBusy,
            onPressed: model.onSave,
          ),
          body: SectionColumn(
            gap: AppSpacing.x2,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(MedicalProfileViewModel.title),
                  SizedBox(height: 6),
                  AppText(
                    MedicalProfileViewModel.explainer,
                    tone: AppTextTone.secondary,
                  ),
                ],
              ),
              AppTextField(
                label: 'Blood group',
                hintText: 'For example O+',
                controller: model.bloodGroupController,
              ),
              AppTextField(
                label: 'Allergies',
                hintText: 'For example penicillin',
                controller: model.allergiesController,
                maxLines: 3,
                minLines: 1,
              ),
              AppTextField(
                label: 'Conditions',
                controller: model.conditionsController,
                maxLines: 3,
                minLines: 1,
              ),
              AppTextField(
                label: 'Regular medicines',
                controller: model.medicationsController,
                maxLines: 3,
                minLines: 1,
              ),
              AppCard(
                onTap: () => model.setConsent(!model.consentTicked),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox.square(
                          dimension: 20,
                          child: Checkbox(
                            value: model.consentTicked,
                            onChanged: model.setConsent,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.small),
                        const Expanded(
                          child: AppText.small(
                            MedicalProfileViewModel.consentText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.x1),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: AppText.caption(model.consentLabel),
                    ),
                  ],
                ),
              ),
              if (model.hasSaved)
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppButton.text(
                    title: 'Delete medical details',
                    color: context.palette.critical,
                    onPressed: model.delete,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
