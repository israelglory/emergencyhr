import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import 'design_viewmodel.dart';

class DesignView extends StatelessWidget {
  const DesignView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DesignViewModel>.reactive(
      viewModelBuilder: DesignViewModel.new,
      builder: (context, model, _) => Theme(
        data: model.theme,
        child: Builder(
          builder: (context) => AppPage(
            title: 'Design system',
            maxWidth: AppSizes.wideContentMaxWidth,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSwitchTile(
                  label: model.themeLabel,
                  value: model.dark,
                  onChanged: model.toggleTheme,
                ),
                const Divider(),
                const SectionHeader('Type scale'),
                const AppText.display('Display 32'),
                const AppText.headline('Headline 24'),
                const AppText.title('Title 18'),
                const AppText.subtitle('Subtitle 16'),
                const AppText('Body 16'),
                const AppText.small('Body small 14'),
                const AppText.label('Label 14'),
                const AppText.caption('Caption 12'),
                const SizedBox(height: AppSpacing.x3),
                const SectionHeader('Buttons'),
                EmergencyButton(onPressed: model.tap),
                const SizedBox(height: AppSpacing.x2),
                AppButton(title: 'Primary', onPressed: model.tap),
                const SizedBox(height: AppSpacing.x1),
                AppButton.secondary(
                  title: 'Secondary',
                  icon: Icons.directions_outlined,
                  onPressed: model.tap,
                ),
                const SizedBox(height: AppSpacing.x1),
                AppButton.danger(
                  title: 'Call 112',
                  icon: Icons.call_outlined,
                  onPressed: model.tap,
                ),
                const SizedBox(height: AppSpacing.x1),
                const AppButton(title: 'Disabled', onPressed: null),
                const SizedBox(height: AppSpacing.x1),
                AppButton(
                  title: 'Loading',
                  loading: true,
                  onPressed: model.tap,
                ),
                const SizedBox(height: AppSpacing.x1),
                AppButton.text(title: 'Text button', onPressed: model.tap),
                const SizedBox(height: AppSpacing.x3),
                const SectionHeader('Status'),
                Wrap(
                  spacing: AppSpacing.x1,
                  runSpacing: AppSpacing.x1,
                  children: [
                    for (final (label, tone) in DesignViewModel.tones)
                      StatusBadge(label: label, tone: tone),
                  ],
                ),
                const SizedBox(height: AppSpacing.x2),
                const NoticeBanner(
                  message: 'You are offline. Showing saved results.',
                ),
                const SizedBox(height: AppSpacing.x1),
                const NoticeBanner(
                  message: 'Practice mode. The public will not see this.',
                  tone: StatusTone.warning,
                  icon: Icons.school_outlined,
                ),
                const SizedBox(height: AppSpacing.x3),
                const SectionHeader('Hospital list tile'),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: HospitalListTile(
                    name: 'Seed Hospital 01, Ikeja',
                    distanceLabel: '2.4 km · About 9 min drive',
                    statusLabel: 'Accepting emergencies. Confirmed 4 min ago.',
                    statusTone: StatusTone.positive,
                    metrics: DesignViewModel.sampleMetrics,
                    capabilities: const ['Trauma', 'Theatre', 'Blood bank'],
                    onTap: model.tap,
                    onCall: model.tap,
                    onDirections: model.tap,
                  ),
                ),
                const SizedBox(height: AppSpacing.x3),
                const SectionHeader('Controls'),
                AppTextField(
                  label: 'Text field',
                  hintText: 'Hint text',
                  controller: model.fieldController,
                ),
                const SizedBox(height: AppSpacing.x2),
                const AppTextField(
                  label: 'With error',
                  errorText: 'Enter a valid phone number.',
                ),
                const SizedBox(height: AppSpacing.x2),
                AppCountStepper(
                  label: 'ER beds free',
                  value: model.beds,
                  onIncrement: model.increment,
                  onDecrement: model.decrement,
                ),
                AppSwitchTile(
                  label: 'Accepting emergencies',
                  valueLabel: model.acceptingLabel,
                  value: model.accepting,
                  onChanged: model.setAccepting,
                ),
                ChoiceTile(
                  title: 'Road accident',
                  icon: Icons.car_crash_outlined,
                  onTap: model.tap,
                ),
                const SizedBox(height: AppSpacing.x1),
                const KeyValueRow(label: 'ER beds free', value: '3'),
                const SizedBox(height: AppSpacing.x3),
                const SectionHeader('States'),
                const SizedBox(
                  height: 220,
                  child: EmptyState(
                    title: 'No hospitals within 25 km',
                    message: 'Call 112 or call a nearby hospital before going.',
                  ),
                ),
                SizedBox(
                  height: 260,
                  child: ErrorState(
                    message: 'No internet connection.',
                    onRetry: model.tap,
                  ),
                ),
                const SizedBox(height: 160, child: LoadingState()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
