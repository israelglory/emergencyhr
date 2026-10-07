import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'area_picker_viewmodel.dart';

class AreaPickerView extends StatelessWidget {
  const AreaPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AreaPickerViewModel>.reactive(
      viewModelBuilder: AreaPickerViewModel.new,
      builder: (context, model, _) => AppPage(
        title: AreaPickerViewModel.title,
        bottom: AppButton.dangerOutline(
          title: 'Call 112',
          onPressed: model.call112,
        ),
        body: SectionColumn(
          gap: AppSpacing.x2,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headline(AreaPickerViewModel.heading),
                SizedBox(height: 6),
                AppText(AreaPickerViewModel.hint, tone: AppTextTone.secondary),
              ],
            ),
            AppTextField(
              hintText: 'Search areas',
              semanticsLabel: 'Search areas',
              controller: model.searchController,
              onChanged: model.onSearchChanged,
              prefixIcon: const Icon(Icons.search),
            ),
            AppListCard(
              children: [
                for (final row in model.areas)
                  AppListRow(
                    title: row.name,
                    subtitle: row.description,
                    onTap: row.onTap,
                  ),
              ],
            ),
            const AppText.caption(AreaPickerViewModel.noMatchHint),
          ],
        ),
      ),
    );
  }
}
