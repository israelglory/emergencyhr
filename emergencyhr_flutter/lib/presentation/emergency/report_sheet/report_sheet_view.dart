import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'report_sheet_viewmodel.dart';

class ReportSheetView extends StatelessWidget {
  const ReportSheetView({
    super.key,
    required this.facilityId,
    required this.facilityName,
  });

  final int facilityId;
  final String facilityName;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportSheetViewModel>.reactive(
      viewModelBuilder: () => ReportSheetViewModel(
        facilityId: facilityId,
        facilityName: facilityName,
      ),
      builder: (context, model, _) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.x3,
          0,
          AppSpacing.x3,
          AppSpacing.x3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.title(model.title),
            const SizedBox(height: AppSpacing.x1),
            const AppText(
              ReportSheetViewModel.hint,
              tone: AppTextTone.secondary,
            ),
            const SizedBox(height: AppSpacing.x2),
            ChipGroup(items: model.options, onSelected: model.select),
            const SizedBox(height: AppSpacing.x2),
            AppTextField(
              label: 'Details (optional)',
              controller: model.detailsController,
              maxLines: 3,
              minLines: 2,
              maxLength: 400,
            ),
            const SizedBox(height: AppSpacing.x2),
            AppButton(
              title: 'Send report',
              loading: model.isBusy,
              onPressed: model.onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
