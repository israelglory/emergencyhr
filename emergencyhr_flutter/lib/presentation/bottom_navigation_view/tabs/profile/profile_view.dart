import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/branches/branch_list_view.dart';
import 'package:emergencyhr_flutter/presentation/customers/customer_list_view.dart';
import 'package:emergencyhr_flutter/presentation/user_management/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Header
                  const AppText(
                    'Profile & Settings',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),

                  // Avatar & Business Header Card
                  _buildProfileCard(model),
                  const SizedBox(height: 20),

                  // Business Contact & Locations
                  _buildBusinessInfoCard(model),
                  const SizedBox(height: 20),

                  // Payment Bank Account Card
                  _buildPaymentAccountCard(context, model),
                  const SizedBox(height: 20),

                  // Settings / Actions
                  _buildSettingsSection(context, model),
                  const SizedBox(height: 30),

                  // Version Info
                  Center(
                    child: AppText(
                      'BGlow Creation v${model.appVersion}',
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(ProfileViewModel model) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(AppAssets.bglowLogoPng),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  model.businessName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                AppText(
                  'Owner: ${model.ownerName}',
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_outlined,
                        size: 13,
                        color: AppColors.buttonColor,
                      ),
                      const SizedBox(width: 4),
                      AppText(
                        UserRoles.getRoleLabel(appGlobals.user?.role),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttonColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInfoCard(ProfileViewModel model) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.business_outlined,
                color: AppColors.primaryColor,
                size: 18,
              ),
              SizedBox(width: 8),
              AppText(
                'Business Locations',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Office 1
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        'Head Office / Primary Branch',
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        model.office1,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16),

          // Office 2
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        'Secondary Branch',
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        model.office2,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentAccountCard(
    BuildContext context,
    ProfileViewModel model,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_balance_outlined,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  AppText(
                    'Default Payment Account',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ],
              ),
              Row(
                children: [
                  if (appGlobals.isAdmin)
                    InkWell(
                      onTap: () => model.openUpdateBankDetailsSheet(context),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 12,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 4),
                            AppText(
                              'Edit',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 16, color: Colors.grey),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => model.copyToClipboard(
                      model.accountNumber,
                      'Account number',
                    ),
                    tooltip: 'Copy account number',
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText('Bank:', fontSize: 13, color: Colors.grey),
              AppText(
                model.bankName,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Account Number:',
                fontSize: 13,
                color: Colors.grey,
              ),
              AppText(
                model.accountNumber,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText('Account Name:', fontSize: 13, color: Colors.grey),
              AppText(
                model.accountName,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, ProfileViewModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Store Branches (Admin Only)
          if (appGlobals.isAdmin) ...[
            ListTile(
              leading: const Icon(
                Icons.storefront_outlined,
                color: AppColors.primaryColor,
              ),
              title: const AppText(
                'Store Branches',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              subtitle: AppText(
                '${appGlobals.user?.branches.length ?? 0} store ${appGlobals.user?.branches.length == 1 ? "location" : "locations"}',
                fontSize: 12,
                color: Colors.grey,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                navigationService.push(const BranchListView());
              },
            ),
            const Divider(height: 1),

            // User Management (Admin Only)
            ListTile(
              leading: const Icon(
                Icons.manage_accounts_outlined,
                color: AppColors.primaryColor,
              ),
              title: const AppText(
                'Team & User Management',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              subtitle: const AppText(
                'Manage staff accounts, roles & permissions',
                fontSize: 12,
                color: Colors.grey,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                navigationService.push(const UserListView());
              },
            ),
            const Divider(height: 1),

            // Settlement Bank Details (Admin Only)
            ListTile(
              leading: const Icon(
                Icons.account_balance_outlined,
                color: AppColors.primaryColor,
              ),
              title: const AppText(
                'Settlement Bank Details',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              subtitle: AppText(
                '${model.bankName} • ${model.accountNumber}',
                fontSize: 12,
                color: Colors.grey,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                model.openUpdateBankDetailsSheet(context);
              },
            ),
            const Divider(height: 1),
          ],

          // Customer Directory (All Roles)
          ListTile(
            leading: const Icon(
              Icons.people_outline,
              color: AppColors.primaryColor,
            ),
            title: const AppText(
              'Customer Directory',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey,
            ),
            onTap: () {
              navigationService.push(const CustomerListView());
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(
              Icons.share_outlined,
              color: AppColors.primaryColor,
            ),
            title: const AppText(
              'Share App',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey,
            ),
            onTap: model.shareApp,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: AppColors.primaryColor,
            ),
            title: const AppText(
              'About BGlow Creation',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey,
            ),
            onTap: () {
              _showAboutDialog(context, model);
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const AppText(
              'Log Out',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.red,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey,
            ),
            onTap: () {
              _showLogoutDialog(context, model);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileViewModel model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const AppText(
          'Sign Out',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        content: const AppText(
          'Are you sure you want to sign out of your account?',
          fontSize: 13,
          color: Colors.black87,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const AppText('Cancel', color: Colors.grey),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              model.logout();
            },
            child: const AppText(
              'Sign Out',
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context, ProfileViewModel model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Image.asset(AppAssets.bglowLogoPng, width: 32, height: 32),
            const SizedBox(width: 10),
            const AppText(
              'About BGlow',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              model.businessName,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 4),
            const AppText(
              'Professional tailoring, custom fashion designs, invoice generation, and receipt management application.',
              fontSize: 13,
              color: Colors.black87,
            ),
            const SizedBox(height: 12),
            AppText(
              'Owner: ${model.ownerName}',
              fontSize: 12,
              color: Colors.grey,
            ),
            AppText(
              'Contact: ${model.phone}',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            AppText(
              'Version ${model.appVersion}',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const AppText('Close', color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
