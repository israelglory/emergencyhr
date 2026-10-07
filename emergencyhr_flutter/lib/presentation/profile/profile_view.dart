import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: ProfileViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final p = context.palette;
        final appBar = AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: AppSpacing.screen,
          title: Text(
            'Profile',
            style: AppTypography.heading.copyWith(fontSize: 22, color: p.text),
          ),
        );
        if (!model.isSignedIn) {
          return AppPage(
            appBar: appBar,
            scrollable: false,
            body: EmptyState(
              icon: Icons.person_outline,
              title: ProfileViewModel.signedOutTitle,
              message: ProfileViewModel.signedOutMessage,
              actionLabel: 'Sign in',
              onAction: model.signIn,
            ),
          );
        }
        if (model.isLoading) {
          return AppPage(
            appBar: appBar,
            scrollable: false,
            body: const LoadingState(label: 'Loading your profile'),
          );
        }
        return AppPage(
          appBar: appBar,
          body: SectionColumn(
            gap: 22,
            children: [
              AppCard(
                child: SectionColumn(
                  gap: AppSpacing.x2,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: p.disabledBg,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            model.initials,
                            style: AppTypography.bodyStrong.copyWith(
                              fontWeight: FontWeight.w700,
                              color: p.textStrong,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.small),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.subtitle(model.displayName),
                              AppText.caption(model.emailLabel),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppTextField(
                      label: 'Your name',
                      helperText: ProfileViewModel.nameHint,
                      controller: model.nameController,
                      textCapitalization: TextCapitalization.words,
                      autofillHints: const [AutofillHints.name],
                      errorText: model.nameError,
                      onChanged: model.onNameChanged,
                    ),
                    AppButton.secondary(
                      title: 'Save name',
                      size: AppButtonSize.medium,
                      loading: model.isSavingName,
                      onPressed: model.saveName,
                    ),
                    AppTextField(
                      label: 'Phone number (optional)',
                      hintText: '0803 000 0000',
                      helperText: ProfileViewModel.phoneHint,
                      controller: model.phoneController,
                      keyboardType: TextInputType.phone,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      errorText: model.phoneError,
                      onChanged: model.onPhoneChanged,
                    ),
                    AppButton.secondary(
                      title: 'Save phone number',
                      size: AppButtonSize.medium,
                      loading: model.isSavingPhone,
                      onPressed: model.savePhone,
                    ),
                  ],
                ),
              ),
              _Group(
                title: 'Emergency contacts',
                subtitle: model.contactsSubtitle,
                child: AppListCard(
                  children: [
                    for (final row in model.contacts)
                      AppListRow(
                        title: row.name,
                        subtitle: row.detail,
                        onTap: () => model.editContact(row.contact),
                        trailing: IconButton(
                          tooltip: 'Delete ${row.name}',
                          color: p.textSecondary,
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => model.deleteContact(row.contact),
                        ),
                      ),
                    if (model.canAddContact)
                      AppListRow(
                        leading: Icon(Icons.add, size: 20, color: p.text),
                        title: 'Add contact',
                        showChevron: false,
                        onTap: model.addContact,
                      ),
                  ],
                ),
              ),
              AppListCard(
                children: [
                  AppListRow(
                    leading: const IconTile(Icons.health_and_safety_outlined),
                    title: 'Medical details',
                    subtitle:
                        'Blood group, allergies, conditions, medicines. '
                        'Optional. Saved only with your consent.',
                    onTap: model.openMedical,
                  ),
                ],
              ),
              _Group(
                title: 'Roles',
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final role in model.roleLabels)
                      StatusBadge(
                        label: role,
                        tone: StatusTone.neutral,
                        dot: false,
                      ),
                  ],
                ),
              ),
              _Group(
                title: 'Your data',
                child: AppListCard(
                  children: [
                    AppListRow(
                      title: 'Export my data',
                      strongTitle: false,
                      trailing: model.isExporting
                          ? const AppLoader(size: 18)
                          : null,
                      showChevron: !model.isExporting,
                      onTap: model.exportData,
                    ),
                    AppListRow(
                      title: 'Sign out',
                      strongTitle: false,
                      onTap: model.signOut,
                    ),
                    AppListRow(
                      title: 'Delete my account',
                      titleTone: AppTextTone.critical,
                      showChevron: false,
                      onTap: model.deleteAccount,
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

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.child, this.subtitle});

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: AppText.caps(title)),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.x1),
          AppText.caption(subtitle!),
        ],
        const SizedBox(height: AppSpacing.x1),
        child,
      ],
    );
  }
}
