import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_text.dart';

/// A labelled select field that looks like [AppTextField].
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
    this.errorText,
  });

  final String label;
  final T? value;
  final List<({T value, String label})> options;
  final ValueChanged<T?> onSelected;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.label(label),
        const SizedBox(height: 6),
        DropdownMenu<T>(
          initialSelection: value,
          expandedInsets: EdgeInsets.zero,
          errorText: errorText,
          textStyle: AppTypography.body.copyWith(color: p.text),
          trailingIcon: Icon(Icons.keyboard_arrow_down, color: p.textSecondary),
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_up,
            color: p.textSecondary,
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(p.surface),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          ),
          onSelected: onSelected,
          dropdownMenuEntries: [
            for (final o in options)
              DropdownMenuEntry(value: o.value, label: o.label),
          ],
        ),
      ],
    );
  }
}
