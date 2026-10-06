import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'metrics_viewmodel.dart';

class MetricsView extends StatelessWidget {
  const MetricsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MetricsViewModel>.reactive(
      viewModelBuilder: MetricsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => switch (model.state) {
        ViewState.loading => const LoadingState(),
        ViewState.error => ErrorState(
          message: model.errorMessage!,
          onRetry: model.load,
        ),
        ViewState.empty => const EmptyState(title: 'No metrics yet'),
        ViewState.ready => ShellPageFrame(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.x2),
            children: [
              AppText.caption(model.period),
              const SizedBox(height: AppSpacing.x2),
              Wrap(
                spacing: AppSpacing.x2,
                runSpacing: AppSpacing.x2,
                children: [
                  for (final t in model.tiles)
                    SizedBox(
                      width: 280,
                      child: AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.label(t.label, tone: AppTextTone.secondary),
                            const SizedBox(height: AppSpacing.x1),
                            AppText.display(t.value, numeric: true),
                            const SizedBox(height: AppSpacing.x1),
                            AppText.caption(t.note),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      },
    );
  }
}
