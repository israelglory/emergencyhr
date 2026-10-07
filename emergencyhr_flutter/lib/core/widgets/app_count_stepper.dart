import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_text.dart';

/// Minus / value / plus with round 44 px outlined buttons.
class AppCountStepper extends StatelessWidget {
  const AppCountStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.subtitle,
    this.buttonSize = AppSizes.tapTarget,
    this.valueSize = 20,
  });

  final String label;
  final String? subtitle;
  final int value;

  /// Null disables the button (e.g. at the minimum).
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final double buttonSize;
  final double valueSize;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget button(IconData icon, VoidCallback? onTap, String semantics) {
      return Semantics(
        button: true,
        label: semantics,
        child: SizedBox.square(
          dimension: buttonSize,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              side: BorderSide(color: p.inputBorder),
              backgroundColor: p.surface,
              foregroundColor: p.text,
              disabledForegroundColor: p.textTertiary,
            ),
            child: Icon(icon, size: 22),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.subtitle(label),
              if (subtitle != null) AppText.caption(subtitle!),
            ],
          ),
        ),
        button(Icons.remove, onDecrement, 'Decrease $label'),
        const SizedBox(width: AppSpacing.half),
        SizedBox(
          width: 40,
          child: Semantics(
            liveRegion: true,
            label: '$label $value',
            excludeSemantics: true,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: AppTypography.title.copyWith(
                fontSize: valueSize,
                color: p.text,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.half),
        button(Icons.add, onIncrement, 'Increase $label'),
      ],
    );
  }
}
