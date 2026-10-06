import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_loader.dart';
import 'app_text.dart';

enum AppButtonVariant {
  /// Near-black fill. The default action on a screen.
  primary,

  /// Outlined. Secondary actions.
  secondary,

  /// Emergency red. Only for the Emergency flow, Call 112 and critical acts.
  danger,

  /// No fill or border.
  text,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.large = false,
    this.semanticsLabel,
  });

  const AppButton.secondary({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.large = false,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.danger({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
    this.large = false,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.danger;

  const AppButton.text({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = false,
    this.large = false,
    this.semanticsLabel,
  }) : variant = AppButtonVariant.text;

  final String title;

  /// Null disables the button.
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool loading;
  final bool expand;
  final bool large;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final enabled = onPressed != null && !loading;
    final (Color bg, Color fg, BorderSide side) = switch (variant) {
      AppButtonVariant.primary => (
        p.primaryAction,
        p.onPrimaryAction,
        BorderSide.none,
      ),
      AppButtonVariant.secondary => (
        p.surface,
        p.text,
        BorderSide(color: p.border),
      ),
      AppButtonVariant.danger => (p.emergency, p.onEmergency, BorderSide.none),
      AppButtonVariant.text => (
        Colors.transparent,
        p.text,
        BorderSide.none,
      ),
    };
    final disabledFg = p.textTertiary;
    final disabledBg = variant == AppButtonVariant.text
        ? Colors.transparent
        : p.surfaceMuted;

    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(
          expand ? double.infinity : AppSizes.tapTarget,
          large ? AppSizes.buttonLarge : AppSizes.tapTarget,
        ),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: AppSpacing.x2),
      ),
      backgroundColor: WidgetStatePropertyAll(enabled ? bg : disabledBg),
      foregroundColor: WidgetStatePropertyAll(enabled ? fg : disabledFg),
      overlayColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.pressed)
            ? fg.withValues(alpha: 0.12)
            : states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused)
            ? fg.withValues(alpha: 0.08)
            : null,
      ),
      side: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.focused)
            ? BorderSide(color: p.text, width: 2)
            : side,
      ),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.control)),
        ),
      ),
      elevation: const WidgetStatePropertyAll(0),
      tapTargetSize: MaterialTapTargetSize.padded,
    );

    final label = AppText(
      title,
      variant: large ? AppTextVariant.subtitle : AppTextVariant.label,
      color: enabled ? fg : disabledFg,
      alignment: TextAlign.center,
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
              Icon(icon, size: 20, color: enabled ? fg : disabledFg),
            if (loading || icon != null) const SizedBox(width: AppSpacing.x1),
            Flexible(child: label),
          ],
        ),
      ),
    );
  }
}
