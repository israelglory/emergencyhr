import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'receipt_preview_viewmodel.dart';

class ReceiptPreviewView extends StatelessWidget {
  final PaymentReceipt receipt;

  const ReceiptPreviewView({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReceiptPreviewViewModel>.reactive(
      viewModelBuilder: () => ReceiptPreviewViewModel(receipt),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomAppBar(
                    isBack: true,
                    title: 'Receipt Preview',
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: RepaintBoundary(
                      key: model.previewKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: _buildReceiptContent(context),
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

  Widget _buildReceiptContent(BuildContext context) {
    final isFullyPaid = receipt.remainingBalance <= 0.0001;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(),
        const SizedBox(height: 20),

        // Status Badge & Key Numbers
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isFullyPaid ? Colors.green.shade50 : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFullyPaid ? Colors.green.shade200 : Colors.blue.shade200,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Amount Received',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    CurrencyFormatter.formatNaira(receipt.amount),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isFullyPaid
                        ? Colors.green.shade700
                        : AppColors.primaryColor,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isFullyPaid ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  isFullyPaid ? 'FULLY PAID' : 'PART PAYMENT',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Customer Info Card
        _buildCustomerInfo(),
        const SizedBox(height: 20),

        // Payment Breakdown
        _buildBreakdown(),
        const SizedBox(height: 20),

        // Payment Details (Bank Info)
        _buildPaymentDetails(),
        const SizedBox(height: 20),

        // Footer Thank You
        const Center(
          child: AppText(
            'Thank you for your business!',
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                'RECEIPT',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 8),
              AppText(
                'Receipt #: ${receipt.receiptNumber}',
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              const SizedBox(height: 2),
              AppText(
                'Invoice #: ${receipt.invoiceNumber}',
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
              const SizedBox(height: 2),
              AppText(
                'Date: ${_formatDate(receipt.paymentDate)}',
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              AppAssets.bglowLogoPng,
              height: 48,
              width: 48,
            ),
            const SizedBox(height: 4),
            const AppText(
              'Bglow creations ent',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            const SizedBox(height: 2),
            const AppText(
              'Office 1: Shop 6, Fasogbon factory,\nAbegunde, Ibadan',
              fontSize: 11,
              maxLines: 2,
              alignment: TextAlign.end,
            ),
            const SizedBox(height: 2),
            const AppText(
              'Office 2: No 26, Surulere Makun,\nSagamu, Ogun state',
              fontSize: 11,
              maxLines: 2,
              alignment: TextAlign.end,
            ),
            const SizedBox(height: 2),
            const AppText(
              'Phone: +2347067376069',
              fontSize: 11,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Received From:',
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.grey,
          ),
          const SizedBox(height: 6),
          AppText(
            receipt.customerName,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          if (receipt.customerAddress.isNotEmpty) ...[
            const SizedBox(height: 2),
            AppText(receipt.customerAddress, fontSize: 13),
          ],
          if (receipt.customerPhone.isNotEmpty) ...[
            const SizedBox(height: 2),
            AppText(receipt.customerPhone, fontSize: 13),
          ],
        ],
      ),
    );
  }

  Widget _buildBreakdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildRow(
            'Invoice Total',
            CurrencyFormatter.formatNaira(receipt.invoiceTotal),
          ),
          _buildDivider(),
          _buildRow(
            'Previous Amount Paid',
            CurrencyFormatter.formatNaira(receipt.previousAmountPaid),
          ),
          _buildDivider(),
          _buildRow(
            'Amount Paid (This Payment)',
            CurrencyFormatter.formatNaira(receipt.amount),
            isHighlighted: true,
          ),
          _buildDivider(),
          _buildRow('Payment Method', receipt.paymentMethod),
          _buildDivider(),
          _buildRow(
            'Total Amount Paid to Date',
            CurrencyFormatter.formatNaira(receipt.totalAmountPaid),
          ),
          _buildDivider(),
          _buildRow(
            'Remaining Balance',
            CurrencyFormatter.formatNaira(receipt.remainingBalance),
            isTotal: true,
          ),
          if (receipt.note != null && receipt.note!.trim().isNotEmpty) ...[
            _buildDivider(),
            _buildRow('Note / Reference', receipt.note!),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isTotal = false,
  }) {
    return Container(
      color: isHighlighted
          ? Colors.green.shade50
          : isTotal
          ? Colors.grey.shade100
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal || isHighlighted
                ? FontWeight.bold
                : FontWeight.normal,
            color: isHighlighted ? Colors.green.shade800 : Colors.black,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: AppText(
                value,
                fontSize: isTotal ? 15 : 13,
                fontWeight: isTotal || isHighlighted
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: isHighlighted ? Colors.green.shade800 : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey.shade200);
  }

  Widget _buildPaymentDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_outlined,
                size: 16,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 6),
              AppText(
                'Payment Details',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText('Bank:', color: Colors.grey, fontSize: 12),
              AppText(
                appGlobals.user?.bankDetails?.bankName.isNotEmpty == true
                    ? appGlobals.user!.bankDetails!.bankName
                    : 'Moniepoint MFB',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Account Number:',
                color: Colors.grey,
                fontSize: 12,
              ),
              AppText(
                appGlobals.user?.bankDetails?.accountNumber.isNotEmpty == true
                    ? appGlobals.user!.bankDetails!.accountNumber
                    : '7067376069',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText('Account Name:', color: Colors.grey, fontSize: 12),
              AppText(
                appGlobals.user?.bankDetails?.accountName.isNotEmpty == true
                    ? appGlobals.user!.bankDetails!.accountName
                    : 'Bglow creations ent.',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(ReceiptPreviewViewModel model) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, -2),
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
