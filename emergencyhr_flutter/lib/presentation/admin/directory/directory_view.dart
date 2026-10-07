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
      builder: (context, model, _) => WebPage(
        title: 'Directory',
        subtitle: 'Every listing in the pilot areas',
        onRefresh: model.load,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: AppSpacing.tight,
            runSpacing: AppSpacing.tight,
            children: [
              ToolbarSearch(
                hint: 'Search hospitals',
                controller: model.searchController,
                onChanged: model.onSearchChanged,
              ),
              AppButton(
                title: 'New listing',
                size: AppButtonSize.medium,
                expand: false,
                onPressed: model.createListing,
              ),
            ],
          ),
          switch (model.state) {
            ViewState.loading => const LoadingState(),
            ViewState.error => ErrorState(
              message: model.errorMessage!,
              onRetry: model.load,
            ),
            _ => DataTableCard(
              columns: const [
                TableColumn('Hospital', flex: 2),
                TableColumn('Address', flex: 2),
                TableColumn('Status'),
                TableColumn('', width: 120),
              ],
              empty: const AppText(
                'No hospitals found',
                tone: AppTextTone.secondary,
              ),
              rows: [
                for (final row in model.rows)
                  [
                    InkWell(
                      onTap: () => model.open(row.id),
                      child: AppText.subtitle(row.name),
                    ),
                    AppText.caption(row.detail),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StatusBadge(
                        label: row.badge,
                        tone: row.tone,
                        dot: false,
                      ),
                    ),
                    AppButton.secondary(
                      title: model.suspendLabel(row),
                      size: AppButtonSize.small,
                      expand: false,
                      onPressed: () => model.toggleSuspended(row),
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
