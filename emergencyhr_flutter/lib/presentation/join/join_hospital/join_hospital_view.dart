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
      builder: (context, model, _) {
        final p = context.palette;
        return AppPage(
          title: JoinHospitalViewModel.title,
          body: SectionColumn(
            gap: AppSpacing.x2,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.headline(JoinHospitalViewModel.heading),
                  SizedBox(height: AppSpacing.x1),
                  AppText(
                    JoinHospitalViewModel.intro,
                    tone: AppTextTone.secondary,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    label: 'Hospital name',
                    controller: model.searchController,
                    onChanged: model.onSearchChanged,
                    prefixIcon: const Icon(Icons.search),
                    textCapitalization: TextCapitalization.words,
                  ),
                  if (model.isBusy) ...[
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        backgroundColor: p.divider,
                      ),
                    ),
                  ],
                ],
              ),
              if (model.showResults) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppText.caps('Is this your hospital?'),
                    const SizedBox(height: AppSpacing.x1),
                    if (model.noResults)
                      const AppText(
                        'No listing found with that name.',
                        tone: AppTextTone.secondary,
                      )
                    else
                      AppListCard(
                        children: [
                          for (final row in model.results)
                            AppListRow(
                              title: row.name,
                              subtitle: row.address,
                              trailing: AppButton.secondary(
                                title: 'Claim',
                                size: AppButtonSize.small,
                                expand: false,
                                onPressed: () => model.claim(row),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                AppButton.secondary(
                  title: 'My hospital is not listed',
                  size: AppButtonSize.medium,
                  onPressed: model.createNew,
                ),
              ],
              AppCard(
                color: p.primaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText.subtitle('Not ready to sign up?'),
                    const SizedBox(height: 6),
                    const AppText.caption(
                      'Send us your details and a field agent will visit.',
                    ),
                    const SizedBox(height: AppSpacing.x1),
                    AppButton.text(
                      title: 'Send a join request',
                      onPressed: model.sendJoinRequest,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
