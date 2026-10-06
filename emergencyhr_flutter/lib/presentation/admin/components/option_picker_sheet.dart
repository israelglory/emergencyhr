import 'package:flutter/material.dart';

import '../../../core/cores.dart';

typedef PickerOption<T> = ({String label, String? detail, T value});

/// A simple list to choose one option from.
class OptionPickerSheet<T> extends StatelessWidget {
  const OptionPickerSheet({
    super.key,
    required this.title,
    required this.options,
    required this.onPick,
  });

  final String title;
  final List<PickerOption<T>> options;
  final ValueChanged<T> onPick;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.x3,
        0,
        AppSpacing.x3,
        AppSpacing.x3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText.title(title),
          const SizedBox(height: AppSpacing.x2),
          for (final o in options) ...[
            ChoiceTile(
              title: o.label,
              subtitle: o.detail,
              onTap: () => onPick(o.value),
            ),
            const SizedBox(height: AppSpacing.x1),
          ],
        ],
      ),
    );
  }
}
