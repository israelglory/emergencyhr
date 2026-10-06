import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'new_hospitals_viewmodel.dart';

class NewHospitalsView extends StatelessWidget {
  const NewHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewHospitalsViewModel>.reactive(
      viewModelBuilder: NewHospitalsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => switch (model.state) {
        ViewState.loading => const LoadingState(),
        ViewState.error => ErrorState(
          message: model.errorMessage!,
          onRetry: model.load,
        ),
        ViewState.empty => const EmptyState(
          icon: Icons.fiber_new_outlined,
          title: 'No hospitals went live in the last 14 days',
        ),
        ViewState.ready => ShellPageFrame(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.x2),
            itemCount: model.rows.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, i) {
              final row = model.rows[i];
              return InkWell(
                onTap: () => model.open(row.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.x1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.label(row.name),
                            AppText.caption(row.detail),
                          ],
                        ),
                      ),
                      StatusBadge(label: row.badge, tone: row.tone),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      },
    );
  }
}
