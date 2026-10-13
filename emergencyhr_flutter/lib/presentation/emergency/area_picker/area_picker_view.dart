import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/route_args.dart';
import 'area_picker_viewmodel.dart';

class AreaPickerView extends StatelessWidget {
  const AreaPickerView({super.key, this.args = const AreaPickerArgs()});

  final AreaPickerArgs args;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AreaPickerViewModel>.reactive(
      viewModelBuilder: () => AreaPickerViewModel(args: args),
      builder: (context, model, _) => AppPage(
        title: AreaPickerViewModel.title,
        bottom: AppButton.dangerOutline(
          title: 'Call 112',
          onPressed: model.call112,
        ),
        body: SectionColumn(
          gap: AppSpacing.x2,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText.headline(AreaPickerViewModel.heading),
                const SizedBox(height: 6),
                AppText(model.hint, tone: AppTextTone.secondary),
                const SizedBox(height: AppSpacing.small),
                AppButton.secondary(
                  title: AreaPickerViewModel.useMyLocationLabel,
                  size: AppButtonSize.medium,
                  expand: false,
                  onPressed: model.useMyLocation,
                ),
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
