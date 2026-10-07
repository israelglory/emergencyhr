import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'staff_viewmodel.dart';

class StaffView extends StatelessWidget {
  const StaffView({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StaffViewModel>.reactive(
      viewModelBuilder: () => StaffViewModel(facilityId: facilityId),
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState(label: 'Loading staff');
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        final p = context.palette;
        return ListView(
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
                  gap: 18,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: 'Invite desk staff',
                            size: AppButtonSize.medium,
                            onPressed: model.inviteDeskStaff,
                          ),
                        ),
                        if (model.canInviteAdmins) ...[
                          const SizedBox(width: AppSpacing.tight),
                          Expanded(
                            child: AppButton.secondary(
                              title: 'Invite admin',
                              size: AppButtonSize.medium,
                              onPressed: model.inviteHospitalAdmin,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SectionColumn(
                      gap: AppSpacing.x1,
                      children: [
                        const AppText.caps('Staff'),
                        if (model.isEmpty)
                          const AppText(
                            'No staff yet. Invite at least one desk staff '
                            'member.',
                            tone: AppTextTone.secondary,
                          )
                        else
                          AppListCard(
                            children: [
                              for (final row in model.staff)
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    16,
                                    10,
                                    row.canRemove ? 4 : 16,
                                    10,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText.subtitle(row.name),
                                            const SizedBox(
                                              height: AppSpacing.half,
                                            ),
                                            AppText.caption(row.detail),
                                            const SizedBox(
                                              height: AppSpacing.half,
                                            ),
                                            StatusBadge(
                                              label: row.role,
                                              tone: StatusTone.neutral,
                                              dot: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (row.canRemove)
                                        IconButton(
                                          tooltip: 'Remove ${row.name}',
                                          color: p.textSecondary,
                                          icon: const Icon(
                                            Icons.person_remove_outlined,
                                          ),
                                          onPressed: () =>
                                              model.remove(row.member),
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        const AppText.caption(StaffViewModel.lastAdminHint),
                      ],
                    ),
                    if (model.hasPendingInvites)
                      SectionColumn(
                        gap: AppSpacing.x1,
                        children: [
                          const AppText.caps('Pending invites'),
                          AppListCard(
                            children: [
                              for (final row in model.pendingInvites)
                                AppListRow(
                                  title: row.label,
                                  subtitle: row.detail,
                                  trailing: AppButton.secondary(
                                    title: 'Cancel',
                                    size: AppButtonSize.small,
                                    expand: false,
                                    onPressed: () => model.revoke(row.invite),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
