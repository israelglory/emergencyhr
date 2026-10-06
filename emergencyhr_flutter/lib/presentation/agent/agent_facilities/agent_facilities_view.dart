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
        return ShellPageFrame(
          child: RefreshIndicator(
            onRefresh: model.load,
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.x2),
              itemCount: model.rows.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.x1),
              itemBuilder: (context, index) {
                final row = model.rows[index];
                return AppCard(
                  onTap: () => model.open(row.id),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.subtitle(row.name),
                            AppText.caption(row.detail),
                            if (row.nextAction != null)
                              AppText.caption(
                                row.nextAction!,
                                tone: AppTextTone.primary,
                              ),
                          ],
                        ),
                      ),
                      StatusBadge(
                        label: row.progress,
                        tone: row.progressTone,
                      ),
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
