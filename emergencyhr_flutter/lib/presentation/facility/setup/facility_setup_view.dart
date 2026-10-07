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
        final p = context.palette;
        final list = ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.x1,
            AppSpacing.screen,
            AppSpacing.screen,
          ),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSizes.contentMaxWidth,
                ),
                child: SectionColumn(
                  gap: 22,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppText.headline(model.name),
                        const SizedBox(height: AppSpacing.x1),
                        AppText.caption(model.subtitle),
                        const SizedBox(height: AppSpacing.x1),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            StatusBadge(
                              label: model.stageLabel,
                              tone: StatusTone.neutral,
                              dot: false,
                            ),
                            StatusBadge(
                              label: model.verificationLabel,
                              tone: model.verificationTone,
                              dot: false,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        AppButton.secondary(
                          title: 'Edit hospital details',
                          size: AppButtonSize.medium,
                          onPressed: model.editDetails,
                        ),
                      ],
                    ),
                    _Group(
                      title: 'Go-live checklist',
                      trailing: Text(
                        model.checklistSummary,
                        style: AppTypography.meta.copyWith(
                          fontWeight: FontWeight.w600,
                          color: p.text,
                        ),
                      ),
                      children: [ChecklistView(items: model.checklist)],
                    ),
                    _Group(
                      title: 'Documents',
                      children: [
                        if (model.hasDocuments)
                          AppListCard(
                            children: [
                              for (final d in model.documents)
                                DocumentRow(name: d.name, meta: d.detail),
                            ],
                          ),
                        DocumentButtons(
                          canUseCamera: model.canUseCamera,
                          loading: model.isUploading,
                          onPhotograph: model.uploadRegistrationPhoto,
                          onUpload: model.uploadRegistrationFile,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppButton.text(
                            title: 'Add contact details document',
                            onPressed: model.uploadContactDocument,
                          ),
                        ),
                      ],
                    ),
                    _Group(
                      title: 'Desk phone',
                      children: [
                        AppCard(
                          child: SectionColumn(
                            gap: AppSpacing.small,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText.subtitle(
                                      model.deskPhoneLabel,
                                    ),
                                  ),
                                  if (model.hasDeskPhone)
                                    StatusBadge(
                                      label: model.deskPhoneStatus,
                                      tone: model.deskPhoneTone,
                                      dot: false,
                                    ),
                                ],
                              ),
                              if (model.showDeskConfirm) ...[
                                if (model.codeSent) ...[
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
                                  AppButton(
                                    title: 'Confirm code',
                                    size: AppButtonSize.medium,
                                    loading: model.isConfirmingDesk,
                                    onPressed: model.confirmDeskCode,
                                  ),
                                ] else
                                  AppButton.secondary(
                                    title: 'Text a code to the desk phone',
                                    size: AppButtonSize.medium,
                                    loading: model.isConfirmingDesk,
                                    onPressed: model.sendDeskCode,
                                  ),
                                if (model.deskError != null)
                                  NoticeBanner(
                                    message: model.deskError!,
                                    tone: StatusTone.warning,
                                  ),
                                if (model.isAgent)
                                  AppButton(
                                    title: 'Confirm with a test call instead',
                                    size: AppButtonSize.medium,
                                    onPressed: model.recordTestCall,
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    _Group(
                      title: 'Staff',
                      children: [
                        Row(
                          children: [
                            if (model.canInviteAdmin) ...[
                              Expanded(
                                child: AppButton.secondary(
                                  title: 'Invite admin',
                                  size: AppButtonSize.medium,
                                  onPressed: model.inviteHospitalAdmin,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.tight),
                            ],
                            Expanded(
                              child: AppButton.secondary(
                                title: 'Invite desk staff',
                                size: AppButtonSize.medium,
                                onPressed: model.inviteDeskStaff,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppButton.text(
                            title: 'Manage staff and invites',
                            onPressed: model.openStaff,
                          ),
                        ),
                      ],
                    ),
                    _Group(
                      title: 'Training mode',
                      children: [
                        AppCard(
                          child: SectionColumn(
                            gap: AppSpacing.small,
                            children: [
                              Row(
                                children: [
                                  if (model.trainingDone) ...[
                                    const DoneMark(done: true),
                                    const SizedBox(width: AppSpacing.tight),
                                  ],
                                  Expanded(
                                    child: model.trainingDone
                                        ? AppText.subtitle(model.trainingLabel)
                                        : AppText(
                                            model.trainingLabel,
                                            tone: AppTextTone.secondary,
                                          ),
                                  ),
                                ],
                              ),
                              AppButton.secondary(
                                title: 'Open practice status update',
                                size: AppButtonSize.medium,
                                onPressed: model.openPractice,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (model.isAgent)
                      _Group(
                        title: 'Visit notes',
                        children: [
                          AppCard(
                            child: SectionColumn(
                              gap: AppSpacing.small,
                              children: [
                                AppTextField(
                                  label: 'Notes',
                                  controller: model.notesController,
                                  maxLines: 4,
                                  minLines: 3,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                                AppButton.secondary(
                                  title: model.nextActionLabel,
                                  size: AppButtonSize.medium,
                                  onPressed: model.pickNextAction,
                                ),
                                AppButton(
                                  title: 'Save notes',
                                  size: AppButtonSize.medium,
                                  loading: model.isSavingNotes,
                                  onPressed: model.saveNotes,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.half),
                          const AppText.label('Move stage'),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final o in model.stageOptions)
                                AppButton(
                                  title: o.label,
                                  variant: o.selected
                                      ? AppButtonVariant.primary
                                      : AppButtonVariant.secondary,
                                  size: AppButtonSize.small,
                                  expand: false,
                                  onPressed: () => model.setStage(o.stage),
                                ),
                            ],
                          ),
                        ],
                      ),
                    _Group(
                      title: 'Verification',
                      children: [
                        AppCard(
                          child: SectionColumn(
                            gap: AppSpacing.small,
                            children: [
                              AppText.small(
                                model.verificationNote,
                                tone: AppTextTone.secondary,
                              ),
                              if (model.showSubmit)
                                AppTextField(
                                  label: 'Notes for the reviewer (optional)',
                                  controller: model.submitNotesController,
                                  maxLines: 4,
                                  minLines: 3,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
        if (!model.hasFooter) return list;
        return Column(
          children: [
            Expanded(child: list),
            PageFooter(
              child: model.canVerifyNow
                  ? AppButton(
                      title: 'Verify now',
                      loading: model.isVerifying,
                      onPressed: model.verifyNow,
                    )
                  : AppButton(
                      title: 'Submit for verification',
                      loading: model.isSubmitting,
                      onPressed: model.submit,
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.children, this.trailing});

  final String title;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SectionColumn(
      gap: AppSpacing.x1,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Semantics(header: true, child: AppText.caps(title)),
            ),
            ?trailing,
          ],
        ),
        ...children,
      ],
    );
  }
}
