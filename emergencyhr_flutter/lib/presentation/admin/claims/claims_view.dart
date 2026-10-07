import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'claims_viewmodel.dart';

class ClaimsView extends StatelessWidget {
  const ClaimsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClaimsViewModel>.reactive(
      viewModelBuilder: ClaimsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Claims',
          subtitle: 'People claiming an existing listing',
          onRefresh: model.load,
          children: [
            if (model.state == ViewState.empty)
              const EmptyState(
                icon: Icons.how_to_reg_outlined,
                title: 'No claims to review',
              ),
            for (final row in model.rows)
              AppCard(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSpacing.x2,
                  runSpacing: AppSpacing.small,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 300,
                        maxWidth: 640,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText.title(row.title),
                          const SizedBox(height: 6),
                          AppText.caption(row.detail),
                          const SizedBox(height: 6),
                          StatusBadge(
                            label: row.deskBadge,
                            tone: row.deskTone,
                            dot: false,
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: AppSpacing.x1,
                      runSpacing: 8,
                      children: [
                        AppButton.secondary(
                          title: 'Open listing',
                          size: AppButtonSize.medium,
                          expand: false,
                          onPressed: () => model.openFacility(row),
                        ),
                        AppButton.secondary(
                          title: 'Reject',
                          size: AppButtonSize.medium,
                          expand: false,
                          onPressed: () => model.reject(row),
                        ),
                        AppButton(
                          title: 'Approve',
                          size: AppButtonSize.medium,
                          expand: false,
                          onPressed: () => model.approve(row),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
