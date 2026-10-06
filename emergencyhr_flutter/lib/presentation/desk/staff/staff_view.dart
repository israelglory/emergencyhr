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
        return ShellPageFrame(
          maxWidth: AppSizes.contentMaxWidth,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.x2),
            children: [
              AppButton(
                title: 'Invite desk staff',
                icon: Icons.person_add_alt_outlined,
                onPressed: model.inviteDeskStaff,
              ),
              if (model.canInviteAdmins) ...[
                const SizedBox(height: AppSpacing.x1),
                AppButton.secondary(
                  title: 'Invite hospital admin',
                  icon: Icons.admin_panel_settings_outlined,
                  onPressed: model.inviteHospitalAdmin,
                ),
              ],
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Staff'),
              if (model.isEmpty)
                const AppText(
                  'No staff yet. Invite at least one desk staff member.',
                  tone: AppTextTone.secondary,
                ),
              for (final row in model.staff)
                AppCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x2,
                    vertical: AppSpacing.x1,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.subtitle(row.name),
                            AppText.caption(row.detail),
                          ],
                        ),
                      ),
                      StatusBadge(label: row.role, tone: StatusTone.neutral),
                      IconButton(
                        tooltip: 'Remove ${row.name}',
                        icon: const Icon(Icons.person_remove_outlined),
                        onPressed: () => model.remove(row.member),
                      ),
                    ],
                  ),
                ),
              if (model.hasPendingInvites) ...[
                const SizedBox(height: AppSpacing.x3),
                const SectionHeader('Pending invites'),
                for (final row in model.pendingInvites)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.x1),
                    child: AppCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.x2,
                        vertical: AppSpacing.x1,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.label(row.label, numeric: true),
                                AppText.caption(row.detail),
                              ],
                            ),
                          ),
                          AppButton.text(
                            title: 'Cancel',
                            onPressed: () => model.revoke(row.invite),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
