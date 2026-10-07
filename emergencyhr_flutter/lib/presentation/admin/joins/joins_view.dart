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
      builder: (context, model, _) => WebPageState(
        isLoading: model.state == ViewState.loading,
        error: model.state == ViewState.error ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Join requests',
          subtitle: 'Hospitals asking for a visit',
          onRefresh: model.load,
          children: [
            if (model.state == ViewState.empty)
              const EmptyState(
                icon: Icons.mail_outline,
                title: 'No join requests',
              ),
            for (final row in model.rows)
              AppCard(
                child: SectionColumn(
                  gap: AppSpacing.tight,
                  children: [
                    Wrap(
                      spacing: AppSpacing.x1,
                      runSpacing: AppSpacing.half,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        AppText.title(row.title),
                        StatusBadge(
                          label: row.status,
                          tone: row.tone,
                          dot: false,
                        ),
                      ],
                    ),
                    AppText.caption(row.detail),
                    if (row.message != null) AppText.small(row.message!),
                    if (row.open)
                      Wrap(
                        spacing: AppSpacing.x1,
                        runSpacing: 8,
                        children: [
                          AppButton.secondary(
                            title: 'Mark contacted',
                            size: AppButtonSize.medium,
                            expand: false,
                            onPressed: () => model.markContacted(row),
                          ),
                          AppButton(
                            title: 'Assign a visit',
                            size: AppButtonSize.medium,
                            expand: false,
                            onPressed: () => model.convert(row),
                          ),
                          AppButton.text(
                            title: 'Close',
                            color: context.palette.text,
                            onPressed: () => model.close(row),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
