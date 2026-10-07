import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'status_badge.dart';

/// A full-width inline notice in the status label style (padding 8 10,
/// radius 8, 14 / 500), e.g. offline, practice mode or "Not public yet".
class NoticeBanner extends StatelessWidget {
  const NoticeBanner({
    super.key,
    required this.message,
    this.tone = StatusTone.neutral,
    this.icon,
    this.action,
  });

  final String message;
  final StatusTone tone;
  final IconData? icon;

  /// Shown on the right, e.g. a small "Exit" button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (fg, bg) = statusColours(p, tone);
    return Semantics(
      container: true,
      liveRegion: true,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          action == null ? 10 : AppSpacing.small,
          action == null ? AppSpacing.x1 : 6,
          action == null ? 10 : 6,
          action == null ? AppSpacing.x1 : 6,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.status),
        ),
        child: Row(
          crossAxisAlignment: action == null
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(icon, size: 18, color: fg),
              ),
              const SizedBox(width: AppSpacing.x1),
            ],
            Expanded(
              child: Text(
                message,
                style: AppTypography.label.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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
