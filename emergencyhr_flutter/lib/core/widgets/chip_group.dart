import 'package:flutter/material.dart';

import '../constants/dimens.dart';

typedef ChipItem<T> = ({String label, T value, bool selected});

/// A wrap of selectable chips with 48px targets.
class ChipGroup<T> extends StatelessWidget {
  const ChipGroup({super.key, required this.items, required this.onSelected});

  final List<ChipItem<T>> items;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.x1,
      runSpacing: AppSpacing.x1,
      children: [
        for (final item in items)
          FilterChip(
            label: Text(item.label),
            selected: item.selected,
            showCheckmark: true,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onSelected: (_) => onSelected(item.value),
          ),
      ],
    );
  }
}
