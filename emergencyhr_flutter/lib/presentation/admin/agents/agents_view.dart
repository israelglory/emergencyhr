import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'agents_viewmodel.dart';

class AgentsView extends StatelessWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgentsViewModel>.reactive(
      viewModelBuilder: AgentsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Field agents',
          subtitle: 'Who onboards hospitals, and where',
          onRefresh: model.load,
          actions: [
            AppButton(
              title: 'Add field agent',
              size: AppButtonSize.medium,
              expand: false,
              onPressed: model.add,
            ),
          ],
          children: [
            DataTableCard(
              columns: const [
                TableColumn('Agent', flex: 2),
                TableColumn('Areas', flex: 2),
                TableColumn('Hospitals'),
                TableColumn('', width: 220),
              ],
              empty: const AppText(
                'No field agents yet',
                tone: AppTextTone.secondary,
              ),
              rows: [
                for (final row in model.rows)
                  [
                    NameCell(row.name, detail: row.contact),
                    AppText.small(row.areas),
                    AppText.small(row.hospitals),
                    Wrap(
                      spacing: AppSpacing.x1,
                      runSpacing: 6,
                      children: [
                        AppButton.secondary(
                          title: 'Edit areas',
                          size: AppButtonSize.small,
                          expand: false,
                          onPressed: () => model.editAreas(row),
                        ),
                        AppButton.secondary(
                          title: 'Deactivate',
                          size: AppButtonSize.small,
                          expand: false,
                          onPressed: () => model.deactivate(row),
                        ),
                      ],
                    ),
                  ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
