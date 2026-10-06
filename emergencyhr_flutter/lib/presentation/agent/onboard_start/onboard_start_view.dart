import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'onboard_start_viewmodel.dart';

class OnboardStartView extends StatelessWidget {
  const OnboardStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardStartViewModel>.reactive(
      viewModelBuilder: OnboardStartViewModel.new,
      builder: (context, model, _) => ShellPageFrame(
        maxWidth: AppSizes.contentMaxWidth,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.x2),
          children: [
            const AppText.headline('Onboard a hospital'),
            const SizedBox(height: AppSpacing.x1),
            const AppText(
              OnboardStartViewModel.intro,
              tone: AppTextTone.secondary,
            ),
            const SizedBox(height: AppSpacing.x3),
            AppButton(
              title: "I'm at the hospital",
              icon: Icons.my_location_outlined,
              large: true,
              loading: model.isLocating,
              onPressed: model.imAtTheHospital,
            ),
            if (model.locationProblem != null) ...[
              const SizedBox(height: AppSpacing.x2),
              NoticeBanner(
                message: model.locationProblem!,
                tone: StatusTone.warning,
                icon: Icons.location_off_outlined,
              ),
            ],
            const SizedBox(height: AppSpacing.x2),
            AppTextField(
              label: 'Or search by name',
              hintText: 'Hospital name',
              controller: model.searchController,
              onChanged: model.onSearchChanged,
              prefixIcon: const Icon(Icons.search),
            ),
            if (model.showResults) ...[
              const SizedBox(height: AppSpacing.x3),
              SectionHeader(model.resultsTitle),
              if (model.isSearching) const LinearProgressIndicator(),
              if (model.noResults)
                const AppText(
                  'No listings found. Create a new one below.',
                  tone: AppTextTone.secondary,
                ),
              for (final row in model.results) ...[
                ChoiceTile(
                  title: row.name,
                  subtitle: row.detail,
                  icon: Icons.local_hospital_outlined,
                  onTap: () => model.pick(row),
                ),
                const SizedBox(height: AppSpacing.x1),
              ],
              const SizedBox(height: AppSpacing.x2),
              AppButton.secondary(
                title: 'Not listed. Create a new listing',
                icon: Icons.add,
                onPressed: model.createNew,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
