import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'new_hospitals_viewmodel.dart';

class NewHospitalsView extends StatelessWidget {
  const NewHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewHospitalsViewModel>.reactive(
      viewModelBuilder: NewHospitalsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'New hospitals',
          subtitle: 'Live for under 14 days',
          onRefresh: model.load,
          children: [
            DataTableCard(
              columns: const [
                TableColumn('Hospital', flex: 2),
                TableColumn('Activity', flex: 3),
                TableColumn('', width: 170),
              ],
              empty: const AppText(
                'No hospitals went live in the last 14 days',
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
                      child: StatusBadge(label: row.badge, tone: row.tone),
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
