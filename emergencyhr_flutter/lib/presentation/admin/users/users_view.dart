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
      builder: (context, model, _) => WebPage(
        title: 'Accounts',
        subtitle: 'Everyone with an EmergencyHr account',
        onRefresh: model.load,
        children: [
          ToolbarSearch(
            hint: 'Search by name, email or phone',
            width: 360,
            controller: model.searchController,
            onChanged: model.onSearchChanged,
          ),
          switch (model.state) {
            ViewState.loading => const LoadingState(),
            ViewState.error => ErrorState(
              message: model.errorMessage!,
              onRetry: model.load,
            ),
            _ => DataTableCard(
              columns: const [
                TableColumn('Name', flex: 2),
                TableColumn('Roles', flex: 2),
                TableColumn('State'),
                TableColumn('', width: 130),
              ],
              empty: const AppText(
                'No accounts found',
                tone: AppTextTone.secondary,
              ),
              rows: [
                for (final row in model.rows)
                  [
                    NameCell(row.name, detail: row.contact),
                    AppText.small(row.roles),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: row.suspended
                          ? const StatusBadge(
                              label: 'Suspended',
                              tone: StatusTone.critical,
                              dot: false,
                            )
                          : const AppText.caption('Active'),
                    ),
                    AppButton.secondary(
                      title: row.action,
                      size: AppButtonSize.small,
                      expand: false,
                      onPressed: () => model.toggle(row),
                    ),
                  ],
              ],
            ),
          },
        ],
      ),
    );
  }
}
