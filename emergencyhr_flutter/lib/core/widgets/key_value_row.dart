import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_text.dart';

/// A label on the left and a value on the right, numbers aligned.
class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueTone = AppTextTone.primary,
  });

  final String label;
  final String value;
  final AppTextTone valueTone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.half),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: AppText(label, tone: AppTextTone.secondary)),
          const SizedBox(width: AppSpacing.x2),
          Flexible(
            child: AppText(
              value,
              tone: valueTone,
              numeric: true,
              alignment: TextAlign.end,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
