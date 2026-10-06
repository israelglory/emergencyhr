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
        const gap = SizedBox(height: AppSpacing.x2);
        return AppPage(
          title: MedicalProfileViewModel.title,
          bottom: AppButton(
            title: 'Save medical details',
            loading: model.isBusy,
            onPressed: model.onSave,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText(
                MedicalProfileViewModel.explainer,
                tone: AppTextTone.secondary,
              ),
              gap,
              AppTextField(
                label: 'Blood group',
                hintText: 'For example O+',
                controller: model.bloodGroupController,
              ),
              gap,
              AppTextField(
                label: 'Allergies',
                controller: model.allergiesController,
                maxLines: 3,
                minLines: 1,
              ),
              gap,
              AppTextField(
                label: 'Conditions',
                controller: model.conditionsController,
                maxLines: 3,
                minLines: 1,
              ),
              gap,
              AppTextField(
                label: 'Regular medicines',
                controller: model.medicationsController,
                maxLines: 3,
                minLines: 1,
              ),
              const SizedBox(height: AppSpacing.x3),
              AppCard(
                muted: true,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.consentTicked,
                  onChanged: model.setConsent,
                  title: const AppText(MedicalProfileViewModel.consentText),
                  subtitle: AppText.caption(model.consentLabel),
                ),
              ),
              if (model.hasSaved) ...[
                gap,
                AppButton.text(
                  title: 'Delete medical details',
                  icon: Icons.delete_outline,
                  onPressed: model.delete,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
