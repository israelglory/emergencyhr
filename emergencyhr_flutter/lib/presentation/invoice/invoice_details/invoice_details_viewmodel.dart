import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/invoice_repo.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:emergencyhr_flutter/presentation/invoice/invoice_preview/invoice_preview_view.dart';
import 'package:emergencyhr_flutter/presentation/invoice/receipt_preview/receipt_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class InvoiceDetailsViewModel extends BaseViewModel {
  Invoice _invoice;
  final InvoiceRepo _invoiceRepo;

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  Invoice get invoice => _invoice;

  InvoiceDetailsViewModel(this._invoice, {InvoiceRepo? invoiceRepo})
    : _invoiceRepo = invoiceRepo ?? invoiceRepoLocator;

  static InvoiceRepo get invoiceRepoLocator => invoiceRepo;

  Future<void> refreshInvoice() async {
    try {
      final response = await _invoiceRepo.getInvoiceById(_invoice.id);
      if (response.success && response.data != null) {
        _invoice = response.data!;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error refreshing invoice: $e');
    }
  }

  Future<PaymentReceipt?> recordPayment({
    required double amount,
    required String paymentMethod,
    String? note,
  }) async {
    if (amount <= 0 || amount > _invoice.amountRemaining + 0.01) {
      throw Exception('Invalid payment amount');
    }

    _isProcessing = true;
    notifyListeners();

    try {
      final param = RecordPaymentParam(
        amount: amount,
        paymentDate: DateTime.now(),
        paymentMethod: paymentMethod,
        note: note,
      );

      final response = await _invoiceRepo.recordPayment(
        invoiceId: _invoice.id,
        param: param,
      );

      if (response.success && response.data != null) {
        final receipt = response.data!;

        // Refresh full invoice from repository
        await refreshInvoice();

        snackbarService.success(
          message: 'Payment recorded and receipt generated!',
        );

        // Navigate to Receipt Preview
        await navigationService.push(ReceiptPreviewView(receipt: receipt));

        return receipt;
      } else {
        throw Exception(
          response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to record payment',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Failed to record payment: $e');
      rethrow;
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  Future<void> markAsPaidDialog(BuildContext context) async {
    if (_invoice.amountRemaining <= 0) return;

    String selectedMethod = 'Bank Transfer';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: AppText(
                      'Mark as Fully Paid',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'This will record a final payment for the entire outstanding balance of:',
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Center(
                      child: AppText(
                        CurrencyFormatter.formatNaira(_invoice.amountRemaining),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AppText(
                    'Payment Method:',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedMethod,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Bank Transfer',
                        child: Text('Bank Transfer'),
                      ),
                      DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                      DropdownMenuItem(value: 'POS', child: Text('POS')),
                      DropdownMenuItem(value: 'Card', child: Text('Card')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() {
                          selectedMethod = val;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const AppText('Cancel', color: Colors.grey),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'Confirm & Pay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed == true) {
      await recordPayment(
        amount: _invoice.amountRemaining,
        paymentMethod: selectedMethod,
        note: 'Marked as fully paid',
      );
    }
  }

  void previewInvoice() {
    navigationService.push(InvoicePreviewView(invoice: _invoice));
  }

  void previewReceipt(PaymentReceipt receipt) {
    navigationService.push(ReceiptPreviewView(receipt: receipt));
  }
}
