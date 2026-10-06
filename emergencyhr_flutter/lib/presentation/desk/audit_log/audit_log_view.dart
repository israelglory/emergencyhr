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
        return ShellPageFrame(
          maxWidth: AppSizes.contentMaxWidth,
          child: RefreshIndicator(
            onRefresh: model.load,
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.x2),
              itemCount: model.rows.length + 1,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                if (index == model.rows.length) {
                  return model.canLoadMore
                      ? AppButton.text(
                          title: 'Load more',
                          loading: model.isLoadingMore,
                          onPressed: model.loadMore,
                        )
                      : const SizedBox.shrink();
                }
                final row = model.rows[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.x1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: AppText.label(row.summary)),
                          if (row.practice)
                            const StatusBadge(
                              label: 'Practice',
                              tone: StatusTone.warning,
                            ),
                        ],
                      ),
                      AppText.caption(row.meta, numeric: true),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
