import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'audit_log_viewmodel.dart';

class AuditLogView extends StatelessWidget {
  const AuditLogView({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuditLogViewModel>.reactive(
      viewModelBuilder: () => AuditLogViewModel(facilityId: facilityId),
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState(label: 'Loading log');
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        if (model.isEmpty) {
          return const EmptyState(
            icon: Icons.history,
            title: 'No changes yet',
            message:
                'Every status change will be listed here with who made it.',
          );
        }
        return RefreshIndicator(
          onRefresh: model.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.x2,
              AppSpacing.screen,
              AppSpacing.screen,
            ),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSizes.contentMaxWidth,
                  ),
                  child: SectionColumn(
                    gap: AppSpacing.small,
                    children: [
                      const AppText.caps('Audit log'),
                      AppListCard(
                        children: [
                          for (final row in model.rows)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.subtitle(row.summary),
                                        const SizedBox(height: 3),
                                        AppText.caption(row.meta),
                                      ],
                                    ),
                                  ),
                                  if (row.practice)
                                    const StatusBadge(
                                      label: 'Practice',
                                      tone: StatusTone.warning,
                                      dot: false,
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      if (model.canLoadMore)
                        AppButton.secondary(
                          title: 'Load more',
                          size: AppButtonSize.medium,
                          loading: model.isLoadingMore,
                          onPressed: model.loadMore,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
