import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_loader.dart';

enum AppButtonVariant {
  /// Blue fill. Everyday actions.
  primary,

  /// White with a grey outline.
  secondary,

  /// Light blue fill with blue text, e.g. Sign in on Home.
  tonal,

  /// Emergency red fill. Only for Emergency and Call 112.
  danger,

  /// White with a red outline, e.g. "No answer? Call 112".
  dangerOutline,

  /// Dark red fill for destructive confirmations, e.g. Suspend.
  destructive,

  /// Pale red with dark red text: the small Emergency pill on the intro.
  emergencySoft,

  /// Primary-coloured link text.
  text,
}

/// 56 (extraLarge, alert cards; tall, intro and Welcome), 52 (large), 44
/// (medium) or 36 (small pill) high.
enum AppButtonSize { extraLarge, tall, large, medium, small }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.color,
    this.semanticsLabel,
  });

  const AppButton.secondary({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = AppButtonSize.large,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.color,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.danger({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = AppButtonSize.large,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.color,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.danger;

  const AppButton.dangerOutline({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = AppButtonSize.large,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.color,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.dangerOutline;

  const AppButton.text({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = AppButtonSize.large,
    this.icon,
    this.loading = false,
    this.expand = false,
    this.color,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.text;

  final String title;

  /// Null disables the button.
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool loading;
  final bool expand;

  /// Overrides the text colour of a text button (e.g. grey links).
  final Color? color;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final enabled = onPressed != null && !loading;
    final isText = variant == AppButtonVariant.text;

    final (Color bg, Color fg, Color? outline) = switch (variant) {
      AppButtonVariant.primary => (p.primary, p.onPrimary, null),
      AppButtonVariant.secondary => (p.surface, p.text, p.inputBorder),
      AppButtonVariant.tonal => (p.primaryContainer, p.primaryText, null),
      AppButtonVariant.danger => (p.emergency, p.onEmergency, null),
      AppButtonVariant.destructive => (p.critical, p.onEmergency, null),
      AppButtonVariant.emergencySoft => (
        p.emergencyContainer,
        p.critical,
        null,
      ),
      AppButtonVariant.dangerOutline => (
        p.surface,
        p.emergencyText,
        p.emergencyText,
      ),
      AppButtonVariant.text => (
        Colors.transparent,
        color ?? p.primaryText,
        null,
      ),
    };
    final disabledBg = isText ? Colors.transparent : p.disabledBg;
    final disabledFg = isText ? p.textTertiary : p.textSecondary;
    final currentFg = enabled ? fg : disabledFg;

    final (
      double height,
      double radius,
      double fontSize,
      double padX,
    ) = switch (size) {
      AppButtonSize.extraLarge => (56.0, AppRadius.control, 17.0, 18.0),
      AppButtonSize.tall => (56.0, 14.0, 16.0, 18.0),
      AppButtonSize.large => (
        AppSizes.buttonLarge,
        AppRadius.control,
        15.0,
        18.0,
      ),
      AppButtonSize.medium => (
        AppSizes.buttonMedium,
        AppRadius.mediumButton,
        15.0,
        16.0,
      ),
      AppButtonSize.small => (
        AppSizes.buttonSmall,
        AppSizes.buttonSmall / 2,
        13.0,
        14.0,
      ),
    };

    final textStyle = AppTypography.bodyStrong.copyWith(
      fontWeight: variant == AppButtonVariant.emergencySoft
          ? FontWeight.w700
          : FontWeight.w600,
      fontSize: isText ? 14 : fontSize,
      color: currentFg,
      height: 1.2,
    );

    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(
          expand ? double.infinity : 0,
          isText ? AppSizes.tapTarget : height,
        ),
      ),
      fixedSize: isText
          ? null
          : WidgetStatePropertyAll(Size.fromHeight(height)),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: isText ? 0 : padX),
      ),
      backgroundColor: WidgetStatePropertyAll(enabled ? bg : disabledBg),
      foregroundColor: WidgetStatePropertyAll(currentFg),
      overlayColor: WidgetStateProperty.resolveWith(
        (states) => isText
            ? Colors.transparent
            : states.contains(WidgetState.pressed)
            ? fg.withValues(alpha: 0.12)
            : states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused)
            ? fg.withValues(alpha: 0.08)
            : null,
      ),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: p.primary, width: 2);
        }
        if (outline != null && enabled) return BorderSide(color: outline);
        return BorderSide.none;
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      elevation: const WidgetStatePropertyAll(0),
      tapTargetSize: MaterialTapTargetSize.padded,
      textStyle: WidgetStatePropertyAll(textStyle),
    );

    return Semantics(
      button: true,
      label: semanticsLabel,
      child: TextButton(
        onPressed: enabled ? onPressed : null,
        style: style,
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              AppLoader(size: 18, color: fg)
            else if (icon != null)
              Icon(icon, size: 18, color: currentFg),
            if (loading || icon != null) const SizedBox(width: AppSpacing.x1),
            Flexible(
              child: Text(
                title,
                style: textStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
