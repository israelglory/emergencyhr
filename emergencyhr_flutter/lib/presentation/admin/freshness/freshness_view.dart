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
      builder: (context, model, _) => switch (model.state) {
        ViewState.loading => const LoadingState(),
        ViewState.error => ErrorState(
          message: model.errorMessage!,
          onRetry: model.load,
        ),
        ViewState.empty => const EmptyState(
          icon: Icons.schedule,
          title: 'No live hospitals yet',
        ),
        ViewState.ready => ShellPageFrame(
          child: RefreshIndicator(
            onRefresh: model.load,
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.x2),
              itemCount: model.rows.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, i) {
                final row = model.rows[i];
                return InkWell(
                  onTap: () => model.open(row.id),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.x1,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.label(row.name),
                              AppText.caption(row.detail),
                            ],
                          ),
                        ),
                        StatusBadge(label: row.age, tone: row.tone),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      },
    );
  }
}
