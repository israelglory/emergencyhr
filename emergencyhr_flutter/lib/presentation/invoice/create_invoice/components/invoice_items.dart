import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';

class InvoiceItemForm extends StatelessWidget {
  final InvoiceItemInput item;
  final int index;
  final VoidCallback? onRemove;
  final String? errorText;

  const InvoiceItemForm({
    super.key,
    required this.item,
    required this.index,
    this.onRemove,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              'Item ${index + 1}',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            if (onRemove != null)
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
              ),
          ],
        ),
        SizedBox(height: 16),
        AppCustomTextField(
          textEditingController: item.nameController,
          hintText: 'Item name',
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: AppCustomTextField(
                textEditingController: item.qtyController,
                textInputType: TextInputType.number,
                hintText: 'Quantity',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AppCustomTextField(
                textEditingController: item.priceController,
                textInputType: TextInputType.number,
                hintText: 'Price',
              ),
            ),
            SizedBox(width: 4),
            Text(CurrencyFormatter.formatNaira(item.total)),
          ],
        ),
        if (errorText != null) ...[
          SizedBox(height: 4),
          Text(
            errorText!,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
