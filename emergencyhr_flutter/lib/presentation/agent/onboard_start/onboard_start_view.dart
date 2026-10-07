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
      builder: (context, model, _) => ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.x2,
          AppSpacing.screen,
          AppSpacing.screen,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.contentMaxWidth,
              ),
              child: SectionColumn(
                gap: AppSpacing.x2,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.headline('Onboard a hospital'),
                      SizedBox(height: 6),
                      AppText(
                        OnboardStartViewModel.intro,
                        tone: AppTextTone.secondary,
                      ),
                    ],
                  ),
                  AppButton(
                    title: "I'm at the hospital",
                    icon: Icons.my_location_outlined,
                    loading: model.isLocating,
                    onPressed: model.imAtTheHospital,
                  ),
                  if (model.locationProblem != null)
                    NoticeBanner(
                      message: model.locationProblem!,
                      tone: StatusTone.warning,
                    ),
                  AppTextField(
                    label: 'Or search by name',
                    hintText: 'Hospital name',
                    controller: model.searchController,
                    onChanged: model.onSearchChanged,
                  ),
                  if (model.showResults) ...[
                    SectionColumn(
                      gap: AppSpacing.x1,
                      children: [
                        AppText.caps(model.resultsTitle),
                        if (model.isSearching) const LinearProgressIndicator(),
                        if (model.noResults)
                          const AppText(
                            'No listings found. Create a new one below.',
                            tone: AppTextTone.secondary,
                          )
                        else
                          AppListCard(
                            children: [
                              for (final row in model.results)
                                AppListRow(
                                  title: row.name,
                                  subtitle: row.detail,
                                  onTap: () => model.pick(row),
                                ),
                            ],
                          ),
                        const AppText.caption(OnboardStartViewModel.pickHint),
                      ],
                    ),
                    AppButton.secondary(
                      title: 'Not listed. Create a new listing',
                      size: AppButtonSize.medium,
                      onPressed: model.createNew,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
