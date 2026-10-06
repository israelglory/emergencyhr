import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// Status colours. Green = confirmed accepting, amber = stale,
/// grey = unverified or paused. [critical] uses the emergency red.
enum StatusTone { positive, warning, neutral, critical }

/// Text plus colour, never colour alone.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.icon,
  });

  final String label;
  final StatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (Color fg, Color bg) = switch (tone) {
      StatusTone.positive => (p.positive, p.positiveBg),
      StatusTone.warning => (p.warning, p.warningBg),
      StatusTone.neutral => (p.neutral, p.neutralBg),
      StatusTone.critical => (p.emergencyText, p.surfaceMuted),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.x1,
        vertical: AppSpacing.half,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: AppSpacing.half),
          ],
          Flexible(
            child: AppText(
              label,
              variant: AppTextVariant.captionStrong,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
