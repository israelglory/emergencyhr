import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_text.dart';

/// A full-width row with a label and a switch. The whole row is the target.
class AppSwitchTile extends StatelessWidget {
  const AppSwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.description,
    this.valueLabel,
  });

  final String label;
  final String? description;

  /// Text that states the current value, e.g. "Yes" or "No".
  final String? valueLabel;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: InkWell(
        onTap: onChanged == null ? null : () => onChanged!(!value),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.x1),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(label),
                      if (description != null) AppText.caption(description!),
                    ],
                  ),
                ),
                if (valueLabel != null) ...[
                  AppText.label(valueLabel!, tone: AppTextTone.secondary),
                  const SizedBox(width: AppSpacing.tight),
                ],
                Switch(value: value, onChanged: onChanged),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
