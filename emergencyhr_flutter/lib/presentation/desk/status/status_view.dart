import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'status_viewmodel.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.facilityId,
    this.startInPractice = false,
  });

  final int facilityId;
  final bool startInPractice;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StatusViewModel>.reactive(
      viewModelBuilder: () => StatusViewModel(
        facilityId: facilityId,
        startInPractice: startInPractice,
      ),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState(label: 'Loading status');
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        return Column(
          children: [
            Expanded(
              child: ShellPageFrame(
                maxWidth: AppSizes.contentMaxWidth,
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.x2),
                  children: [
                    if (model.isPractice) ...[
                      NoticeBanner(
                        message: StatusViewModel.practiceNotice,
                        tone: StatusTone.warning,
                        icon: Icons.school_outlined,
                        action: AppButton.text(
                          title: 'Exit',
                          onPressed: model.stopPractice,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.x2),
                    ],
                    if (model.showPracticePrompt) ...[
                      NoticeBanner(
                        message: StatusViewModel.practicePrompt,
                        icon: Icons.school_outlined,
                        action: AppButton.text(
                          title: 'Practise',
                          onPressed: model.startPractice,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.x2),
                    ],
                    if (model.showNotLiveNotice) ...[
                      NoticeBanner(message: model.notLiveNotice),
                      const SizedBox(height: AppSpacing.x2),
                    ],
                    Row(
                      children: [
                        Expanded(child: AppText.title(model.facilityName)),
                        StatusBadge(
                          label: model.ageLabel,
                          tone: model.ageTone,
                          icon: Icons.schedule,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.x2),
                    SegmentedToggle(
                      leftLabel: 'Accepting',
                      rightLabel: 'Paused',
                      leftIcon: Icons.check_circle_outline,
                      rightIcon: Icons.pause_circle_outline,
                      leftSelected: model.accepting,
                      onChanged: model.setAccepting,
                    ),
                    const SizedBox(height: AppSpacing.x3),
                    AppCountStepper(
                      label: 'ER beds free',
                      value: model.erBeds,
                      onIncrement: model.incrementEr,
                      onDecrement: model.decrementEr,
                    ),
                    const SizedBox(height: AppSpacing.x2),
                    AppCountStepper(
                      label: 'ICU beds free',
                      value: model.icuBeds,
                      onIncrement: model.incrementIcu,
                      onDecrement: model.decrementIcu,
                    ),
                    const SizedBox(height: AppSpacing.x2),
                    const Divider(),
                    AppSwitchTile(
                      label: 'Doctor on duty',
                      valueLabel: model.doctorLabel,
                      value: model.doctorOnDuty,
                      onChanged: model.setDoctorOnDuty,
                    ),
                    const Divider(),
                    AppSwitchTile(
                      label: 'Deposit required',
                      valueLabel: model.depositLabel,
                      value: model.depositRequired,
                      onChanged: model.setDepositRequired,
                    ),
                  ],
                ),
              ),
            ),
            ShellPageFrame(
              maxWidth: AppSizes.contentMaxWidth,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.x2,
                  AppSpacing.x1,
                  AppSpacing.x2,
                  AppSpacing.x2,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      title: model.saveLabel,
                      large: true,
                      loading: model.isSaving,
                      onPressed: model.save,
                    ),
                    const SizedBox(height: AppSpacing.x1),
                    AppButton.secondary(
                      title: 'Still accurate',
                      icon: Icons.verified_outlined,
                      large: true,
                      loading: model.isConfirming,
                      onPressed: model.onConfirm,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
