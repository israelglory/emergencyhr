import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'agent_facilities_viewmodel.dart';

class AgentFacilitiesView extends StatelessWidget {
  const AgentFacilitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgentFacilitiesViewModel>.reactive(
      viewModelBuilder: AgentFacilitiesViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState();
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        if (model.isEmpty) {
          return const EmptyState(
            icon: Icons.assignment_outlined,
            title: 'No hospitals assigned yet',
            message: 'A platform admin assigns hospitals and areas to you.',
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
                      const AppText.headline('My hospitals'),
                      const AppText.caption('Sorted by next action date'),
                      AppListCard(
                        children: [
                          for (final row in model.rows)
                            InkWell(
                              onTap: () => model.open(row.id),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText.subtitle(row.name),
                                          const SizedBox(
                                            height: AppSpacing.half,
                                          ),
                                          AppText.caption(row.detail),
                                          const SizedBox(
                                            height: AppSpacing.half,
                                          ),
                                          AppText.caption(
                                            row.nextAction,
                                            tone: AppTextTone.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                    StatusBadge(
                                      label: row.progress,
                                      tone: row.progressTone,
                                      dot: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
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
