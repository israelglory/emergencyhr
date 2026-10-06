import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'directory_viewmodel.dart';

class DirectoryView extends StatelessWidget {
  const DirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DirectoryViewModel>.reactive(
      viewModelBuilder: DirectoryViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => ShellPageFrame(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.x2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AppTextField(
                      hintText: 'Search hospitals',
                      controller: model.searchController,
                      onChanged: model.onSearchChanged,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.x1),
                  AppButton(
                    title: 'New listing',
                    icon: Icons.add,
                    expand: false,
                    onPressed: model.createListing,
                  ),
                ],
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
                  title: 'No hospitals found',
                ),
                ViewState.ready => ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x2,
                  ),
                  itemCount: model.rows.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, i) {
                    final row = model.rows[i];
                    return InkWell(
                      onTap: () => model.open(row.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.x1,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.label(row.name),
                                  AppText.caption(row.detail),
                                ],
                              ),
                            ),
                            StatusBadge(label: row.badge, tone: row.tone),
                            const SizedBox(width: AppSpacing.x1),
                            AppButton.text(
                              title: model.suspendLabel(row),
                              onPressed: () => model.toggleSuspended(row),
                            ),
                          ],
                        ),
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
