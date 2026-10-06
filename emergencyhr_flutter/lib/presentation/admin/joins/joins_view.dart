import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'joins_viewmodel.dart';

class JoinsView extends StatelessWidget {
  const JoinsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JoinsViewModel>.reactive(
      viewModelBuilder: JoinsViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => switch (model.state) {
        ViewState.loading => const LoadingState(),
        ViewState.error => ErrorState(
          message: model.errorMessage!,
          onRetry: model.load,
        ),
        ViewState.empty => const EmptyState(
          icon: Icons.mail_outline,
          title: 'No join requests',
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
                    Row(
                      children: [
                        Expanded(child: AppText.label(row.title)),
                        StatusBadge(
                          label: row.status,
                          tone: StatusTone.neutral,
                        ),
                      ],
                    ),
                    AppText.caption(row.detail),
                    if (row.message != null) AppText.small(row.message!),
                    if (row.open)
                      Wrap(
                        spacing: AppSpacing.x1,
                        children: [
                          AppButton.text(
                            title: 'Mark contacted',
                            onPressed: () => model.markContacted(row),
                          ),
                          AppButton.text(
                            title: 'Assign a visit',
                            icon: Icons.assignment_ind_outlined,
                            onPressed: () => model.convert(row),
                          ),
                          AppButton.text(
                            title: 'Close',
                            onPressed: () => model.close(row),
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
