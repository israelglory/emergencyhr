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
            AppText(model.message, tone: AppTextTone.secondary),
            const SizedBox(height: AppSpacing.x2),
            for (final row in model.rows) ...[
              ChoiceTile(
                title: row.name,
                subtitle: row.detail,
                icon: Icons.local_hospital_outlined,
                onTap: () => model.useExisting(row.id),
                trailing: const AppText.label('Use this'),
              ),
              const SizedBox(height: AppSpacing.x1),
            ],
            if (model.canCreateNew) ...[
              const SizedBox(height: AppSpacing.x1),
              AppButton.secondary(
                title: 'None of these. Create a new listing',
                onPressed: model.createNew,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
