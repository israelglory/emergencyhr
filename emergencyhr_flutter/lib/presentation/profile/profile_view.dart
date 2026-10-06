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
        if (!model.isSignedIn) {
          return AppPage(
            title: 'Profile',
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
          return const AppPage(
            title: 'Profile',
            scrollable: false,
            body: LoadingState(label: 'Loading your profile'),
          );
        }
        return AppPage(
          title: 'Profile',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionHeader('Account'),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KeyValueRow(label: 'Phone', value: model.phoneLabel),
                    const SizedBox(height: AppSpacing.x2),
                    AppTextField(
                      label: 'Your name',
                      hintText: 'Used in family alerts',
                      controller: model.nameController,
                      textCapitalization: TextCapitalization.words,
                      autofillHints: const [AutofillHints.name],
                      errorText: model.nameError,
                      onChanged: model.onNameChanged,
                    ),
                    const SizedBox(height: AppSpacing.x2),
                    AppButton.secondary(
                      title: 'Save name',
                      loading: model.isSavingName,
                      onPressed: model.saveName,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.x3),
              SectionHeader(
                'Emergency contacts',
                subtitle: model.contactsSubtitle,
              ),
              for (final row in model.contacts)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.x1),
                  child: AppCard(
                    onTap: () => model.editContact(row.contact),
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
                              AppText.caption(row.detail, numeric: true),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Remove ${row.name}',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => model.deleteContact(row.contact),
                        ),
                      ],
                    ),
                  ),
                ),
              if (model.canAddContact)
                AppButton.secondary(
                  title: 'Add contact',
                  icon: Icons.person_add_alt_outlined,
                  onPressed: model.addContact,
                ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Medical details'),
              ChoiceTile(
                title: 'Blood group, allergies, conditions, medicines',
                subtitle: 'Optional. Saved only with your consent.',
                icon: Icons.health_and_safety_outlined,
                onTap: model.openMedical,
              ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Roles'),
              for (final role in model.roleLabels)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.x1),
                  child: AppText(role),
                ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Your data'),
              AppButton.secondary(
                title: 'Export my data',
                icon: Icons.download_outlined,
                loading: model.isExporting,
                onPressed: model.exportData,
              ),
              const SizedBox(height: AppSpacing.x1),
              AppButton.secondary(
                title: 'Sign out',
                icon: Icons.logout,
                onPressed: model.signOut,
              ),
              const SizedBox(height: AppSpacing.x1),
              AppButton.text(
                title: 'Delete my account',
                icon: Icons.delete_forever_outlined,
                onPressed: model.deleteAccount,
              ),
            ],
          ),
        );
      },
    );
  }
}
