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
      builder: (context, model, _) => AppSheet(
        title: model.title,
        children: [
          RadioOptionList(items: model.options, onSelected: model.select),
          AppTextField(
            label: 'Details (optional)',
            hintText: 'Up to 400 characters',
            controller: model.detailsController,
            maxLines: 3,
            minLines: 3,
            maxLength: 400,
          ),
          AppButton(
            title: 'Send report',
            loading: model.isBusy,
            onPressed: model.onSubmit,
          ),
        ],
      ),
    );
  }
}
