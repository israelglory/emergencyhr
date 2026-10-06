import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// Minus / value / plus control with 48px targets, usable one-handed.
class AppCountStepper extends StatelessWidget {
  const AppCountStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String label;
  final int value;

  /// Null disables the button (e.g. at the minimum).
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget button(IconData icon, VoidCallback? onTap, String semantics) {
      return Semantics(
        button: true,
        label: semantics,
        child: SizedBox.square(
          dimension: AppSizes.buttonLarge,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              side: BorderSide(color: p.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
              foregroundColor: p.text,
            ),
            child: Icon(icon, size: 28),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(child: AppText.subtitle(label)),
        button(Icons.remove, onDecrement, 'Decrease $label'),
        SizedBox(
          width: 72,
          child: Semantics(
            liveRegion: true,
            label: '$label $value',
            excludeSemantics: true,
            child: AppText.headline(
              '$value',
              numeric: true,
              alignment: TextAlign.center,
            ),
          ),
        ),
        button(Icons.add, onIncrement, 'Increase $label'),
      ],
    );
  }
}
