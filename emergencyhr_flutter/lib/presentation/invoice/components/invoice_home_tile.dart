import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/cores.dart';

class InvoiceHomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? amount;
  final InvoiceStatus? status;
  final String? remainingAmount;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback? onTap;
  final int index;

  const InvoiceHomeTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.amount,
    this.status,
    this.remainingAmount,
    required this.onDelete,
    required this.onEdit,
    this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              onEdit();
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        isThreeLine: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            AppAssets.invoiceIcon,
            height: 22,
            width: 22,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText(
                    title,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (amount != null)
                  AppText(
                    amount!,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(subtitle, color: Colors.grey, fontSize: 12),
                if (status != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: status == InvoiceStatus.paid
                          ? Colors.green.shade50
                          : status == InvoiceStatus.partiallyPaid
                          ? Colors.orange.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: status == InvoiceStatus.paid
                            ? Colors.green.shade200
                            : status == InvoiceStatus.partiallyPaid
                            ? Colors.orange.shade200
                            : Colors.red.shade200,
                      ),
                    ),
                    child: AppText(
                      status!.label,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: status == InvoiceStatus.paid
                          ? Colors.green.shade700
                          : status == InvoiceStatus.partiallyPaid
                          ? Colors.orange.shade800
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
