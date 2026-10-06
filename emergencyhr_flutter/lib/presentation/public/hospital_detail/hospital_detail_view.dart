import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'hospital_detail_viewmodel.dart';

class HospitalDetailView extends StatelessWidget {
  const HospitalDetailView({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HospitalDetailViewModel>.reactive(
      viewModelBuilder: () => HospitalDetailViewModel(facilityId: facilityId),
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) {
          return const AppPage(scrollable: false, body: LoadingState());
        }
        if (model.hasError) {
          return AppPage(
            scrollable: false,
            body: ErrorState(message: model.errorMessage!, onRetry: model.load),
          );
        }
        return AppPage(
          title: 'Hospital',
          bottom: Row(
            children: [
              Expanded(
                child: AppButton(
                  title: 'Call',
                  icon: Icons.call_outlined,
                  large: true,
                  onPressed: model.onCall,
                ),
              ),
              const SizedBox(width: AppSpacing.x1),
              Expanded(
                child: AppButton.secondary(
                  title: 'Directions',
                  icon: Icons.directions_outlined,
                  large: true,
                  onPressed: model.directions,
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.headline(model.name),
              AppText.caption(model.typeLabel),
              const SizedBox(height: AppSpacing.x2),
              StatusBadge(label: model.statusLabel, tone: model.statusTone),
              const SizedBox(height: AppSpacing.x2),
              for (final f in model.figures)
                KeyValueRow(label: f.label, value: f.value),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Contact'),
              KeyValueRow(label: 'Emergency desk', value: model.phoneLabel),
              KeyValueRow(label: 'Address', value: model.address),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Can treat'),
              if (model.hasCapabilities)
                Wrap(
                  spacing: AppSpacing.x1,
                  runSpacing: AppSpacing.x1,
                  children: [
                    for (final c in model.capabilities)
                      StatusBadge(label: c, tone: StatusTone.neutral),
                  ],
                )
              else
                const AppText('Not provided', tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Opening hours'),
              for (final line in model.openingHours)
                AppText(line, numeric: true),
            ],
          ),
        );
      },
    );
  }
}
