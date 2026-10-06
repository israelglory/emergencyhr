import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';
import 'status_badge.dart';

/// A full-width inline notice, e.g. offline, disclaimer, or practice mode.
class NoticeBanner extends StatelessWidget {
  const NoticeBanner({
    super.key,
    required this.message,
    this.tone = StatusTone.neutral,
    this.icon = Icons.info_outline,
    this.action,
  });

  final String message;
  final StatusTone tone;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (Color fg, Color bg) = switch (tone) {
      StatusTone.positive => (p.positive, p.positiveBg),
      StatusTone.warning => (p.warning, p.warningBg),
      StatusTone.neutral => (p.text, p.surfaceMuted),
      StatusTone.critical => (p.emergencyText, p.surfaceMuted),
    };
    return Semantics(
      container: true,
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.x2,
          vertical: AppSpacing.x1 + AppSpacing.half,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.control),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: fg),
            const SizedBox(width: AppSpacing.x1 + AppSpacing.half),
            Expanded(child: AppText.small(message, color: fg)),
            if (action != null) ...[
              const SizedBox(width: AppSpacing.x1),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
