import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'freshness_viewmodel.dart';

class FreshnessView extends StatelessWidget {
  const FreshnessView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FreshnessViewModel>.reactive(
      viewModelBuilder: FreshnessViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Freshness',
          subtitle: 'Live hospitals, stalest first',
          onRefresh: model.load,
          children: [
            DataTableCard(
              columns: const [
                TableColumn('Hospital', flex: 20),
                TableColumn('Area · status · hours', flex: 16),
                TableColumn('Last update', width: 160),
              ],
              empty: const AppText(
                'No live hospitals yet',
                tone: AppTextTone.secondary,
              ),
              rows: [
                for (final row in model.rows)
                  [
                    InkWell(
                      onTap: () => model.open(row.id),
                      child: AppText.subtitle(row.name),
                    ),
                    AppText.caption(row.detail),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StatusBadge(label: row.age, tone: row.tone),
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
