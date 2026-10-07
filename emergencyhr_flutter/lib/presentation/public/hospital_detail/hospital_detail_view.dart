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
          return const AppPage(
            title: 'Hospital',
            scrollable: false,
            body: LoadingState(),
          );
        }
        if (model.hasError) {
          return AppPage(
            title: 'Hospital',
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
                  onPressed: model.onCall,
                ),
              ),
              const SizedBox(width: AppSpacing.tight),
              Expanded(
                child: AppButton.secondary(
                  title: 'Directions',
                  icon: Icons.near_me_outlined,
                  onPressed: model.directions,
                ),
              ),
            ],
          ),
          body: SectionColumn(
            gap: AppSpacing.x2,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(model.name),
                  const SizedBox(height: 6),
                  AppText.caption(model.typeLabel),
                ],
              ),
              StatusLabel(label: model.statusLabel, tone: model.statusTone),
              if (model.figures.isNotEmpty)
                AppListCard(
                  children: [
                    for (final f in model.figures)
                      KeyValueRow(label: f.label, value: f.value, inCard: true),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppText.caps('Can treat'),
                  const SizedBox(height: AppSpacing.x1),
                  if (model.hasCapabilities)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final c in model.capabilities) AppChip(c),
                      ],
                    )
                  else
                    const AppText('Not provided', tone: AppTextTone.secondary),
                ],
              ),
              AppListCard(
                children: [
                  LabelledValueRow(
                    icon: Icons.call_outlined,
                    label: 'Emergency desk',
                    value: model.phoneLabel,
                  ),
                  LabelledValueRow(
                    icon: Icons.place_outlined,
                    label: 'Address',
                    value: model.address,
                  ),
                  LabelledValueRow(
                    icon: Icons.schedule_outlined,
                    label: 'Opening hours',
                    value: model.openingHoursLabel,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
