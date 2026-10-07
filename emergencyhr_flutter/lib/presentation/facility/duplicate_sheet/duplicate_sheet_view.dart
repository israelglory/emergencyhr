import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'duplicate_sheet_viewmodel.dart';

class DuplicateSheetView extends StatelessWidget {
  const DuplicateSheetView({super.key, required this.candidates});

  final List<DuplicateCandidate> candidates;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DuplicateSheetViewModel>.nonReactive(
      viewModelBuilder: () => DuplicateSheetViewModel(candidates: candidates),
      builder: (context, model, _) => AppSheet(
        title: model.title,
        children: [
          AppText.caption(model.message),
          AppListCard(
            children: [
              for (final row in model.rows)
                AppListRow(
                  title: row.name,
                  subtitle: row.detail,
                  trailing: AppButton(
                    title: 'Use this',
                    variant: row.first
                        ? AppButtonVariant.primary
                        : AppButtonVariant.secondary,
                    size: AppButtonSize.small,
                    expand: false,
                    onPressed: () => model.useExisting(row.id),
                  ),
                ),
            ],
          ),
          if (model.canCreateNew)
            AppButton.secondary(
              title: 'None of these. Create a new listing',
              size: AppButtonSize.medium,
              onPressed: model.createNew,
            ),
          AppButton.text(
            title: 'Cancel',
            color: context.palette.text,
            expand: true,
            onPressed: model.cancel,
          ),
        ],
      ),
    );
  }
}
