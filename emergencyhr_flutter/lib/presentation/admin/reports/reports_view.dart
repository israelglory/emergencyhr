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
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Reports',
          subtitle: 'Wrong status reports from the public',
          onRefresh: model.load,
          children: [
            if (model.state == ViewState.empty)
              const EmptyState(
                icon: Icons.flag_outlined,
                title: 'No open reports',
                message: 'Reports from the public appear here.',
              ),
            for (final row in model.rows)
              _ActionCard(
                title: row.name,
                badge: StatusBadge(label: row.badge, tone: row.tone),
                detail: row.detail,
                actions: [
                  AppButton.secondary(
                    title: 'Open',
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: () => model.open(row.id),
                  ),
                  AppButton(
                    title: 'Mark reviewed',
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: () => model.markReviewed(row),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// A card with a title, optional badge, meta line and buttons on the
/// right (wrapping under on narrow screens).
class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.detail,
    required this.actions,
    this.badge,
  });

  final String title;
  final Widget? badge;
  final String detail;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.x2,
        runSpacing: AppSpacing.small,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280, maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: AppSpacing.x1,
                  runSpacing: AppSpacing.half,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [AppText.title(title), ?badge],
                ),
                const SizedBox(height: 6),
                AppText.caption(detail),
              ],
            ),
          ),
          Wrap(spacing: AppSpacing.x1, runSpacing: 8, children: actions),
        ],
      ),
    );
  }
}
