import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'status_viewmodel.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.facilityId,
    this.startInPractice = false,
    this.onSeeAuditLog,
  });

  final int facilityId;
  final bool startInPractice;

  /// Shown as "See audit log" in the wide layout.
  final VoidCallback? onSeeAuditLog;

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
        final wide =
            MediaQuery.sizeOf(context).width >= AppShell.sideMenuBreakpoint;
        return wide
            ? _WideStatus(model: model, onSeeAuditLog: onSeeAuditLog)
            : _PhoneStatus(model: model);
      },
    );
  }
}

class _Notices extends StatelessWidget {
  const _Notices({required this.model});

  final StatusViewModel model;

  @override
  Widget build(BuildContext context) {
    return SectionColumn(
      gap: 14,
      children: [
        if (model.isPractice)
          NoticeBanner(
            message: StatusViewModel.practiceNotice,
            tone: StatusTone.warning,
            action: _ExitButton(onPressed: model.stopPractice),
          ),
        if (model.showPracticePrompt)
          NoticeBanner(
            message: StatusViewModel.practicePrompt,
            action: AppButton.secondary(
              title: 'Practise',
              size: AppButtonSize.small,
              expand: false,
              onPressed: model.startPractice,
            ),
          ),
        if (model.showNotLiveNotice) NoticeBanner(message: model.notLiveNotice),
      ],
    );
  }
}

/// White "Exit" pill with a yellow border, inside the practice notice.
class _ExitButton extends StatelessWidget {
  const _ExitButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, AppSizes.buttonSmall),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shape: const StadiumBorder(),
        backgroundColor: p.surface,
        foregroundColor: p.text,
        side: const BorderSide(color: Color(0xFFFEDF89)),
        textStyle: AppTypography.meta.copyWith(fontWeight: FontWeight.w600),
      ),
      child: const Text('Exit'),
    );
  }
}

class _AcceptingToggle extends StatelessWidget {
  const _AcceptingToggle({required this.model});

  final StatusViewModel model;

  @override
  Widget build(BuildContext context) {
    return SegmentedToggle(
      leftLabel: 'Accepting',
      rightLabel: 'Paused',
      leftSelected: model.accepting,
      onChanged: model.setAccepting,
      large: true,
    );
  }
}

class _BedsStepper extends StatelessWidget {
  const _BedsStepper({
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return AppCountStepper(
      label: label,
      value: value,
      valueSize: 22,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
    );
  }
}

class _YesNoRow extends StatelessWidget {
  const _YesNoRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AppText.subtitle(label)),
        YesNoButton(value: value, onChanged: onChanged, semanticsLabel: label),
      ],
    );
  }
}

class _PhoneStatus extends StatelessWidget {
  const _PhoneStatus({required this.model});

  final StatusViewModel model;

  @override
  Widget build(BuildContext context) {
    Widget row(Widget child) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
      child: child,
    );
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              14,
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
                    gap: 14,
                    children: [
                      _Notices(model: model),
                      Row(
                        children: [
                          const Expanded(
                            child: AppText.title(StatusViewModel.webTitle),
                          ),
                          StatusBadge(
                            label: model.ageLabel,
                            tone: model.ageTone,
                          ),
                        ],
                      ),
                      _AcceptingToggle(model: model),
                      AppListCard(
                        children: [
                          row(
                            _BedsStepper(
                              label: 'ER beds free',
                              value: model.erBeds,
                              onIncrement: model.incrementEr,
                              onDecrement: model.decrementEr,
                            ),
                          ),
                          row(
                            _BedsStepper(
                              label: 'ICU beds free',
                              value: model.icuBeds,
                              onIncrement: model.incrementIcu,
                              onDecrement: model.decrementIcu,
                            ),
                          ),
                          row(
                            _YesNoRow(
                              label: 'Doctor on duty',
                              value: model.doctorOnDuty,
                              onChanged: model.setDoctorOnDuty,
                            ),
                          ),
                          row(
                            _YesNoRow(
                              label: 'Deposit required',
                              value: model.depositRequired,
                              onChanged: model.setDepositRequired,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            0,
            AppSpacing.screen,
            AppSpacing.screen,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.contentMaxWidth,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: model.saveLabel,
                    loading: model.isSaving,
                    onPressed: model.onSave,
                  ),
                ),
                const SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: AppButton.secondary(
                    title: 'Still accurate',
                    loading: model.isConfirming,
                    onPressed: model.onConfirm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WideStatus extends StatelessWidget {
  const _WideStatus({required this.model, this.onSeeAuditLog});

  final StatusViewModel model;
  final VoidCallback? onSeeAuditLog;

  @override
  Widget build(BuildContext context) {
    Widget tile(Widget child) => AppCard(child: child);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      children: [
        SectionColumn(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        StatusViewModel.webTitle,
                        variant: AppTextVariant.webTitle,
                      ),
                      SizedBox(height: AppSpacing.half),
                      AppText.caption(StatusViewModel.webSubtitle),
                    ],
                  ),
                ),
                StatusBadge(label: model.ageLabel, tone: model.ageTone),
              ],
            ),
            _Notices(model: model),
            LayoutBuilder(
              builder: (context, constraints) {
                final full = constraints.maxWidth;
                final main = full >= 760 ? full - 320 - 20 : full;
                final half = (main - 48 - 16) / 2;
                return SizedBox(
                  width: full,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SizedBox(
                        width: main,
                        child: AppCard(
                          padding: const EdgeInsets.all(24),
                          child: SectionColumn(
                            gap: 18,
                            children: [
                              _AcceptingToggle(model: model),
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  SizedBox(
                                    width: half,
                                    child: tile(
                                      _BedsStepper(
                                        label: 'ER beds free',
                                        value: model.erBeds,
                                        onIncrement: model.incrementEr,
                                        onDecrement: model.decrementEr,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: half,
                                    child: tile(
                                      _BedsStepper(
                                        label: 'ICU beds free',
                                        value: model.icuBeds,
                                        onIncrement: model.incrementIcu,
                                        onDecrement: model.decrementIcu,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: half,
                                    child: tile(
                                      _YesNoRow(
                                        label: 'Doctor on duty',
                                        value: model.doctorOnDuty,
                                        onChanged: model.setDoctorOnDuty,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: half,
                                    child: tile(
                                      _YesNoRow(
                                        label: 'Deposit required',
                                        value: model.depositRequired,
                                        onChanged: model.setDepositRequired,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.end,
                                spacing: AppSpacing.small,
                                runSpacing: AppSpacing.small,
                                children: [
                                  AppButton.secondary(
                                    title: 'Still accurate',
                                    expand: false,
                                    loading: model.isConfirming,
                                    onPressed: model.onConfirm,
                                  ),
                                  AppButton(
                                    title: model.saveLabel,
                                    expand: false,
                                    loading: model.isSaving,
                                    onPressed: model.onSave,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: full >= 760 ? 320 : full,
                        child: AppListCard(
                          children: [
                            const AppListRow(title: 'Recent changes'),
                            for (final r in model.recentChanges)
                              AppListRow(
                                title: r.summary,
                                subtitle: r.meta,
                              ),
                            if (onSeeAuditLog != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppButton.text(
                                    title: 'See audit log',
                                    onPressed: onSeeAuditLog,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
