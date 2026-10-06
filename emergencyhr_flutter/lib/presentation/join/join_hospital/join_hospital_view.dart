import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'join_hospital_viewmodel.dart';

class JoinHospitalView extends StatelessWidget {
  const JoinHospitalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JoinHospitalViewModel>.reactive(
      viewModelBuilder: JoinHospitalViewModel.new,
      builder: (context, model, _) => AppPage(
        title: JoinHospitalViewModel.title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText(
              JoinHospitalViewModel.intro,
              tone: AppTextTone.secondary,
            ),
            const SizedBox(height: AppSpacing.x3),
            AppTextField(
              label: 'Hospital name',
              hintText: 'Start typing',
              controller: model.searchController,
              onChanged: model.onSearchChanged,
              prefixIcon: const Icon(Icons.search),
              textCapitalization: TextCapitalization.words,
            ),
            if (model.isBusy) ...[
              const SizedBox(height: AppSpacing.x1),
              const LinearProgressIndicator(),
            ],
            if (model.showResults) ...[
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Is this your hospital?'),
              if (model.noResults)
                const AppText(
                  'No listing found with that name.',
                  tone: AppTextTone.secondary,
                ),
              for (final row in model.results) ...[
                ChoiceTile(
                  title: row.name,
                  subtitle: row.address,
                  icon: Icons.local_hospital_outlined,
                  trailing: const AppText.label('Claim'),
                  onTap: () => model.claim(row),
                ),
                const SizedBox(height: AppSpacing.x1),
              ],
              const SizedBox(height: AppSpacing.x2),
              AppButton.secondary(
                title: 'My hospital is not listed',
                icon: Icons.add,
                onPressed: model.createNew,
              ),
            ],
            const SizedBox(height: AppSpacing.x4),
            const Divider(),
            const SizedBox(height: AppSpacing.x2),
            const AppText.subtitle('Not ready to sign up?'),
            const AppText(
              'Send us your details and a field agent will visit.',
              tone: AppTextTone.secondary,
            ),
            const SizedBox(height: AppSpacing.x1),
            AppButton.text(
              title: 'Send a join request',
              icon: Icons.mail_outline,
              onPressed: model.sendJoinRequest,
            ),
          ],
        ),
      ),
    );
  }
}
