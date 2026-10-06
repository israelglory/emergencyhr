import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'components/customer_card.dart';
import 'customer_list_viewmodel.dart';

class CustomerListView extends StatelessWidget {
  final bool isBack;

  const CustomerListView({super.key, this.isBack = true});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerListViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => CustomerListViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: isBack
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                : null,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Customers',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                AppText(
                  '${model.totalCount} ${model.totalCount == 1 ? "customer" : "customers"} found',
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
                onPressed: () => model.openAddCustomerSheet(context),
                tooltip: 'Add Customer',
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
              'New Customer',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
            onPressed: () => model.openAddCustomerSheet(context),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Search Bar Header
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  color: Colors.white,
                  child: AppCustomTextField(
                    textEditingController: model.searchController,
                    hintText: 'Search by customer name, phone, or address...',
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

                // Main Customer List Area
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => model.fetchCustomers(showLoading: false),
                    color: AppColors.buttonColor,
                    child: model.isBusy && model.customers.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : model.customers.isEmpty
                        ? _buildEmptyState(context, model)
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                            itemCount: model.customers.length,
                            itemBuilder: (context, index) {
                              final customer = model.customers[index];
                              return CustomerCard(
                                customer: customer,
                                onEdit: () => model.openEditCustomerSheet(
                                  context,
                                  customer,
                                ),
                                onViewDetails: () => model
                                    .openViewCustomerDetails(context, customer),
                                onCall: () =>
                                    model.callCustomer(customer.phone),
                                onCopy: () => model.copyToClipboard(
                                  '${customer.name}\n${customer.phone}\n${customer.address}',
                                  customer.name,
                                ),
                                onDelete: () => _showDeleteDialog(
                                  context,
                                  model,
                                  customer,
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

  Widget _buildEmptyState(BuildContext context, CustomerListViewModel model) {
    final isSearching = model.searchController.text.trim().isNotEmpty;

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
                isSearching ? Icons.person_search : Icons.people_outline,
                size: 54,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20),
            AppText(
              isSearching ? 'No Matching Customers' : 'No Customers Yet',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 8),
            AppText(
              isSearching
                  ? 'No customer was found matching "${model.searchController.text.trim()}".'
                  : 'Start adding your customers and business clients to easily generate invoices and manage orders.',
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
            else
              AppButton(
                title: '+ Add First Customer',
                wrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 44,
                onPressed: () => model.openAddCustomerSheet(context),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    CustomerListViewModel model,
    Customer customer,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const AppText(
          'Delete Customer',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        content: AppText(
          'Are you sure you want to delete "${customer.name}"? This action cannot be undone.',
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
              model.deleteCustomer(customer.id);
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
