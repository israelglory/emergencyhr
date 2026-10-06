import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'components/user_card.dart';
import 'user_list_viewmodel.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserListViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => UserListViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.primaryColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Team Members',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                AppText(
                  '${model.totalCount} ${model.totalCount == 1 ? "user" : "users"} registered',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.primaryColor,
                ),
                onPressed: () => model.openAddUserSheet(context),
                tooltip: 'Add Team Member',
              ),
              const SizedBox(width: 8),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            elevation: 3,
            icon: const Icon(Icons.add, size: 20),
            label: const AppText(
              'New User',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
            onPressed: () => model.openAddUserSheet(context),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  color: Colors.white,
                  child: AppCustomTextField(
                    textEditingController: model.searchController,
                    hintText: 'Search by user name or email...',
                    onChanged: model.onSearchChanged,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    suffixIcon: model.searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onPressed: model.clearSearch,
                          )
                        : null,
                  ),
                ),

                // Role Filter Chips Row
                Container(
                  color: Colors.white,
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildFilterChip('All Roles', 'ALL', model),
                      _buildFilterChip('Admins', 'ROLE_ADMIN', model),
                      _buildFilterChip('Staff', 'ROLE_STAFF', model),
                      _buildFilterChip('Sales Reps', 'ROLE_SALES_BOY', model),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Main User List
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => model.fetchUsers(showLoading: false),
                    color: AppColors.buttonColor,
                    child: model.isBusy && model.users.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : model.users.isEmpty
                        ? _buildEmptyState(context, model)
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                            itemCount: model.users.length,
                            itemBuilder: (context, index) {
                              final user = model.users[index];
                              final branchName = model.getBranchName(
                                user.branchId,
                              );

                              return UserCard(
                                user: user,
                                branchName: branchName,
                                onToggleStatus: () => _showStatusToggleDialog(
                                  context,
                                  model,
                                  user,
                                ),
                                onCopyEmail: () => model.copyToClipboard(
                                  user.email,
                                  'Email address',
                                ),
                                onCopyDetails: () => model.copyToClipboard(
                                  '${user.fullName}\n${user.email}\nRole: ${user.role}\nBranch: $branchName',
                                  user.fullName,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    String label,
    String roleValue,
    UserListViewModel model,
  ) {
    final isSelected = model.selectedRoleFilter == roleValue;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 6, bottom: 6),
      child: FilterChip(
        label: AppText(
          label,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.white : Colors.black87,
        ),
        selected: isSelected,
        selectedColor: AppColors.primaryColor,
        backgroundColor: Colors.grey.shade100,
        checkmarkColor: Colors.white,
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
          ),
        ),
        onSelected: (_) => model.setRoleFilter(roleValue),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, UserListViewModel model) {
    final hasSearch = model.searchController.text.trim().isNotEmpty;
    final hasFilter = model.selectedRoleFilter != 'ALL';

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: Icon(
                hasSearch || hasFilter
                    ? Icons.person_search
                    : Icons.group_outlined,
                size: 54,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20),
            AppText(
              hasSearch || hasFilter
                  ? 'No Matching Team Members'
                  : 'No Team Members Found',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 8),
            AppText(
              hasSearch || hasFilter
                  ? 'No user matched your active search or filter.'
                  : 'Invite or create team accounts for your store managers and sales representatives.',
              fontSize: 13,
              color: Colors.grey.shade600,
              alignment: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (hasSearch || hasFilter)
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  model.clearSearch();
                  model.setRoleFilter('ALL');
                },
                icon: const Icon(Icons.clear, size: 18),
                label: const AppText('Clear Filters', fontSize: 13),
              )
            else
              AppButton(
                title: '+ Add Team Member',
                wrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 44,
                onPressed: () => model.openAddUserSheet(context),
              ),
          ],
        ),
      ),
    );
  }

  void _showStatusToggleDialog(
    BuildContext context,
    UserListViewModel model,
    AppUser user,
  ) {
    final willDeactivate = user.isActive;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: AppText(
          willDeactivate ? 'Deactivate User' : 'Activate User',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        content: AppText(
          willDeactivate
              ? 'Are you sure you want to deactivate "${user.fullName}"? They will not be able to log in or process transactions.'
              : 'Activate "${user.fullName}"? They will regain access to their account.',
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
              model.toggleUserStatus(user);
            },
            child: AppText(
              willDeactivate ? 'Deactivate' : 'Activate',
              fontWeight: FontWeight.bold,
              color: willDeactivate ? Colors.red : Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
