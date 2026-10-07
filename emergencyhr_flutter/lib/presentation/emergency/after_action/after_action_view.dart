import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'after_action_viewmodel.dart';

class AfterActionView extends StatelessWidget {
  const AfterActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AfterActionViewModel>.reactive(
      viewModelBuilder: AfterActionViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final p = context.palette;
        return AppPage(
          title: 'Next steps',
          bottom: AppButton.danger(
            title: 'Call 112',
            icon: Icons.call_outlined,
            onPressed: model.call112,
          ),
          body: SectionColumn(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(model.heading),
                  const SizedBox(height: AppSpacing.x1),
                  const AppText(
                    AfterActionViewModel.tip,
                    tone: AppTextTone.secondary,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Call again',
                      size: AppButtonSize.medium,
                      onPressed: model.onCallAgain,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.tight),
                  Expanded(
                    child: AppButton.secondary(
                      title: 'Other hospitals',
                      size: AppButtonSize.medium,
                      onPressed: model.backToResults,
                    ),
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
                        AppText.title(AfterActionViewModel.familyTitle),
                        SizedBox(height: 2),
                        AppText.caption(AfterActionViewModel.familyHint),
                      ],
                    ),
                    ...switch (model.familyState) {
                      FamilyAlertState.signedOut => [
                        AppButton.secondary(
                          title: 'Sign in to alert family',
                          size: AppButtonSize.medium,
                          onPressed: model.signIn,
                        ),
                      ],
                      FamilyAlertState.loading => [
                        const LinearProgressIndicator(),
                      ],
                      FamilyAlertState.noContacts => [
                        AppButton.secondary(
                          title: 'Add emergency contacts',
                          size: AppButtonSize.medium,
                          onPressed: model.addContacts,
                        ),
                      ],
                      FamilyAlertState.ready => [
                        AppButton(
                          title: model.alertButtonLabel,
                          size: AppButtonSize.medium,
                          loading: model.isAlerting,
                          onPressed: model.notifyFamily,
                        ),
                      ],
                      FamilyAlertState.sent => [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: p.divider),
                            borderRadius: BorderRadius.circular(
                              AppRadius.card,
                            ),
                          ),
                          child: Column(
                            children: [
                              for (final (i, row) in model.alertRows.indexed)
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: i == 0
                                        ? null
                                        : Border(
                                            top: BorderSide(color: p.divider),
                                          ),
                                  ),
                                  child: AppListRow(
                                    title: row.name,
                                    subtitle: row.detail,
                                    trailing: StatusBadge(
                                      label: row.label,
                                      tone: row.tone,
                                      dot: false,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (model.showSmsFallback)
                          AppButton.secondary(
                            title: 'Send from my phone instead',
                            size: AppButtonSize.medium,
                            onPressed: model.sendFromPhone,
                          ),
                      ],
                    },
                  ],
                ),
              ),
              if (model.hasFirstAid)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: AppText.caps('First aid while you wait'),
                        ),
                        AppButton.text(
                          title: 'Full card',
                          color: p.text,
                          onPressed: model.openFirstAid,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.half),
                    AppListCard(
                      children: [
                        for (final (i, step) in model.firstAidSteps.indexed)
                          NumberedStepRow(number: i + 1, text: step),
                      ],
                    ),
                  ],
                ),
              if (model.canReport)
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const AppText.caption(AfterActionViewModel.reportPrompt),
                    AppButton.text(title: 'Report it', onPressed: model.report),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
