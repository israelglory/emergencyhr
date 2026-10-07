import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/cores.dart';
import 'import_sheet_viewmodel.dart';

class ImportSheetView extends StatelessWidget {
  const ImportSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImportSheetViewModel>.reactive(
      viewModelBuilder: ImportSheetViewModel.new,
      builder: (context, model, _) => AppSheet(
        title: ImportSheetViewModel.title,
        onClose: model.close,
        children: [
          if (model.step == ImportStep.choose) ...[
            const AppText.caption(ImportSheetViewModel.intro),
            AppButton(
              title: 'Choose CSV file',
              loading: model.isBusy,
              onPressed: model.chooseFile,
            ),
          ] else ...[
            AppText.subtitle(model.fileLabel),
            if (model.step == ImportStep.importing) ...[
              LinearProgressIndicator(value: model.progress),
              AppText.caption(model.progressLabel),
            ] else ...[
              AppListCard(
                children: [
                  for (final l in model.summaryLines)
                    KeyValueRow(label: l.label, value: l.value, inCard: true),
                ],
              ),
              for (final d in model.details) AppText.caption(d),
            ],
          ],
          if (model.problem != null)
            NoticeBanner(message: model.problem!, tone: StatusTone.critical),
          if (model.step == ImportStep.preview)
            AppButton(
              title: model.importLabel,
              loading: model.isBusy,
              onPressed: model.canImport ? model.import : null,
            ),
          if (model.step == ImportStep.done)
            AppButton(title: 'Done', onPressed: model.close),
        ],
      ),
    );
  }
}
