import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../first_aid/components/first_aid_content.dart';
import 'after_action_viewmodel.dart';

class AfterActionView extends StatelessWidget {
  const AfterActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AfterActionViewModel>.reactive(
      viewModelBuilder: AfterActionViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) => AppPage(
        title: 'Next steps',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.headline(model.heading),
            const SizedBox(height: AppSpacing.x1),
            const AppText(
              AfterActionViewModel.tip,
              tone: AppTextTone.secondary,
            ),
            const SizedBox(height: AppSpacing.x2),
            Row(
              children: [
                Expanded(
                  child: AppButton.secondary(
                    title: 'Call again',
                    icon: Icons.call_outlined,
                    onPressed: model.onCallAgain,
                  ),
                ),
                const SizedBox(width: AppSpacing.x1),
                Expanded(
                  child: AppButton.secondary(
                    title: 'Other hospitals',
                    icon: Icons.list_outlined,
                    onPressed: model.backToResults,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.x3),
            const SectionHeader('Tell your family'),
            ...switch (model.familyState) {
              FamilyAlertState.signedOut => [
                AppButton.text(
                  title: 'Sign in to alert family',
                  icon: Icons.login_outlined,
                  onPressed: model.signIn,
                ),
              ],
              FamilyAlertState.loading => [const LinearProgressIndicator()],
              FamilyAlertState.noContacts => [
                AppButton.text(
                  title: 'Add emergency contacts',
                  icon: Icons.person_add_alt_outlined,
                  onPressed: model.addContacts,
                ),
              ],
              FamilyAlertState.ready => [
                AppButton(
                  title: model.alertButtonLabel,
                  icon: Icons.sms_outlined,
                  loading: model.isAlerting,
                  onPressed: model.notifyFamily,
                ),
              ],
              FamilyAlertState.sent => [
                for (final row in model.alertRows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.x1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.label(row.name),
                              AppText.caption(row.detail, numeric: true),
                            ],
                          ),
                        ),
                        StatusBadge(label: row.label, tone: row.tone),
                      ],
                    ),
                  ),
                if (model.showSmsFallback)
                  AppButton.secondary(
                    title: 'Send from my phone instead',
                    icon: Icons.sms_outlined,
                    onPressed: model.sendFromPhone,
                  ),
              ],
            },
            if (model.firstAid != null) ...[
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('First aid while you wait'),
              AppCard(child: FirstAidContent(card: model.firstAid!)),
            ],
            const SizedBox(height: AppSpacing.x3),
            if (model.canReport)
              AppButton.text(
                title: 'Was the hospital status wrong? Report it',
                icon: Icons.flag_outlined,
                onPressed: model.report,
              ),
            const SizedBox(height: AppSpacing.x1),
            AppButton.danger(
              title: 'Call 112',
              icon: Icons.call_outlined,
              onPressed: model.call112,
            ),
          ],
        ),
      ),
    );
  }
}
