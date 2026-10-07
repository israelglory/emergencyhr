import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import 'app_button.dart';
import 'app_sheet.dart';
import 'app_text.dart';
import 'list_rows.dart';

typedef PickerOption<T> = ({String label, String? detail, T value});

/// A bottom sheet to choose one option, e.g. "Pick an agent".
class OptionPickerSheet<T> extends StatelessWidget {
  const OptionPickerSheet({
    super.key,
    required this.title,
    required this.options,
    required this.onPick,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<PickerOption<T>> options;
  final ValueChanged<T> onPick;

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: title,
      children: [
        if (subtitle != null) AppText.caption(subtitle!),
        AppListCard(
          children: [
            for (final o in options)
              AppListRow(
                title: o.label,
                subtitle: o.detail,
                showChevron: false,
                onTap: () => onPick(o.value),
              ),
          ],
        ),
        AppButton.text(
          title: 'Cancel',
          color: context.palette.text,
          expand: true,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ],
    );
  }
}
