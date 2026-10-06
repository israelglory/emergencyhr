import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;
  final int? index;

  const ExpenseTile({
    super.key,
    required this.expense,
    this.onDelete,
    this.onEdit,
    this.onTap,
    this.index,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'materials':
        return Icons.shopping_bag_outlined;
      case 'equipment':
        return Icons.build_outlined;
      case 'utilities':
        return Icons.bolt_outlined;
      case 'logistics':
        return Icons.local_shipping_outlined;
      case 'rent':
        return Icons.home_work_outlined;
      case 'office supplies':
        return Icons.inventory_2_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'materials':
        return Colors.blue;
      case 'equipment':
        return Colors.purple;
      case 'utilities':
        return Colors.amber.shade800;
      case 'logistics':
        return Colors.teal;
      case 'rent':
        return Colors.indigo;
      case 'office supplies':
        return Colors.deepOrange;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final catColor = _getCategoryColor(expense.category);

    final tileContent = Container(
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
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: catColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getCategoryIcon(expense.category),
              color: catColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),

          // Title & details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  expense.title,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: catColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: AppText(
                        expense.category,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: catColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppText(
                      DateFormat('dd MMM yyyy').format(expense.date),
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                if (expense.note != null && expense.note!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  AppText(
                    expense.note!,
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Amount
          AppText(
            '- ${CurrencyFormatter.formatNaira(expense.amount)}',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.red.shade700,
          ),
        ],
      ),
    );

    if (onDelete != null || onEdit != null) {
      return Slidable(
        key: ValueKey(expense.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            if (onDelete != null)
              SlidableAction(
                onPressed: (_) => onDelete!(),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            if (onEdit != null)
              SlidableAction(
                onPressed: (_) => onEdit!(),
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
          ],
        ),
        child: InkWell(
          onTap: onTap ?? onEdit,
          borderRadius: BorderRadius.circular(12),
          child: tileContent,
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: tileContent,
    );
  }
}
