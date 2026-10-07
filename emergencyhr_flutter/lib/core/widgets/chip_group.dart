import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';

typedef ChipItem<T> = ({String label, T value, bool selected});

/// A wrap of selectable pills. Selected: primary fill and a tick. Each
/// target is at least 44 px high.
class ChipGroup<T> extends StatelessWidget {
  const ChipGroup({super.key, required this.items, required this.onSelected});

  final List<ChipItem<T>> items;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Wrap(
      spacing: AppSpacing.x1,
      runSpacing: AppSpacing.x1,
      children: [
        for (final item in items)
          Semantics(
            button: true,
            selected: item.selected,
            label: item.label,
            excludeSemantics: true,
            child: Material(
              color: item.selected ? p.primaryContainer : p.surface,
              shape: StadiumBorder(
                side: BorderSide(
                  color: item.selected ? p.primary : p.inputBorder,
                ),
              ),
              child: InkWell(
                customBorder: const StadiumBorder(),
                onTap: () => onSelected(item.value),
                child: Container(
                  height: AppSizes.tapTarget,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.selected) ...[
                        Icon(Icons.check, size: 16, color: p.primaryText),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        item.label,
                        style: AppTypography.bodySmall.copyWith(
                          fontWeight: item.selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: item.selected ? p.primaryText : p.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
