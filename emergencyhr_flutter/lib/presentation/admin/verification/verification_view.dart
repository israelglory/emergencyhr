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
      builder: (context, model, _) => WebPageState(
        isLoading: model.isLoading,
        error: model.hasError ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Verification',
          subtitle: model.subtitle,
          onRefresh: model.load,
          children: [
            if (model.isEmpty)
              const EmptyState(
                icon: Icons.verified_outlined,
                title: 'Nothing to verify',
                message: 'New submissions from field agents appear here.',
              ),
            for (final row in model.rows)
              AppCard(
                padding: const EdgeInsets.all(20),
                child: SectionColumn(
                  gap: 14,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: AppSpacing.x2,
                      runSpacing: AppSpacing.small,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText.title(row.name),
                            const SizedBox(height: 3),
                            AppText.caption(row.detail),
                            AppText.caption(row.submitted),
                          ],
                        ),
                        Wrap(
                          spacing: AppSpacing.x1,
                          children: [
                            AppButton.secondary(
                              title: 'Reject',
                              size: AppButtonSize.medium,
                              expand: false,
                              onPressed: () =>
                                  model.reject(row.facilityId, row.name),
                            ),
                            AppButton(
                              title: 'Approve',
                              size: AppButtonSize.medium,
                              expand: false,
                              onPressed: () =>
                                  model.approve(row.facilityId, row.name),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (row.notes != null) NoticeBanner(message: row.notes!),
                    Wrap(
                      spacing: AppSpacing.x2,
                      runSpacing: AppSpacing.x2,
                      children: [
                        if (row.documents.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const AppText.caps('Documents'),
                              const SizedBox(height: AppSpacing.x1),
                              Wrap(
                                spacing: AppSpacing.x1,
                                runSpacing: AppSpacing.x1,
                                children: [
                                  for (final d in row.documents)
                                    _DocumentTile(
                                      name: d.name,
                                      image: d.image,
                                      onTap: () => model.openDocument(d),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 260),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText.caps(row.checklistTitle),
                              const SizedBox(height: AppSpacing.x1),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  for (final c in row.checklist)
                                    StatusBadge(
                                      label: c.label,
                                      tone: c.done
                                          ? StatusTone.positive
                                          : StatusTone.warning,
                                    ),
                                ],
                              ),
                            ],
                          ),
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

/// A 120 x 84 document preview tile with the file name at the bottom.
class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.name,
    required this.image,
    required this.onTap,
  });

  final String name;
  final bool image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final radius = BorderRadius.circular(AppRadius.status);
    return Semantics(
      button: true,
      label: 'Open $name',
      excludeSemantics: true,
      child: Material(
        color: image ? p.segmentTrack : p.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: image ? BorderSide.none : BorderSide(color: p.border),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            width: 120,
            height: 84,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(AppSpacing.x1),
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.micro.copyWith(color: p.textStrong),
            ),
          ),
        ),
      ),
    );
  }
}
