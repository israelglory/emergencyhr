import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';

/// White card with a 1px border, 16 radius and a soft shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.x2),
    this.onTap,
    this.muted = false,
    this.color,
    this.borderColor,
    this.semanticsLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  /// Kept for older call sites: a light grey card.
  final bool muted;
  final Color? color;
  final Color? borderColor;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final radius = BorderRadius.circular(AppRadius.card);
    final content = Padding(padding: padding, child: child);
    return Semantics(
      label: semanticsLabel,
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: p.cardShadows,
        ),
        child: Material(
          color: color ?? (muted ? p.surfaceSubtle : p.surface),
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: borderColor ?? p.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: onTap == null
              ? content
              : InkWell(onTap: onTap, child: content),
        ),
      ),
    );
  }
}
