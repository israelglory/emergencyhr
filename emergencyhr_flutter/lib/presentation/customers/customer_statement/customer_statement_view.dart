import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:emergencyhr_flutter/presentation/invoice/create_invoice/create_invoice_view.dart';
import 'package:emergencyhr_flutter/presentation/invoice/invoice_details/invoice_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customer_statement_viewmodel.dart';

class CustomerStatementView extends StatelessWidget {
  final Customer customer;

  const CustomerStatementView({super.key, required this.customer});

  Future<void> _callPhone(String phone) async {
    if (phone.isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (_) {}
  }

  void _copy(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    snackbarService.success(message: '$label copied to clipboard!');
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerStatementViewModel>.reactive(
      viewModelBuilder: () => CustomerStatementViewModel(customer: customer),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        final statement = model.statement;
        final invoices = model.filteredInvoices;

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
                AppText(
                  customer.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const AppText(
                  'Invoices & Statement',
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                tooltip: 'Share Statement',
                onPressed: model.shareStatementSummary,
              ),
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
                tooltip: 'Refresh',
                onPressed: () => model.loadStatement(showLoading: true),
              ),
              const SizedBox(width: 4),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: AppButton(
                title: 'Create Invoice for ${customer.name}',
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 48,
                onPressed: () {
                  navigationService.push(
                    CreateInvoiceView(
                      prefilledCustomerName: customer.name,
                      prefilledCustomerAddress: customer.address,
                      prefilledCustomerPhone: customer.phone,
                    ),
                  );
                },
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => model.loadStatement(showLoading: false),
              color: AppColors.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer Profile Info Card
                    _buildCustomerProfileCard(context, customer),
                    const SizedBox(height: 14),

                    // Financial Summary Hero Card
                    _buildStatementSummaryCard(statement),
                    const SizedBox(height: 16),

                    // Search Invoices
                    _buildSearchBar(model),
                    const SizedBox(height: 12),

                    // Status Filter Chips
                    _buildFilterChips(model),
                    const SizedBox(height: 14),

                    // Section Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          'Invoices History (${invoices.length})',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        if (statement.totalAmount > 0)
                          AppText(
                            '${statement.collectionRate.toStringAsFixed(0)}% Settled',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Invoices List
                    if (model.isBusy && statement.invoices.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    else if (invoices.isEmpty)
                      _buildEmptyInvoicesState(context, model)
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: invoices.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final inv = invoices[index];
                          return _buildInvoiceCard(context, inv);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomerProfileCard(BuildContext context, Customer c) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                child: AppText(
                  c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      c.name,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      'Customer Account',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),

          // Phone Row
          if (c.phone.isNotEmpty) ...[
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    c.phone,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () => _callPhone(c.phone),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 12,
                          color: Colors.green.shade700,
                        ),
                        const SizedBox(width: 4),
                        AppText(
                          'Call',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16, color: Colors.grey),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _copy(c.phone, 'Phone number'),
                  tooltip: 'Copy Phone',
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Address Row
          if (c.address.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    c.address,
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16, color: Colors.grey),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _copy(c.address, 'Customer address'),
                  tooltip: 'Copy Address',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatementSummaryCard(CustomerStatement statement) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Financial Statement Summary',
                fontSize: 13,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AppText(
                  '${statement.totalInvoices} Invoices',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Total Billed Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Total Billed',
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    CurrencyFormatter.formatNaira(statement.totalAmount),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const AppText(
                    'Outstanding Balance',
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    CurrencyFormatter.formatNaira(statement.totalRemaining),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statement.totalRemaining > 0
                        ? Colors.orangeAccent
                        : Colors.greenAccent,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: statement.totalAmount > 0
                  ? (statement.totalPaid / statement.totalAmount).clamp(
                      0.0,
                      1.0,
                    )
                  : 0.0,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.greenAccent,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),

          // Sub metrics row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 14,
                    color: Colors.greenAccent,
                  ),
                  const SizedBox(width: 4),
                  AppText(
                    'Paid: ${CurrencyFormatter.formatNaira(statement.totalPaid)}',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.pie_chart_outline,
                    size: 14,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 4),
                  AppText(
                    '${statement.collectionRate.toStringAsFixed(1)}% Collected',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(CustomerStatementViewModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: model.searchController,
        onChanged: model.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search customer invoices by number or item...',
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
          suffixIcon: model.searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: model.clearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(CustomerStatementViewModel model) {
    final filters = [
      {'label': 'All', 'count': model.statement.totalInvoices},
      {'label': 'Paid', 'count': model.statement.paidCount},
      {'label': 'Partially Paid', 'count': model.statement.partiallyPaidCount},
      {'label': 'Unpaid', 'count': model.statement.unpaidCount},
    ];

    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final f = filters[index];
          final label = f['label'] as String;
          final count = f['count'] as int;
          final isSelected = model.selectedStatusFilter == label;

          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: FilterChip(
              label: AppText(
                '$label ($count)',
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryColor,
              backgroundColor: Colors.white,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              onSelected: (_) => model.setStatusFilter(label),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInvoiceCard(BuildContext context, Invoice inv) {
    Color statusColor = Colors.grey;
    Color statusBg = Colors.grey.shade50;
    if (inv.status == InvoiceStatus.paid) {
      statusColor = Colors.green.shade800;
      statusBg = Colors.green.shade50;
    } else if (inv.status == InvoiceStatus.partiallyPaid) {
      statusColor = Colors.orange.shade800;
      statusBg = Colors.orange.shade50;
    } else if (inv.status == InvoiceStatus.unpaid) {
      statusColor = Colors.red.shade800;
      statusBg = Colors.red.shade50;
    }

    final itemsSummary = inv.items.isNotEmpty
        ? inv.items.map((i) => '${i.name} (x${i.quantity.toInt()})').join(', ')
        : 'Invoice #${inv.invoiceNumber}';

    return InkWell(
      onTap: () {
        navigationService.push(InvoiceDetailsView(invoice: inv));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Invoice number & Status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_outlined,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 6),
                    AppText(
                      inv.invoiceNumber,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: AppText(
                    inv.status.label,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Items Summary
            AppText(
              itemsSummary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Date row
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                AppText(
                  'Issued: ${DateFormat('dd MMM yyyy').format(inv.invoiceDate)}',
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 10),
                Icon(Icons.schedule, size: 12, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                AppText(
                  'Due: ${DateFormat('dd MMM yyyy').format(inv.dueDate)}',
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),

            // Financial amounts row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      'Total Billed',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      CurrencyFormatter.formatNaira(inv.total),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppText('Paid', fontSize: 10, color: Colors.grey),
                    const SizedBox(height: 2),
                    AppText(
                      CurrencyFormatter.formatNaira(inv.amountPaid),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const AppText('Balance', fontSize: 10, color: Colors.grey),
                    const SizedBox(height: 2),
                    AppText(
                      CurrencyFormatter.formatNaira(inv.amountRemaining),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: inv.amountRemaining > 0
                          ? Colors.orange.shade800
                          : Colors.green.shade700,
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyInvoicesState(
    BuildContext context,
    CustomerStatementViewModel model,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 36,
                color: Colors.blue.shade400,
              ),
            ),
            const SizedBox(height: 12),
            const AppText(
              'No Invoices Found',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 4),
            AppText(
              model.searchQuery.isNotEmpty ||
                      model.selectedStatusFilter != 'All'
                  ? 'No invoices match the selected filter.'
                  : 'No invoices have been billed to ${customer.name} yet.',
              fontSize: 12,
              color: Colors.grey.shade600,
              alignment: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
