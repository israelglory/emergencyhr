import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'facility_setup_viewmodel.dart';

/// Embeddable body (used in the desk shell and the agent facility page).
class FacilitySetupView extends StatelessWidget {
  const FacilitySetupView({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FacilitySetupViewModel>.reactive(
      viewModelBuilder: () => FacilitySetupViewModel(facilityId: facilityId),
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState();
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        const gap = SizedBox(height: AppSpacing.x3);
        return ShellPageFrame(
          maxWidth: AppSizes.contentMaxWidth,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.x2),
            children: [
              AppText.headline(model.name),
              AppText.caption(model.subtitle),
              const SizedBox(height: AppSpacing.x1),
              Wrap(
                spacing: AppSpacing.x1,
                runSpacing: AppSpacing.x1,
                children: [
                  StatusBadge(
                    label: model.stageLabel,
                    tone: StatusTone.neutral,
                  ),
                  StatusBadge(
                    label: model.verificationLabel,
                    tone: StatusTone.neutral,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.x2),
              AppButton.secondary(
                title: 'Edit hospital details',
                icon: Icons.edit_outlined,
                onPressed: model.editDetails,
              ),
              gap,
              SectionHeader(
                'Go-live checklist',
                subtitle: model.checklistSummary,
              ),
              AppCard(child: ChecklistView(items: model.checklist)),
              gap,
              const SectionHeader('Documents'),
              if (!model.hasDocuments)
                const AppText(
                  'No documents yet.',
                  tone: AppTextTone.secondary,
                ),
              for (final d in model.documents)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.x1),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined),
                      const SizedBox(width: AppSpacing.x1),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.label(d.name),
                            AppText.caption(d.detail),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.x1),
              if (model.canUseCamera) ...[
                AppButton(
                  title: 'Photograph registration document',
                  icon: Icons.photo_camera_outlined,
                  loading: model.isUploading,
                  onPressed: model.uploadRegistrationPhoto,
                ),
                const SizedBox(height: AppSpacing.x1),
              ],
              AppButton.secondary(
                title: 'Upload registration document',
                icon: Icons.upload_file_outlined,
                loading: model.isUploading,
                onPressed: model.uploadRegistrationFile,
              ),
              const SizedBox(height: AppSpacing.x1),
              AppButton.text(
                title: 'Add contact details document',
                icon: Icons.badge_outlined,
                onPressed: model.uploadContactDocument,
              ),
              gap,
              const SectionHeader('Desk phone'),
              AppText(model.deskPhoneLabel),
              if (model.showDeskConfirm) ...[
                const SizedBox(height: AppSpacing.x1),
                if (model.codeSent) ...[
                  AppTextField(
                    label: 'Code sent to the desk phone',
                    controller: model.deskCodeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    large: true,
                  ),
                  const SizedBox(height: AppSpacing.x1),
                  AppButton(
                    title: 'Confirm code',
                    loading: model.isConfirmingDesk,
                    onPressed: model.confirmDeskCode,
                  ),
                ] else
                  AppButton.secondary(
                    title: 'Text a code to the desk phone',
                    icon: Icons.sms_outlined,
                    loading: model.isConfirmingDesk,
                    onPressed: model.sendDeskCode,
                  ),
                if (model.isAgent) ...[
                  const SizedBox(height: AppSpacing.x1),
                  AppButton.text(
                    title: 'Confirm with a test call instead',
                    icon: Icons.call_outlined,
                    onPressed: model.recordTestCall,
                  ),
                ],
              ],
              gap,
              const SectionHeader('Staff'),
              if (model.canInviteAdmin) ...[
                AppButton(
                  title: 'Invite hospital admin',
                  icon: Icons.admin_panel_settings_outlined,
                  onPressed: model.inviteHospitalAdmin,
                ),
                const SizedBox(height: AppSpacing.x1),
              ],
              AppButton.secondary(
                title: 'Invite desk staff',
                icon: Icons.person_add_alt_outlined,
                onPressed: model.inviteDeskStaff,
              ),
              const SizedBox(height: AppSpacing.x1),
              AppButton.text(
                title: 'Manage staff and invites',
                onPressed: model.openStaff,
              ),
              gap,
              const SectionHeader('Training mode'),
              AppText(model.trainingLabel, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x1),
              AppButton.secondary(
                title: 'Open practice status update',
                icon: Icons.school_outlined,
                onPressed: model.openPractice,
              ),
              if (model.isAgent) ...[
                gap,
                const SectionHeader('Visit notes'),
                AppTextField(
                  label: 'Notes',
                  controller: model.notesController,
                  maxLines: 4,
                  minLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: AppSpacing.x1),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        title: model.nextActionLabel,
                        icon: Icons.event_outlined,
                        onPressed: model.pickNextAction,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.x1),
                    Expanded(
                      child: AppButton(
                        title: 'Save notes',
                        loading: model.isSavingNotes,
                        onPressed: model.saveNotes,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.x2),
                const AppText.label('Move stage'),
                const SizedBox(height: AppSpacing.x1),
                Wrap(
                  spacing: AppSpacing.x1,
                  runSpacing: AppSpacing.x1,
                  children: [
                    for (final option in model.stageOptions)
                      AppButton.secondary(
                        title: option.label,
                        expand: false,
                        onPressed: () => model.setStage(option.stage),
                      ),
                  ],
                ),
              ],
              gap,
              const SectionHeader('Verification'),
              AppText(model.verificationNote, tone: AppTextTone.secondary),
              if (model.canSubmit) ...[
                const SizedBox(height: AppSpacing.x1),
                AppTextField(
                  label: 'Notes for the reviewer (optional)',
                  controller: model.submitNotesController,
                  maxLines: 3,
                  minLines: 2,
                ),
                const SizedBox(height: AppSpacing.x1),
                AppButton(
                  title: 'Submit for verification',
                  icon: Icons.send_outlined,
                  loading: model.isSubmitting,
                  onPressed: model.submit,
                ),
              ],
              const SizedBox(height: AppSpacing.x4),
            ],
          ),
        );
      },
    );
  }
}
