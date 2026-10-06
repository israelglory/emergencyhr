import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'claims_viewmodel.dart';

class ClaimsView extends StatelessWidget {
  const ClaimsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClaimsViewModel>.reactive(
      viewModelBuilder: ClaimsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => switch (model.state) {
        ViewState.loading => const LoadingState(),
        ViewState.error => ErrorState(
          message: model.errorMessage!,
          onRetry: model.load,
        ),
        ViewState.empty => const EmptyState(
          icon: Icons.how_to_reg_outlined,
          title: 'No pending claims',
        ),
        ViewState.ready => ShellPageFrame(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.x2),
            itemCount: model.rows.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, i) {
              final row = model.rows[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.x1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.label(row.title),
                    AppText.caption(row.detail),
                    Wrap(
                      spacing: AppSpacing.x1,
                      children: [
                        AppButton.text(
                          title: 'Open listing',
                          onPressed: () => model.openFacility(row),
                        ),
                        AppButton.text(
                          title: 'Approve',
                          icon: Icons.check,
                          onPressed: () => model.approve(row),
                        ),
                        AppButton.text(
                          title: 'Reject',
                          icon: Icons.close,
                          onPressed: () => model.reject(row),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      },
    );
  }
}
