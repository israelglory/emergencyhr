import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'users_viewmodel.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UsersViewModel>.reactive(
      viewModelBuilder: UsersViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => ShellPageFrame(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.x2),
              child: AppTextField(
                hintText: 'Search by name or phone',
                controller: model.searchController,
                onChanged: model.onSearchChanged,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: switch (model.state) {
                ViewState.loading => const LoadingState(),
                ViewState.error => ErrorState(
                  message: model.errorMessage!,
                  onRetry: model.load,
                ),
                ViewState.empty => const EmptyState(title: 'No accounts found'),
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
                          AppButton.text(
                            title: row.action,
                            onPressed: () => model.toggle(row),
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
