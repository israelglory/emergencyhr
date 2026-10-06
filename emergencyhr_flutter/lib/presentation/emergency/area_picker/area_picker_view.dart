import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'area_picker_viewmodel.dart';

class AreaPickerView extends StatelessWidget {
  const AreaPickerView({super.key, required this.type});

  final EmergencyType type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AreaPickerViewModel>.reactive(
      viewModelBuilder: () => AreaPickerViewModel(type: type),
      builder: (context, model, _) => AppPage(
        title: AreaPickerViewModel.title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText(
              AreaPickerViewModel.hint,
              tone: AppTextTone.secondary,
            ),
            const SizedBox(height: AppSpacing.x2),
            AppTextField(
              label: 'Search areas',
              controller: model.searchController,
              onChanged: model.onSearchChanged,
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: AppSpacing.x2),
            if (model.noMatches)
              const AppText(
                'No pilot area matches. Pick the closest one below.',
                tone: AppTextTone.secondary,
              ),
            for (final row in model.areas) ...[
              ChoiceTile(
                title: row.name,
                subtitle: row.description,
                icon: Icons.place_outlined,
                onTap: () => model.choose(row.area),
              ),
              const SizedBox(height: AppSpacing.x1),
            ],
          ],
        ),
      ),
    );
  }
}
