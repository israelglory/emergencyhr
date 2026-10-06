import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'invoice_preview_viewmodel.dart';

class InvoicePreviewView extends StatelessWidget {
  final Invoice invoice;

  const InvoicePreviewView({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InvoicePreviewViewModel>.reactive(
      viewModelBuilder: () => InvoicePreviewViewModel(invoice),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomAppBar(isBack: true, title: 'Invoice Preview'),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: RepaintBoundary(
                      key: model.previewKey,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: _buildInvoiceContent(),
                      ),
                    ),
                  ),
                ),
                _buildBottomActions(model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInvoiceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(),
        const SizedBox(height: 24),

        // Customer Info
        _buildCustomerInfo(),
        const SizedBox(height: 24),

        // Items Table
        _buildItemsTable(),
        const SizedBox(height: 24),

        // Totals
        _buildTotals(),
        const SizedBox(height: 24),

        // Payment Details
        _buildPaymentInfo(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'INVOICE',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Invoice #: ${invoice.id.substring(0, 8).toUpperCase()}',
                ),
                AppText('Date: ${_formatDate(invoice.invoiceDate)}'),
                AppText('Due Date: ${_formatDate(invoice.dueDate)}'),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            // Company logo/info could go here
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  AppAssets.bglowLogoPng,
                  height: 50,
                  width: 50,
                ),
                AppText(
                  'Bglow creations ent.',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                SizedBox(height: 4),
                AppText(
                  'Office 1: Shop 6, Fasogbon factory,\nAbegunde, Ibadan',
                  maxLines: 2,
                  alignment: TextAlign.end,
                ),
                SizedBox(height: 4),
                AppText(
                  'Office 2: No 26, Surulere Makun, \nSagamu, Ogun state',
                  maxLines: 2,
                  alignment: TextAlign.end,
                ),
                AppText('Phone: +2347067376069'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('Bill To:', fontWeight: FontWeight.bold),
          SizedBox(height: 8),
          AppText(invoice.customerName, fontWeight: FontWeight.w500),
          AppText(invoice.customerAddress),
          AppText(invoice.customerPhone),
        ],
      ),
    );
  }

  Widget _buildItemsTable() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 4,
                child: AppText(
                  'Description',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppText(
                  'Qty',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  alignment: TextAlign.center,
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 3,
                child: AppText(
                  'Rate',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  alignment: TextAlign.right,
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 3,
                child: AppText(
                  'Total',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  alignment: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        // Items
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          child: Column(
            children: invoice.items.map((item) => _buildItemRow(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(InvoiceItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: AppText(
              item.name,
              fontSize: 13,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: AppText(
                '${item.quantity}',
                fontSize: 13,
                alignment: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: AppText(
                CurrencyFormatter.formatNaira(item.price),
                fontSize: 13,
                alignment: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: AppText(
                CurrencyFormatter.formatNaira(item.total),
                fontSize: 13,
                alignment: TextAlign.right,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTaxRate(double rate) {
    return rate % 1 == 0 ? rate.toInt().toString() : rate.toString();
  }

  Widget _buildTotals() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200, maxWidth: 260),
              child: Column(
                children: [
                  _buildTotalRow(
                    'Subtotal:',
                    CurrencyFormatter.formatNaira(invoice.subtotal),
                  ),
                  _buildTotalRow(
                    invoice.taxRate > 0
                        ? 'Tax (${_formatTaxRate(invoice.taxRate)}%):'
                        : 'Tax:',
                    CurrencyFormatter.formatNaira(invoice.tax),
                  ),
                  const Divider(),
                  _buildTotalRow(
                    'Total:',
                    CurrencyFormatter.formatNaira(invoice.total),
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: AppText(
                value,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_balance_outlined,
                size: 18,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 6),
              AppText(
                'Payment Details',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText('Bank:', color: Colors.grey, fontSize: 13),
              AppText(
                appGlobals.user?.bankDetails?.bankName.isNotEmpty == true
                    ? appGlobals.user!.bankDetails!.bankName
                    : 'Moniepoint MFB',
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
                color: Colors.grey,
                fontSize: 13,
              ),
              AppText(
                appGlobals.user?.bankDetails?.accountNumber.isNotEmpty == true
                    ? appGlobals.user!.bankDetails!.accountNumber
                    : '7067376069',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText('Account Name:', color: Colors.grey, fontSize: 13),
              AppText(
                appGlobals.user?.bankDetails?.accountName.isNotEmpty == true
                    ? appGlobals.user!.bankDetails!.accountName
                    : 'Bglow creations ent.',
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(InvoicePreviewViewModel model) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              title: model.isGeneratingPdf ? 'Generating...' : 'Download PDF',
              onPressed: model.isGeneratingPdf ? null : model.generatePdf,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              title: model.isCapturingImage ? 'Capturing...' : 'Save as Image',
              onPressed: model.isCapturingImage ? null : model.captureAsImage,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
