import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';

/// A container with a 1px border and 12 radius. No shadows, never nested.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.x2),
    this.onTap,
    this.muted = false,
    this.semanticsLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool muted;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.container),
      side: BorderSide(color: p.divider),
    );
    final content = Padding(padding: padding, child: child);
    return Semantics(
      label: semanticsLabel,
      container: true,
      child: Material(
        color: muted ? p.surfaceMuted : p.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: onTap == null
            ? content
            : InkWell(onTap: onTap, customBorder: shape, child: content),
      ),
    );
  }
}
