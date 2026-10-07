import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';

enum IconTileTone { primary, critical, positive, warning, neutral }

/// A 40 x 40 rounded tile holding a line icon. [circle] makes it round,
/// e.g. the 52 px icon above an empty or error message.
class IconTile extends StatelessWidget {
  const IconTile(
    this.icon, {
    super.key,
    this.tone = IconTileTone.primary,
    this.size = AppSizes.iconTile,
    this.circle = false,
  });

  final IconData icon;
  final IconTileTone tone;
  final double size;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (Color fg, Color bg) = switch (tone) {
      IconTileTone.primary => (p.primaryText, p.primaryContainer),
      IconTileTone.critical => (p.critical, p.criticalBg),
      IconTileTone.positive => (p.positive, p.positiveBg),
      IconTileTone.warning => (p.warning, p.warningBg),
      IconTileTone.neutral => (p.neutral, p.neutralBg),
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(AppRadius.control),
      ),
      child: Icon(icon, size: size / 2, color: fg),
    );
  }
}
