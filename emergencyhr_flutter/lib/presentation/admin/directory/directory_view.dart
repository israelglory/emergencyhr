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
      onViewModelReady: (model) => model.onReady(),
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
              Wrap(
                spacing: AppSpacing.x1,
                runSpacing: AppSpacing.x1,
                children: [
                  AppButton.secondary(
                    title: 'Import hospitals',
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: model.importHospitals,
                  ),
                  AppButton(
                    title: 'New listing',
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: model.createListing,
                  ),
                ],
              ),
            ],
          ),
          Wrap(
            spacing: AppSpacing.tight,
            runSpacing: AppSpacing.tight,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ToolbarSelect<String>(
                semanticsLabel: 'Area',
                value: model.area,
                options: model.areaOptions,
                onChanged: model.setArea,
              ),
              ToolbarSelect<String>(
                semanticsLabel: 'Show',
                value: model.show,
                options: model.showOptions,
                onChanged: model.setShow,
              ),
              if (model.isBulkRunning)
                AppText(
                  model.progressLabel!,
                  variant: AppTextVariant.caption,
                  tone: AppTextTone.primary,
                  fontWeight: FontWeight.w600,
                )
              else ...[
                AppButton.secondary(
                  title: DirectoryViewModel.selectAllLabel,
                  size: AppButtonSize.medium,
                  expand: false,
                  loading: model.isSelectingAll,
                  onPressed: model.selectAllVerifiable,
                ),
                if (model.hasSelection) ...[
                  AppText(
                    model.selectionLabel,
                    variant: AppTextVariant.caption,
                    tone: AppTextTone.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  AppButton.text(
                    title: 'Clear',
                    onPressed: model.clearSelection,
                  ),
                  AppButton(
                    title: model.verifySelectedLabel,
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: model.verifySelected,
                  ),
                ],
              ],
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
                TableColumn('', width: 32),
                TableColumn('Hospital', flex: 2),
                TableColumn('Address', flex: 2),
                TableColumn('Status'),
                TableColumn('', width: 200),
              ],
              empty: const AppText(
                'No hospitals found',
                tone: AppTextTone.secondary,
              ),
              rows: [
                for (final row in model.rows)
                  [
                    if (row.canVerify)
                      SizedBox.square(
                        dimension: 20,
                        child: Checkbox(
                          value: row.selected,
                          semanticLabel: 'Select ${row.name}',
                          onChanged: model.onToggle(row.id),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
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
                    Wrap(
                      spacing: AppSpacing.x1,
                      runSpacing: 6,
                      children: [
                        if (row.canVerify)
                          AppButton(
                            title: 'Verify',
                            size: AppButtonSize.small,
                            expand: false,
                            onPressed: () => model.verify(row),
                          ),
                        AppButton.secondary(
                          title: model.suspendLabel(row),
                          size: AppButtonSize.small,
                          expand: false,
                          onPressed: () => model.toggleSuspended(row),
                        ),
                      ],
                    ),
                  ],
              ],
            ),
          },
          if (model.hasMore)
            Center(
              child: AppButton.secondary(
                title: 'Load more',
                size: AppButtonSize.medium,
                expand: false,
                loading: model.isBusy,
                onPressed: model.loadMore,
              ),
            ),
        ],
      ),
    );
  }
}
