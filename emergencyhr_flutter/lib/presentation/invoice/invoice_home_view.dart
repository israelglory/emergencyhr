import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/presentation/invoice/components/invoice_home_tile.dart';
import 'package:emergencyhr_flutter/presentation/invoice/create_invoice/create_invoice_view.dart';
import 'package:emergencyhr_flutter/presentation/invoice/invoice_details/invoice_details_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'invoice_home_viewmodel.dart';

class InvoiceHomeView extends StatelessWidget {
  const InvoiceHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InvoiceHomeViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => InvoiceHomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: SafeArea(
            child: Column(
              children: [
                // Top AppBar
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      const CustomAppBar(isBack: true, title: 'Invoices'),
                      const SizedBox(height: 12),

                      // Search Bar
                      AppCustomTextField(
                        hintText: 'Search by customer, phone, or invoice #',
                        textEditingController: model.searchController,
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
                      const SizedBox(height: 10),

                      // Branch Filter (Admin Only)
                      if (appGlobals.isAdmin && model.branches.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.storefront_outlined,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String?>(
                                  value: model.selectedBranchId,
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  hint: const AppText(
                                    'All Store Branches',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                  items: [
                                    const DropdownMenuItem<String?>(
                                      value: null,
                                      child: AppText(
                                        'All Store Branches',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    ...model.branches.map(
                                      (b) => DropdownMenuItem<String?>(
                                        value: b.id,
                                        child: AppText(
                                          '${b.name}${b.isMainBranch ? ' (Main)' : ''}',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                  onChanged: model.setBranchFilter,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 12),
                      ],

                      // Status Filter Chips
                      SizedBox(
                        height: 36,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildStatusFilterChip('All', 'ALL', model),
                            _buildStatusFilterChip('Unpaid', 'UNPAID', model),
                            _buildStatusFilterChip(
                              'Partially Paid',
                              'PARTIALLY_PAID',
                              model,
                            ),
                            _buildStatusFilterChip('Paid', 'PAID', model),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Invoices List
                Expanded(
                  child: model.isBusy && model.invoices.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: model.refreshInvoices,
                          color: AppColors.buttonColor,
                          child: model.hasInvoices
                              ? ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    12,
                                    16,
                                    80,
                                  ),
                                  itemCount: model.invoices.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 8),
                                  itemBuilder: (context, index) {
                                    final invoice = model.invoices[index];
                                    return InvoiceHomeTile(
                                      title: invoice.customerName,
                                      subtitle:
                                          '${invoice.invoiceNumber} • ${model.formatDate(invoice.invoiceDate)}',
                                      amount: CurrencyFormatter.formatNaira(
                                        invoice.total,
                                      ),
                                      status: invoice.status,
                                      remainingAmount:
                                          invoice.amountRemaining > 0.0001
                                          ? CurrencyFormatter.formatNaira(
                                              invoice.amountRemaining,
                                            )
                                          : null,
                                      onDelete: () =>
                                          _showDeleteConfirmationDialog(
                                            context,
                                            model,
                                            invoice.id,
                                          ),
                                      onEdit: () {},
                                      onTap: () async {
                                        await navigationService.push(
                                          InvoiceDetailsView(invoice: invoice),
                                        );
                                        model.loadInvoices(showLoading: false);
                                      },
                                      index: index,
                                    );
                                  },
                                )
                              : _buildEmptyState(context, model),
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await navigationService.push(const CreateInvoiceView());
              model.loadInvoices(showLoading: false);
            },
            backgroundColor: AppColors.primaryColor,
            elevation: 3,
            icon: const Icon(Icons.add, color: Colors.white, size: 20),
            label: const AppText(
              'New Invoice',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusFilterChip(
    String label,
    String statusValue,
    InvoiceHomeViewModel model,
  ) {
    final isSelected = model.selectedStatusFilter == statusValue;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
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
        onSelected: (_) => model.setStatusFilter(statusValue),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, InvoiceHomeViewModel model) {
    final hasSearch = model.searchController.text.trim().isNotEmpty;
    final hasStatusFilter = model.selectedStatusFilter != 'ALL';

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
                hasSearch || hasStatusFilter
                    ? Icons.receipt_long
                    : Icons.receipt_outlined,
                size: 54,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20),
            AppText(
              hasSearch || hasStatusFilter
                  ? 'No Invoices Found'
                  : 'No Invoices Issued Yet',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 8),
            AppText(
              hasSearch || hasStatusFilter
                  ? 'No invoice matched your search or status filter criteria.'
                  : 'Issue your first invoice to bill customers, track partial payments, and generate official receipts.',
              fontSize: 13,
              color: Colors.grey.shade600,
              alignment: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (hasSearch || hasStatusFilter)
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
                  model.setStatusFilter('ALL');
                },
                icon: const Icon(Icons.clear, size: 18),
                label: const AppText('Clear Filters', fontSize: 13),
              )
            else
              AppButton(
                title: '+ Create Invoice',
                wrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 44,
                onPressed: () async {
                  await navigationService.push(const CreateInvoiceView());
                  model.loadInvoices(showLoading: false);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    InvoiceHomeViewModel model,
    String invoiceId,
  ) {
    if (!appGlobals.canDelete) {
      snackbarService.error(
        message: 'Only Administrators have permission to delete invoices.',
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const AppText(
          'Delete Invoice',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        content: const AppText(
          'Are you sure you want to permanently delete this invoice?',
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
              model.deleteInvoice(invoiceId);
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
