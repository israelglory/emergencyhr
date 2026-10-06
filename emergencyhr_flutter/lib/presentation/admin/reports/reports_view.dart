import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'reports_viewmodel.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportsViewModel>.reactive(
      viewModelBuilder: ReportsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => switch (model.state) {
        ViewState.loading => const LoadingState(),
        ViewState.error => ErrorState(
          message: model.errorMessage!,
          onRetry: model.load,
        ),
        ViewState.empty => const EmptyState(
          icon: Icons.flag_outlined,
          title: 'No open reports',
        ),
        ViewState.ready => ShellPageFrame(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.x2),
            itemCount: model.rows.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, i) {
              final row = model.rows[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.x1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: AppText.label(row.name)),
                        StatusBadge(label: row.badge, tone: row.tone),
                      ],
                    ),
                    AppText.caption(row.detail),
                    Wrap(
                      spacing: AppSpacing.x1,
                      children: [
                        AppButton.text(
                          title: 'Open',
                          onPressed: () => model.open(row.id),
                        ),
                        AppButton.text(
                          title: 'Mark reviewed',
                          icon: Icons.check,
                          onPressed: () => model.markReviewed(row),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      },
    );
  }
}
