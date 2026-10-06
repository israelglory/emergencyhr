import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/local/invoice_service.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:emergencyhr_flutter/presentation/bottom_navigation_view/tabs/report/report_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportOverview extends StatelessWidget {
  const ReportOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Invoice>>(
      future: InvoiceService().getAllInvoices(),
      builder: (context, snapshot) {
        final invoices = snapshot.data ?? [];
        final totalInvoiced = invoices.fold(0.0, (sum, i) => sum + i.total);
        final totalCollected = invoices.fold(
          0.0,
          (sum, i) => sum + i.amountPaid,
        );
        final totalPending = invoices.fold(
          0.0,
          (sum, i) => sum + i.amountRemaining,
        );

        final chartData = _generateChartData(invoices);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mini Summary Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMiniStat(
                    'Invoiced',
                    CurrencyFormatter.formatNaira(totalInvoiced),
                    AppColors.primaryColor,
                  ),
                  _buildMiniStat(
                    'Collected',
                    CurrencyFormatter.formatNaira(totalCollected),
                    Colors.green,
                  ),
                  _buildMiniStat(
                    'Pending',
                    CurrencyFormatter.formatNaira(totalPending),
                    Colors.orange,
                  ),
                ],
              ),
              const Divider(height: 24),

              // Chart
              SizedBox(
                height: 140.0,
                width: double.infinity,
                child: SfCartesianChart(
                  margin: EdgeInsets.zero,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    labelStyle: TextStyle(fontSize: 10),
                  ),
                  primaryYAxis: const NumericAxis(
                    isVisible: false,
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<HomeChartData, String>>[
                    ColumnSeries<HomeChartData, String>(
                      name: 'Invoiced',
                      dataSource: chartData,
                      xValueMapper: (HomeChartData data, _) => data.month,
                      yValueMapper: (HomeChartData data, _) => data.invoiced,
                      color: AppColors.primaryColor.withValues(alpha: 0.8),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(3),
                      ),
                    ),
                    ColumnSeries<HomeChartData, String>(
                      name: 'Collected',
                      dataSource: chartData,
                      xValueMapper: (HomeChartData data, _) => data.month,
                      yValueMapper: (HomeChartData data, _) => data.collected,
                      color: Colors.green,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // View Full Report button
              InkWell(
                onTap: () {
                  navigationService.push(const ReportView(isBack: true));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      'View Detailed Financial Report',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: AppColors.primaryColor,
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

  Widget _buildMiniStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, fontSize: 11, color: Colors.grey.shade600),
        const SizedBox(height: 2),
        AppText(
          value,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ],
    );
  }

  List<HomeChartData> _generateChartData(List<Invoice> invoices) {
    final now = DateTime.now();
    final data = <HomeChartData>[];
    final monthFormat = DateFormat('MMM');

    for (int i = 4; i >= 0; i--) {
      final date = DateTime(now.year, now.month - i, 1);
      final monthName = monthFormat.format(date);

      final monthInvoices = invoices.where(
        (inv) =>
            inv.invoiceDate.year == date.year &&
            inv.invoiceDate.month == date.month,
      );

      final invoiced = monthInvoices.fold(0.0, (sum, inv) => sum + inv.total);
      final collected = monthInvoices.fold(
        0.0,
        (sum, inv) => sum + inv.amountPaid,
      );

      data.add(HomeChartData(monthName, invoiced, collected));
    }
    return data;
  }
}

class HomeChartData {
  final String month;
  final double invoiced;
  final double collected;

  HomeChartData(this.month, this.invoiced, this.collected);
}
