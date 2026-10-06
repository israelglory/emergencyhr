import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'branch_list_viewmodel.dart';
import 'components/branch_card.dart';

class BranchListView extends StatelessWidget {
  const BranchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BranchListViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => BranchListViewModel(),
      builder: (context, model, child) {
        final canEdit = appGlobals.canEdit;

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
                  'Store Branches',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                AppText(
                  '${model.totalCount} ${model.totalCount == 1 ? "location" : "locations"} configured',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            actions: [
              if (canEdit)
                IconButton(
                  icon: const Icon(
                    Icons.add_business_outlined,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () => model.openAddBranchSheet(context),
                  tooltip: 'Add Branch',
                ),
              const SizedBox(width: 8),
            ],
          ),
          floatingActionButton: canEdit
              ? FloatingActionButton.extended(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  icon: const Icon(Icons.add, size: 20),
                  label: const AppText(
                    'New Branch',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                  onPressed: () => model.openAddBranchSheet(context),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  color: Colors.white,
                  child: AppCustomTextField(
                    textEditingController: model.searchController,
                    hintText: 'Search by branch name, address, or phone...',
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
                const Divider(height: 1),

                // Main List Area
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => model.fetchBranches(showLoading: false),
                    color: AppColors.buttonColor,
                    child: model.isBusy && model.branches.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : model.branches.isEmpty
                        ? _buildEmptyState(context, model)
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                            itemCount: model.branches.length,
                            itemBuilder: (context, index) {
                              final branch = model.branches[index];
                              return BranchCard(
                                branch: branch,
                                onEdit: () =>
                                    model.openEditBranchSheet(context, branch),
                                onCall: () => model.callPhone(branch.phone),
                                onCopy: () => model.copyToClipboard(
                                  '${branch.name}\n${branch.address}\n${branch.phone}',
                                  branch.name,
                                ),
                                onDelete: () => _showDeleteDialog(
                                  context,
                                  model,
                                  branch,
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

  Widget _buildEmptyState(BuildContext context, BranchListViewModel model) {
    final isSearching = model.searchController.text.trim().isNotEmpty;
    final canEdit = appGlobals.canEdit;

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
                isSearching ? Icons.search_off : Icons.storefront_outlined,
                size: 54,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20),
            AppText(
              isSearching ? 'No Branches Found' : 'No Branches Configured',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 8),
            AppText(
              isSearching
                  ? 'No store branch was found matching "${model.searchController.text.trim()}".'
                  : 'Add multiple store branches or outlets to manage inventory and sales across locations.',
              fontSize: 13,
              color: Colors.grey.shade600,
              alignment: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (isSearching)
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: model.clearSearch,
                icon: const Icon(Icons.clear, size: 18),
                label: const AppText('Clear Search', fontSize: 13),
              )
            else if (canEdit)
              AppButton(
                title: '+ Add First Branch',
                wrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 44,
                onPressed: () => model.openAddBranchSheet(context),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    BranchListViewModel model,
    Branch branch,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const AppText(
          'Delete Branch',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        content: AppText(
          'Are you sure you want to delete "${branch.name}"? This action cannot be undone.',
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
              model.deleteBranch(branch.id);
            },
            child: const AppText(
              'Delete',
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
