import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'components/part_payment_bottom_sheet.dart';
import 'invoice_details_viewmodel.dart';

class InvoiceDetailsView extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailsView({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InvoiceDetailsViewModel>.reactive(
      viewModelBuilder: () => InvoiceDetailsViewModel(invoice),
      onViewModelReady: (model) => model.refreshInvoice(),
      builder: (context, model, child) {
        final inv = model.invoice;

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomAppBar(
                    isBack: true,
                    title: 'Invoice Details',
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header & Status Card
                        _buildHeaderCard(inv),
                        const SizedBox(height: 16),

                        // Financial Summary Card
                        _buildFinancialSummaryCard(inv),
                        const SizedBox(height: 16),

                        // Action Buttons
                        _buildActionButtons(context, model),
                        const SizedBox(height: 24),

                        // Payment & Receipt History
                        _buildPaymentHistory(context, model),
                        const SizedBox(height: 24),
                      ],
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

  Widget _buildHeaderCard(Invoice inv) {
    final statusColor = inv.status == InvoiceStatus.paid
        ? Colors.green
        : inv.status == InvoiceStatus.partiallyPaid
        ? Colors.orange
        : Colors.red;

    final statusBgColor = inv.status == InvoiceStatus.paid
        ? Colors.green.shade50
        : inv.status == InvoiceStatus.partiallyPaid
        ? Colors.orange.shade50
        : Colors.red.shade50;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    inv.invoiceNumber,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    'Created: ${_formatDate(inv.invoiceDate)}',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    AppText(
                      inv.status.label,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          const AppText(
            'Bill To:',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          const SizedBox(height: 4),
          AppText(inv.customerName, fontWeight: FontWeight.bold, fontSize: 15),
          if (inv.customerPhone.isNotEmpty) ...[
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                AppText(
                  inv.customerPhone,
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
              ],
            ),
          ],
          if (inv.customerAddress.isNotEmpty) ...[
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: AppText(
                    inv.customerAddress,
                    fontSize: 13,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFinancialSummaryCard(Invoice inv) {
    final progress = inv.total > 0
        ? (inv.amountPaid / inv.total).clamp(0.0, 1.0)
        : 0.0;
    final percentPaid = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Payment Summary',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),

          // Total & Paid Rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Total Invoice Amount:',
                fontSize: 13,
                color: Colors.grey,
              ),
              AppText(
                CurrencyFormatter.formatNaira(inv.total),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Total Amount Paid:',
                fontSize: 13,
                color: Colors.grey,
              ),
              AppText(
                CurrencyFormatter.formatNaira(inv.amountPaid),
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ],
          ),
          const Divider(height: 24),

          // Amount Remaining
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Amount Remaining:',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                CurrencyFormatter.formatNaira(inv.amountRemaining),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: inv.amountRemaining <= 0
                    ? Colors.green.shade700
                    : AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                inv.status == InvoiceStatus.paid
                    ? Colors.green
                    : AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: AppText(
              '$percentPaid% Paid',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    InvoiceDetailsViewModel model,
  ) {
    final inv = model.invoice;
    final hasRemaining = inv.amountRemaining > 0;

    return Column(
      children: [
        // Preview Original Invoice Button
        OutlinedButton.icon(
          onPressed: model.previewInvoice,
          icon: const Icon(Icons.visibility_outlined, size: 18),
          label: const Text('Preview Original Invoice'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            foregroundColor: AppColors.primaryColor,
            side: const BorderSide(color: AppColors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        if (hasRemaining) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: '+ Part Payment',
                  onPressed: () => _openPartPaymentSheet(context, model),
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => model.markAsPaidDialog(context),
                  icon: const Icon(Icons.check, size: 18, color: Colors.white),
                  label: const Text(
                    'Mark as Paid',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _openPartPaymentSheet(
    BuildContext context,
    InvoiceDetailsViewModel model,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PartPaymentBottomSheet(
          invoice: model.invoice,
          onSubmit: model.recordPayment,
        );
      },
    );
  }

  Widget _buildPaymentHistory(
    BuildContext context,
    InvoiceDetailsViewModel model,
  ) {
    final payments = model.invoice.payments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const AppText(
                  'Payment History',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppText(
                    '${payments.length}',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (payments.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_outlined,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 10),
                const AppText(
                  'No payments recorded yet',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey,
                ),
                const SizedBox(height: 4),
                AppText(
                  'Use "+ Part Payment" to record customer payments and generate receipts.',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  alignment: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else ...[
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: payments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildPaymentCard(context, payment, model);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentCard(
    BuildContext context,
    PaymentReceipt payment,
    InvoiceDetailsViewModel model,
  ) {
    return GestureDetector(
      onTap: () => model.previewReceipt(payment),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.receipt_long,
                color: Colors.green,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        payment.receiptNumber,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      AppText(
                        '+ ${CurrencyFormatter.formatNaira(payment.amount)}',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.green.shade700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        '${_formatDate(payment.paymentDate)} • ${payment.paymentMethod}',
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      AppText(
                        'Bal: ${CurrencyFormatter.formatNaira(payment.remainingBalance)}',
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
