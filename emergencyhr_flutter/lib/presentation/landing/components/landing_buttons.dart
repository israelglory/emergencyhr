import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// The landing page's large buttons (64 and 60 high) with optional icon,
/// border and shadow.
class LandingButton extends StatelessWidget {
  const LandingButton({
    super.key,
    required this.title,
    required this.background,
    required this.foreground,
    required this.onPressed,
    this.icon,
    this.height = 64,
    this.radius = 16,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w600,
    this.border,
    this.shadow,
    this.horizontalPadding = 24,
  });

  final String title;
  final Color background;
  final Color foreground;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;
  final double radius;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? border;
  final List<BoxShadow>? shadow;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: border == null ? BorderSide.none : BorderSide(color: border!),
    );
    return Semantics(
      button: true,
      enabled: onPressed != null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: shadow,
        ),
        child: Material(
          color: background,
          shape: shape,
          child: InkWell(
            onTap: onPressed,
            customBorder: shape,
            child: Container(
              constraints: BoxConstraints(minHeight: height),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: foreground),
                    const SizedBox(width: AppSpacing.x1),
                  ],
                  Flexible(
                    // Never cut short: on narrow screens the words wrap.
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyStrong.copyWith(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: foreground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A plain text link (header nav and footer). Without [onTap] it is shown
/// as text only, e.g. a placeholder that is not filled in yet.
class LandingLink extends StatelessWidget {
  const LandingLink({
    super.key,
    required this.label,
    required this.onTap,
    required this.style,
  });

  final String label;
  final VoidCallback? onTap;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final text = Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(label, style: style),
    );
    if (onTap == null) return text;
    return Semantics(
      link: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.status),
        child: text,
      ),
    );
  }
}
