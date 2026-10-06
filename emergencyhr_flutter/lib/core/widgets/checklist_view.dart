import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

typedef ChecklistLine = ({String label, bool done});

/// A read-only checklist with done / to-do marks, text plus icon.
class ChecklistView extends StatelessWidget {
  const ChecklistView({super.key, required this.items});

  final List<ChecklistLine> items;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.half),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  item.done
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked,
                  size: 20,
                  color: item.done ? p.positive : p.textTertiary,
                  semanticLabel: item.done ? 'Done' : 'To do',
                ),
                const SizedBox(width: AppSpacing.x1),
                Expanded(
                  child: AppText.small(
                    item.label,
                    tone: item.done
                        ? AppTextTone.primary
                        : AppTextTone.secondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
