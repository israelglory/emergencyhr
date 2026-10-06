import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Every piece of text in the app goes through [AppText]. The variant picks a
/// step on the type scale (32 / 24 / 18 / 16 / 14 / 12).
enum AppTextVariant {
  display,
  headline,
  title,
  subtitle,
  body,
  bodySmall,
  label,
  caption,
  captionStrong,
}

/// Semantic text colours, resolved from the current palette.
enum AppTextTone {
  primary,
  secondary,
  tertiary,
  positive,
  warning,
  neutral,
  critical,
  onEmergency,
  onPrimaryAction,
}

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.body,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  });

  const AppText.display(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.display;

  const AppText.headline(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.headline;

  const AppText.title(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.title;

  const AppText.subtitle(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.subtitle;

  const AppText.small(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.bodySmall;

  const AppText.label(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.label;

  const AppText.caption(
    this.text, {
    super.key,
    this.tone = AppTextTone.secondary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = false,
    this.semanticsLabel,
  }) : variant = AppTextVariant.caption;

  final String text;
  final AppTextVariant variant;
  final AppTextTone tone;

  /// Overrides [tone]. Prefer [tone] so dark mode stays correct.
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignment;

  /// Tabular figures so numbers line up in lists.
  final bool numeric;
  final String? semanticsLabel;

  static TextStyle? styleFor(BuildContext context, AppTextVariant variant) {
    final t = Theme.of(context).textTheme;
    return switch (variant) {
      AppTextVariant.display => t.displaySmall,
      AppTextVariant.headline => t.headlineSmall,
      AppTextVariant.title => t.titleLarge,
      AppTextVariant.subtitle => t.titleMedium,
      AppTextVariant.body => t.bodyLarge,
      AppTextVariant.bodySmall => t.bodyMedium,
      AppTextVariant.label => t.labelLarge,
      AppTextVariant.caption => t.bodySmall,
      AppTextVariant.captionStrong => t.labelSmall,
    };
  }

  static Color toneColor(AppPalette p, AppTextTone tone) => switch (tone) {
    AppTextTone.primary => p.text,
    AppTextTone.secondary => p.textSecondary,
    AppTextTone.tertiary => p.textTertiary,
    AppTextTone.positive => p.positive,
    AppTextTone.warning => p.warning,
    AppTextTone.neutral => p.neutral,
    AppTextTone.critical => p.emergencyText,
    AppTextTone.onEmergency => p.onEmergency,
    AppTextTone.onPrimaryAction => p.onPrimaryAction,
  };

  @override
  Widget build(BuildContext context) {
    final style = styleFor(context, variant)?.copyWith(
      color: color ?? toneColor(context.palette, tone),
      fontWeight: fontWeight,
      fontFeatures: numeric ? const [FontFeature.tabularFigures()] : null,
    );
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
