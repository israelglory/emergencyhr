import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'agents_viewmodel.dart';

class AgentsView extends StatelessWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgentsViewModel>.reactive(
      viewModelBuilder: AgentsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => ShellPageFrame(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.x2),
              child: AppButton(
                title: 'Add field agent',
                icon: Icons.person_add_alt_outlined,
                onPressed: model.add,
              ),
            ),
            Expanded(
              child: switch (model.state) {
                ViewState.loading => const LoadingState(),
                ViewState.error => ErrorState(
                  message: model.errorMessage!,
                  onRetry: model.load,
                ),
                ViewState.empty => const EmptyState(
                  icon: Icons.badge_outlined,
                  title: 'No field agents yet',
                ),
                ViewState.ready => ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x2,
                  ),
                  itemCount: model.rows.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, i) {
                    final row = model.rows[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.x1,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.label(row.name),
                          AppText.caption(row.detail),
                          Wrap(
                            spacing: AppSpacing.x1,
                            children: [
                              AppButton.text(
                                title: 'Edit areas',
                                onPressed: () => model.editAreas(row),
                              ),
                              AppButton.text(
                                title: 'Deactivate',
                                onPressed: () => model.deactivate(row),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
