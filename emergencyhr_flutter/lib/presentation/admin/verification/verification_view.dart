import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'verification_viewmodel.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      viewModelBuilder: VerificationViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState();
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        if (model.isEmpty) {
          return const EmptyState(
            icon: Icons.verified_outlined,
            title: 'Nothing to verify',
            message: 'Submissions from agents and hospitals appear here.',
          );
        }
        return ShellPageFrame(
          child: RefreshIndicator(
            onRefresh: model.load,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.x2),
              children: [
                for (final row in model.rows) ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppText.title(row.name),
                        AppText.caption(row.detail),
                        AppText.caption(row.submitted),
                        if (row.notes != null) ...[
                          const SizedBox(height: AppSpacing.x1),
                          AppText(row.notes!),
                        ],
                        const SizedBox(height: AppSpacing.x2),
                        const AppText.label('Documents'),
                        for (final d in row.documents)
                          AppButton.text(
                            title: d.name,
                            icon: Icons.description_outlined,
                            onPressed: () => model.openDocument(d),
                          ),
                        const SizedBox(height: AppSpacing.x1),
                        const AppText.label('Checklist'),
                        ChecklistView(items: row.checklist),
                        const SizedBox(height: AppSpacing.x2),
                        Wrap(
                          spacing: AppSpacing.x1,
                          runSpacing: AppSpacing.x1,
                          children: [
                            AppButton(
                              title: 'Approve',
                              icon: Icons.check,
                              expand: false,
                              onPressed: () =>
                                  model.approve(row.facilityId, row.name),
                            ),
                            AppButton.secondary(
                              title: 'Reject',
                              icon: Icons.close,
                              expand: false,
                              onPressed: () =>
                                  model.reject(row.facilityId, row.name),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.x2),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
