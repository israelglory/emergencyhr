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
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Metrics',
          subtitle: model.period,
          onRefresh: model.load,
          children: [
            Wrap(
              spacing: AppSpacing.x2,
              runSpacing: AppSpacing.x2,
              children: [
                for (final t in model.tiles)
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 240,
                      maxWidth: 360,
                    ),
                    child: AppCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.caption(t.label, fontWeight: FontWeight.w600),
                          const SizedBox(height: AppSpacing.x1),
                          Text(
                            t.value,
                            style: AppTypography.heading.copyWith(
                              fontSize: 34,
                              height: 40 / 34,
                              letterSpacing: -0.6,
                              color: context.palette.text,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.x1),
                          StatusBadge(label: t.note, tone: t.tone, dot: false),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
