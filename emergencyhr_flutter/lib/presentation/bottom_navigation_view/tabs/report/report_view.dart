import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:emergencyhr_flutter/presentation/invoice/receipt_preview/receipt_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'report_viewmodel.dart';

class ReportView extends StatelessWidget {
  final bool? isBack;

  const ReportView({super.key, this.isBack});

  @override
  Widget build(BuildContext context) {
    final canPop =
        isBack ??
        (Navigator.of(context).canPop() &&
            ModalRoute.of(context)?.canPop == true);

    return ViewModelBuilder<ReportViewModel>.reactive(
      viewModelBuilder: () => ReportViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        // RBAC: Check financial reports access
        if (!appGlobals.canViewFinancialReports) {
          return Scaffold(
            appBar: canPop
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                : null,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          size: 48,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AppText(
                        'Access Restricted',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      AppText(
                        'Financial reports and revenue analytics are restricted for ${UserRoles.getRoleLabel(appGlobals.user?.role)}. Please contact your administrator.',
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        alignment: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        final report = model.report;

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => model.loadReportData(showLoading: false),
              color: AppColors.buttonColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Bar
                    _buildAppBar(context, model, canPop),
                    const SizedBox(height: 14),

                    // Admin Branch Filter or Staff Attached Branch Tag
                    _buildBranchHeader(model),
                    const SizedBox(height: 12),

                    // Time Filter Chips Row
                    _buildTimeFilterChips(context, model),
                    const SizedBox(height: 18),

                    if (model.isBusy && model.report.totalInvoicesCount == 0)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    else ...[
                      // Highlight KPI Banner: Net Income & Collected Revenue
                      _buildPrimaryHeroCard(report),
                      const SizedBox(height: 14),

                      // Secondary KPI Metrics Grid
                      _buildMetricsGrid(report),
                      const SizedBox(height: 20),

                      // Monthly Revenue & Trend Chart
                      if (report.monthlyChartData.isNotEmpty) ...[
                        _buildMonthlyRevenueChart(report),
                        const SizedBox(height: 20),
                      ],

                      // Status Breakdown (Paid, Partially Paid, Unpaid)
                      _buildStatusBreakdownCard(report),
                      const SizedBox(height: 20),

                      // Payment Method Statistics
                      if (report.paymentMethodStats.isNotEmpty) ...[
                        _buildPaymentMethodsCard(report),
                        const SizedBox(height: 20),
                      ],

                      // Recent Payment Receipts List
                      if (report.recentReceipts.isNotEmpty) ...[
                        _buildRecentReceiptsSection(context, report),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    ReportViewModel model,
    bool canPop,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (canPop) ...[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 4),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Financial Analytics',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                AppText(
                  model.activeFilterLabel,
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.share_outlined,
                color: AppColors.primaryColor,
                size: 20,
              ),
              tooltip: 'Share Report Summary',
              onPressed: model.shareReportSummary,
            ),
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: AppColors.primaryColor,
                size: 22,
              ),
              tooltip: 'Refresh',
              onPressed: () => model.loadReportData(showLoading: true),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBranchHeader(ReportViewModel model) {
    if (appGlobals.isAdmin && model.branches.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.storefront_outlined,
              size: 18,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 10),
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
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: AppText(
                        'All Store Branches (Consolidated)',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ...model.branches.map(
                      (b) => DropdownMenuItem<String?>(
                        value: b.id,
                        child: AppText(
                          '${b.name}${b.isMainBranch ? ' (Main Branch)' : ''}',
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
      );
    } else {
      // Staff branch banner
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.storefront,
              size: 16,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8),
            AppText(
              'Branch: ${model.activeBranchName}',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTimeFilterChips(BuildContext context, ReportViewModel model) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.filterOptions.length,
        itemBuilder: (context, index) {
          final opt = model.filterOptions[index];
          final isSelected = model.selectedFilter == opt['value'];

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: AppText(
                opt['label']!,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryColor,
              backgroundColor: Colors.white,
              checkmarkColor: Colors.white,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              onSelected: (_) async {
                if (opt['value'] == 'CUSTOM') {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                    initialDateRange:
                        model.customStartDate != null &&
                            model.customEndDate != null
                        ? DateTimeRange(
                            start: model.customStartDate!,
                            end: model.customEndDate!,
                          )
                        : DateTimeRange(
                            start: DateTime.now().subtract(
                              const Duration(days: 30),
                            ),
                            end: DateTime.now(),
                          ),
                  );
                  if (picked != null) {
                    model.setCustomDateRange(picked.start, picked.end);
                  }
                } else {
                  model.setFilter(opt['value']!);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrimaryHeroCard(FinancialReport report) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
                'Total Revenue Collected',
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
                child: Row(
                  children: [
                    const Icon(
                      Icons.pie_chart_outline,
                      size: 12,
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      '${report.collectionRate.toStringAsFixed(1)}% Collected',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText(
            CurrencyFormatter.formatNaira(report.totalCollectedAmount),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Total Expenses',
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    CurrencyFormatter.formatNaira(report.totalExpensesAmount),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const AppText(
                    'Net Income',
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    CurrencyFormatter.formatNaira(report.netIncome),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: report.netIncome >= 0
                        ? Colors.greenAccent
                        : Colors.orangeAccent,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(FinancialReport report) {
    return Row(
      children: [
        // Total Invoiced Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      'Total Invoiced',
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 16,
                      color: Colors.blue.shade600,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AppText(
                  CurrencyFormatter.formatNaira(report.totalInvoicedAmount),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                const SizedBox(height: 4),
                AppText(
                  '${report.totalInvoicesCount} invoices issued',
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Outstanding Receivables Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: report.totalOutstandingAmount > 0
                    ? Colors.orange.shade200
                    : Colors.grey.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      'Outstanding',
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.pending_actions_outlined,
                      size: 16,
                      color: Colors.orange.shade700,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AppText(
                  CurrencyFormatter.formatNaira(report.totalOutstandingAmount),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: report.totalOutstandingAmount > 0
                      ? Colors.orange.shade800
                      : Colors.green.shade700,
                ),
                const SizedBox(height: 4),
                AppText(
                  'Pending collection',
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyRevenueChart(FinancialReport report) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'Financial Trends & Cash Flow',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              Icon(Icons.bar_chart, size: 20, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 4),
          AppText(
            'Monthly comparison of invoiced, collected revenue, and operating expenses',
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(fontSize: 11),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
                numberFormat: NumberFormat.compactCurrency(
                  symbol: '₦',
                  decimalDigits: 0,
                ),
                labelStyle: const TextStyle(fontSize: 10),
              ),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: TextStyle(fontSize: 11),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<MonthlyChartData, String>>[
                ColumnSeries<MonthlyChartData, String>(
                  name: 'Invoiced',
                  dataSource: report.monthlyChartData,
                  xValueMapper: (MonthlyChartData d, _) => d.monthName,
                  yValueMapper: (MonthlyChartData d, _) => d.invoiced,
                  color: Colors.blue.shade400,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
                ColumnSeries<MonthlyChartData, String>(
                  name: 'Collected',
                  dataSource: report.monthlyChartData,
                  xValueMapper: (MonthlyChartData d, _) => d.monthName,
                  yValueMapper: (MonthlyChartData d, _) => d.collected,
                  color: Colors.green.shade500,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
                ColumnSeries<MonthlyChartData, String>(
                  name: 'Expenses',
                  dataSource: report.monthlyChartData,
                  xValueMapper: (MonthlyChartData d, _) => d.monthName,
                  yValueMapper: (MonthlyChartData d, _) => d.expenses,
                  color: Colors.red.shade400,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBreakdownCard(FinancialReport report) {
    final sb = report.statusBreakdown;
    final total = report.totalInvoicedAmount > 0
        ? report.totalInvoicedAmount
        : (sb.paid.amount + sb.partiallyPaid.totalAmount + sb.unpaid.amount);

    final paidPct = total > 0 ? (sb.paid.amount / total) * 100 : 0.0;
    final partialPct = total > 0
        ? (sb.partiallyPaid.totalAmount / total) * 100
        : 0.0;
    final unpaidPct = total > 0 ? (sb.unpaid.amount / total) * 100 : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Invoice Status Breakdown',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 12),

          // Multi-color segmented progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  if (paidPct > 0)
                    Expanded(
                      flex: paidPct.round().clamp(1, 100),
                      child: Container(color: Colors.green),
                    ),
                  if (partialPct > 0)
                    Expanded(
                      flex: partialPct.round().clamp(1, 100),
                      child: Container(color: Colors.orange),
                    ),
                  if (unpaidPct > 0)
                    Expanded(
                      flex: unpaidPct.round().clamp(1, 100),
                      child: Container(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3-Column Stats Row
          Row(
            children: [
              // Paid
              Expanded(
                child: _buildBreakdownPill(
                  label: 'Fully Paid',
                  count: sb.paid.count,
                  amount: sb.paid.amount,
                  color: Colors.green,
                  bgColor: Colors.green.shade50,
                ),
              ),
              const SizedBox(width: 8),

              // Partially Paid
              Expanded(
                child: _buildBreakdownPill(
                  label: 'Partially Paid',
                  count: sb.partiallyPaid.count,
                  amount: sb.partiallyPaid.collectedAmount,
                  subtext:
                      'Bal: ${CurrencyFormatter.formatNaira(sb.partiallyPaid.outstandingAmount)}',
                  color: Colors.orange,
                  bgColor: Colors.orange.shade50,
                ),
              ),
              const SizedBox(width: 8),

              // Unpaid
              Expanded(
                child: _buildBreakdownPill(
                  label: 'Unpaid',
                  count: sb.unpaid.count,
                  amount: sb.unpaid.amount,
                  color: Colors.red,
                  bgColor: Colors.red.shade50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownPill({
    required String label,
    required int count,
    required double amount,
    String? subtext,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: AppText(
                  label,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          AppText(
            CurrencyFormatter.formatNaira(amount),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          const SizedBox(height: 2),
          AppText(
            '$count ${count == 1 ? "inv" : "invs"}',
            fontSize: 10,
            color: Colors.grey.shade700,
          ),
          if (subtext != null) ...[
            const SizedBox(height: 2),
            AppText(
              subtext,
              fontSize: 9,
              color: Colors.orange.shade800,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsCard(FinancialReport report) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Payment Methods Distribution',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: report.paymentMethodStats.length,
            separatorBuilder: (_, __) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final stat = report.paymentMethodStats[index];
              final totalCollected = report.totalCollectedAmount > 0
                  ? report.totalCollectedAmount
                  : 1.0;
              final pct = (stat.totalAmount / totalCollected) * 100;

              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      stat.method.toLowerCase().contains('bank')
                          ? Icons.account_balance_outlined
                          : stat.method.toLowerCase().contains('cash')
                          ? Icons.payments_outlined
                          : Icons.credit_card_outlined,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          stat.method,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        AppText(
                          '${stat.count} ${stat.count == 1 ? "transaction" : "transactions"} • ${pct.toStringAsFixed(1)}%',
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                  AppText(
                    CurrencyFormatter.formatNaira(stat.totalAmount),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReceiptsSection(
    BuildContext context,
    FinancialReport report,
  ) {
    return Container(
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
              const AppText(
                'Recent Payment Receipts',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              AppText(
                '${report.recentReceipts.length} recorded',
                fontSize: 12,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: report.recentReceipts.length,
            separatorBuilder: (_, __) => const Divider(height: 14),
            itemBuilder: (context, index) {
              final r = report.recentReceipts[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReceiptPreviewView(receipt: r),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.green.shade50,
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              r.customerName.isNotEmpty
                                  ? r.customerName
                                  : r.receiptNumber,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            AppText(
                              '${r.receiptNumber} • ${DateFormat('dd MMM, HH:mm').format(r.paymentDate)}',
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            CurrencyFormatter.formatNaira(r.amount),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                          AppText(
                            r.paymentMethod,
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
