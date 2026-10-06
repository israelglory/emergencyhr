import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/route_args.dart';
import 'results_viewmodel.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key, this.args});

  final EmergencyResultsArgs? args;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResultsViewModel>.reactive(
      viewModelBuilder: () => ResultsViewModel(args: args),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final call112 = AppButton.danger(
          title: 'Call 112',
          icon: Icons.call_outlined,
          large: true,
          onPressed: model.call112,
        );
        if (model.isLoading) {
          return const AppPage(
            title: ResultsViewModel.title,
            scrollable: false,
            body: LoadingState(label: 'Finding hospitals that can take you'),
          );
        }
        if (model.failed) {
          return AppPage(
            title: ResultsViewModel.title,
            scrollable: false,
            bottom: call112,
            body: ErrorState(
              message: ResultsViewModel.failedMessage,
              onRetry: model.retry,
            ),
          );
        }
        if (model.isEmpty) {
          return AppPage(
            title: ResultsViewModel.title,
            scrollable: false,
            bottom: call112,
            body: const EmptyState(
              icon: Icons.location_off_outlined,
              title: ResultsViewModel.emptyTitle,
              message: ResultsViewModel.emptyMessage,
            ),
          );
        }
        return AppPage(
          title: ResultsViewModel.title,
          scrollable: false,
          padding: EdgeInsets.zero,
          body: RefreshIndicator(
            onRefresh: model.refresh,
            child: ListView(
              padding: const EdgeInsets.only(bottom: AppSpacing.x4),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.x2,
                    AppSpacing.x2,
                    AppSpacing.x2,
                    AppSpacing.x1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppText.caption(model.subtitle),
                      if (model.isOffline) ...[
                        const SizedBox(height: AppSpacing.x1),
                        NoticeBanner(
                          message: model.offlineNotice,
                          tone: StatusTone.warning,
                          icon: Icons.cloud_off_outlined,
                        ),
                      ],
                      if (model.showCall112) ...[
                        const SizedBox(height: AppSpacing.x1),
                        const NoticeBanner(
                          message: ResultsViewModel.call112Notice,
                          tone: StatusTone.critical,
                          icon: Icons.warning_amber_outlined,
                        ),
                        const SizedBox(height: AppSpacing.x1),
                        call112,
                      ],
                    ],
                  ),
                ),
                for (final row in model.rows) ...[
                  HospitalListTile(
                    name: row.name,
                    distanceLabel: row.distance,
                    etaLabel: row.eta,
                    statusLabel: row.status,
                    statusTone: row.tone,
                    metrics: row.metrics,
                    capabilitiesLabel: row.capabilities,
                    footnote: row.footnote,
                    onTap: row.onTap,
                    onCall: row.onCall,
                    onDirections: row.onDirections,
                  ),
                  const Divider(),
                ],
                if (model.hasHidden)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.x2),
                    child: AppButton.text(
                      title: model.hiddenToggleLabel,
                      icon: Icons.visibility_outlined,
                      onPressed: model.toggleHidden,
                    ),
                  ),
                for (final row in model.hiddenRows) ...[
                  HospitalListTile(
                    name: row.name,
                    distanceLabel: row.distance,
                    etaLabel: row.eta,
                    statusLabel: row.status,
                    statusTone: row.tone,
                    metrics: row.metrics,
                    capabilitiesLabel: row.capabilities,
                    onTap: row.onTap,
                    onCall: row.onCall,
                    onDirections: row.onDirections,
                  ),
                  const Divider(),
                ],
                if (!model.showCall112)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.x2),
                    child: AppButton.secondary(
                      title: 'Call 112',
                      icon: Icons.call_outlined,
                      onPressed: model.call112,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
