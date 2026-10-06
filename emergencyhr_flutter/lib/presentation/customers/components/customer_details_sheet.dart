import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:emergencyhr_flutter/presentation/customers/customer_statement/customer_statement_view.dart';
import 'package:emergencyhr_flutter/presentation/invoice/create_invoice/create_invoice_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsSheet extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsSheet({super.key, required this.customer});

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
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Customer Details',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 22, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Customer Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 20,
                      color: AppColors.buttonColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppText(
                        customer.name,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (customer.phone.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.phone_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          AppText(customer.phone, fontSize: 14),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.phone,
                              size: 18,
                              color: AppColors.buttonColor,
                            ),
                            onPressed: () => _callPhone(customer.phone),
                            tooltip: 'Call Phone',
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.copy,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                _copy(customer.phone, 'Phone number'),
                            tooltip: 'Copy Phone',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (customer.address.isNotEmpty) ...[
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
                        child: AppText(customer.address, fontSize: 13),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            _copy(customer.address, 'Customer address'),
                        tooltip: 'Copy Address',
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Primary Action: View Invoices & Statement
          AppButton(
            title: 'View Invoices & Statement',
            color: AppColors.primaryColor,
            textColor: Colors.white,
            radius: 10,
            height: 48,
            onPressed: () {
              Navigator.pop(context);
              navigationService.push(CustomerStatementView(customer: customer));
            },
          ),
          const SizedBox(height: 10),

          // Secondary Action: Create Invoice for this customer
          AppButton(
            title: 'Create New Invoice',
            color: Colors.white,
            textColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            borderWidth: 1,
            radius: 10,
            height: 48,
            onPressed: () {
              Navigator.pop(context);
              navigationService.push(
                CreateInvoiceView(
                  prefilledCustomerName: customer.name,
                  prefilledCustomerAddress: customer.address,
                  prefilledCustomerPhone: customer.phone,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
