import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';

/// Status colours. Positive = confirmed accepting, warning = stale,
/// neutral = paused, unverified = neutral with a hollow dot, critical =
/// under review and errors. Always shown with words.
enum StatusTone { positive, warning, neutral, unverified, critical }

(Color fg, Color bg) statusColours(AppPalette p, StatusTone tone) =>
    switch (tone) {
      StatusTone.positive => (p.positive, p.positiveBg),
      StatusTone.warning => (p.warning, p.warningBg),
      StatusTone.neutral || StatusTone.unverified => (p.neutral, p.neutralBg),
      StatusTone.critical => (p.critical, p.criticalBg),
    };

class _Dot extends StatelessWidget {
  const _Dot({required this.color, required this.hollow});

  final Color color;
  final bool hollow;

  @override
  Widget build(BuildContext context) => Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: hollow ? Colors.transparent : color,
      border: hollow ? Border.all(color: color, width: 1.5) : null,
    ),
  );
}

/// The full-width status line used in hospital rows: dot plus words on a
/// tinted background, 14 / 600.
class StatusLabel extends StatelessWidget {
  const StatusLabel({
    super.key,
    required this.label,
    required this.tone,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    this.background,
  });

  final String label;
  final StatusTone tone;

  /// 14 normally; the landing page uses 16, and 11.5 in the phone mockup.
  final double fontSize;
  final EdgeInsets padding;

  /// Replaces the tinted background, e.g. white on the intro illustration.
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = statusColours(context.palette, tone);
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: background ?? bg,
          borderRadius: BorderRadius.circular(AppRadius.status),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: fontSize * 19 / 14 / 2 - 3.5),
              child: _Dot(color: fg, hollow: tone == StatusTone.unverified),
            ),
            const SizedBox(width: AppSpacing.x1),
            Expanded(
              child: Text(
                label,
                style: AppTypography.label.copyWith(
                  color: fg,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A small pill: 24 high, 12 / 600, optional dot.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.dot = true,
    this.icon,
  });

  final String label;
  final StatusTone tone;
  final bool dot;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = statusColours(context.palette, tone);
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ] else if (dot && tone != StatusTone.unverified) ...[
            _Dot(color: fg, hollow: tone == StatusTone.unverified),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTypography.badge.copyWith(color: fg),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// A blue tag such as a capability: 30 high, 13 / 500.
class AppChip extends StatelessWidget {
  const AppChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: p.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          label,
          style: AppTypography.meta.copyWith(
            color: p.primaryText,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
