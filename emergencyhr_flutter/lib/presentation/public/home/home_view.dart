import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: HomeViewModel.new,
      builder: (context, model, _) => AppPage(
        title: 'Emergencyhr',
        actions: [
          AppButton.text(
            title: model.accountActionLabel,
            icon: model.accountActionIcon,
            onPressed: model.openAccount,
          ),
          const SizedBox(width: AppSpacing.x1),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmergencyButton(onPressed: model.startEmergency),
            const SizedBox(height: AppSpacing.x3),
            for (final item in model.shortcuts) ...[
              ChoiceTile(
                title: item.title,
                subtitle: item.subtitle,
                icon: item.icon,
                onTap: item.onTap,
              ),
              const SizedBox(height: AppSpacing.x1),
            ],
            if (model.showWorkShortcuts) ...[
              const SizedBox(height: AppSpacing.x2),
              const SectionHeader('Your work'),
              for (final item in model.workShortcuts) ...[
                ChoiceTile(
                  title: item.title,
                  subtitle: item.subtitle,
                  icon: item.icon,
                  onTap: item.onTap,
                ),
                const SizedBox(height: AppSpacing.x1),
              ],
            ],
            const SizedBox(height: AppSpacing.x2),
            ChoiceTile(
              title: 'Are you a hospital?',
              subtitle: 'Join Emergencyhr',
              icon: Icons.add_business_outlined,
              onTap: model.joinAsHospital,
            ),
            const SizedBox(height: AppSpacing.x3),
            const NoticeBanner(message: HomeViewModel.disclaimer),
            const SizedBox(height: AppSpacing.x1),
            AppButton.secondary(
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
