import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';
import 'status_badge.dart';

/// One large two-way choice, e.g. Accepting / Paused. 64px tall, the selected
/// side is filled with its status colour and always labelled.
class SegmentedToggle extends StatelessWidget {
  const SegmentedToggle({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftSelected,
    required this.onChanged,
    this.leftTone = StatusTone.positive,
    this.rightTone = StatusTone.neutral,
    this.leftIcon,
    this.rightIcon,
  });

  final String leftLabel;
  final String rightLabel;
  final bool leftSelected;

  /// Called with true when the left side is chosen.
  final ValueChanged<bool>? onChanged;
  final StatusTone leftTone;
  final StatusTone rightTone;
  final IconData? leftIcon;
  final IconData? rightIcon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    (Color, Color) colours(StatusTone tone) => switch (tone) {
      StatusTone.positive => (p.positive, p.positiveBg),
      StatusTone.warning => (p.warning, p.warningBg),
      StatusTone.neutral => (p.text, p.neutralBg),
      StatusTone.critical => (p.emergencyText, p.surfaceMuted),
    };

    Widget side({
      required String label,
      required bool selected,
      required StatusTone tone,
      required IconData? icon,
      required bool value,
    }) {
      final (fg, bg) = colours(tone);
      return Expanded(
        child: Semantics(
          button: true,
          selected: selected,
          label: label,
          excludeSemantics: true,
          child: Material(
            color: selected ? bg : p.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.control),
              side: BorderSide(
                color: selected ? fg : p.border,
                width: selected ? 2 : 1,
              ),
            ),
            child: InkWell(
              onTap: onChanged == null ? null : () => onChanged!(value),
              borderRadius: BorderRadius.circular(AppRadius.control),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 64),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.x1),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: selected ? fg : p.textSecondary),
                          const SizedBox(width: AppSpacing.x1),
                        ],
                        Flexible(
                          child: AppText.subtitle(
                            label,
                            color: selected ? fg : p.textSecondary,
                            alignment: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        side(
          label: leftLabel,
          selected: leftSelected,
          tone: leftTone,
          icon: leftIcon,
          value: true,
        ),
        const SizedBox(width: AppSpacing.x1),
        side(
          label: rightLabel,
          selected: !leftSelected,
          tone: rightTone,
          icon: rightIcon,
          value: false,
        ),
      ],
    );
  }
}
