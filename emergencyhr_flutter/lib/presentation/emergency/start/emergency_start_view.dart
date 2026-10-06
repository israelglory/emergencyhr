import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'emergency_start_viewmodel.dart';

class EmergencyStartView extends StatelessWidget {
  const EmergencyStartView({super.key, this.presetType});

  final EmergencyType? presetType;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmergencyStartViewModel>.reactive(
      viewModelBuilder: () => EmergencyStartViewModel(presetType: presetType),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) => AppPage(
        title: EmergencyStartViewModel.title,
        bottom: AppButton.secondary(
          title: 'Call 112',
          icon: Icons.call_outlined,
          onPressed: model.call112,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NoticeBanner(
              message: model.locationLabel,
              tone: model.locationTone,
              icon: model.locationIcon,
              action: AppButton.text(
                title: 'Choose area',
                onPressed: model.chooseArea,
              ),
            ),
            const SizedBox(height: AppSpacing.x3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.headline(EmergencyStartViewModel.heading),
                      AppText(
                        EmergencyStartViewModel.hint,
                        tone: AppTextTone.secondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.x2),
                AppButton(
                  title: 'Skip',
                  icon: Icons.arrow_forward,
                  expand: false,
                  loading: model.isWaiting,
                  onPressed: model.skip,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.x2),
            for (final o in model.options) ...[
              ChoiceTile(
                title: o.label,
                icon: o.icon,
                onTap: () => model.choose(o.type),
              ),
              const SizedBox(height: AppSpacing.x1),
            ],
          ],
        ),
      ),
    );
  }
}
