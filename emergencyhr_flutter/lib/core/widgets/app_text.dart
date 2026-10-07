import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/theme.dart';

/// Every piece of text in the app goes through [AppText]. The variant picks a
/// step on the design system type scale.
enum AppTextVariant {
  /// Emergency card title: 28 / 32, 800.
  display,

  /// Page heading (h1): 26 / 32, 700.
  headline,

  /// Home greeting: 24, 800.
  greeting,

  /// Web page title: 24, 700.
  webTitle,

  /// App bar and card titles (h3): 17 / 22, 700.
  title,

  /// Figures such as bed counts: 16, 600.
  value,

  /// Body strong: 15, 600.
  subtitle,

  /// Body: 15 / 22.
  body,

  /// 14, 400.
  bodySmall,

  /// Labels and links: 14, 600.
  label,

  /// Meta: 13 / 18.
  caption,

  /// Badges: 12, 600.
  captionStrong,

  /// Small labels above figures: 12.
  micro,

  /// Caption caps: 12, 700, uppercase.
  caps,
}

/// Semantic text colours, resolved from the current palette.
enum AppTextTone {
  primary,
  strong,
  secondary,
  tertiary,
  link,
  positive,
  warning,
  neutral,
  critical,
  emergency,
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

  const AppText.greeting(
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
  }) : variant = AppTextVariant.greeting;

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

  const AppText.micro(
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
  }) : variant = AppTextVariant.micro;

  const AppText.value(
    this.text, {
    super.key,
    this.tone = AppTextTone.primary,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.numeric = true,
    this.semanticsLabel,
  }) : variant = AppTextVariant.value;

  const AppText.caps(
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
  }) : variant = AppTextVariant.caps;

  final String text;
  final AppTextVariant variant;
  final AppTextTone tone;

  /// Overrides [tone]. Prefer [tone] so dark mode stays correct.
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignment;

  /// Kept for call sites; every style already uses tabular figures.
  final bool numeric;
  final String? semanticsLabel;

  static TextStyle style(AppTextVariant variant) => switch (variant) {
    AppTextVariant.display => AppTypography.emergency,
    AppTextVariant.headline => AppTypography.heading,
    AppTextVariant.greeting => AppTypography.greeting,
    AppTextVariant.webTitle => AppTypography.webTitle,
    AppTextVariant.title => AppTypography.title,
    AppTextVariant.value => AppTypography.value,
    AppTextVariant.subtitle => AppTypography.bodyStrong,
    AppTextVariant.body => AppTypography.body,
    AppTextVariant.bodySmall => AppTypography.bodySmall,
    AppTextVariant.label => AppTypography.label,
    AppTextVariant.caption => AppTypography.meta,
    AppTextVariant.captionStrong => AppTypography.badge,
    AppTextVariant.micro => AppTypography.micro,
    AppTextVariant.caps => AppTypography.caps,
  };

  /// Kept for older call sites.
  static TextStyle? styleFor(BuildContext context, AppTextVariant variant) =>
      style(variant).copyWith(color: context.palette.text);

  static Color toneColor(AppPalette p, AppTextTone tone) => switch (tone) {
    AppTextTone.primary => p.text,
    AppTextTone.strong => p.textStrong,
    AppTextTone.secondary => p.textSecondary,
    AppTextTone.tertiary => p.textTertiary,
    AppTextTone.link => p.primaryText,
    AppTextTone.positive => p.positive,
    AppTextTone.warning => p.warning,
    AppTextTone.neutral => p.neutral,
    AppTextTone.critical => p.critical,
    AppTextTone.emergency => p.emergencyText,
    AppTextTone.onEmergency => p.onEmergency,
    AppTextTone.onPrimaryAction => p.onPrimary,
  };

  @override
  Widget build(BuildContext context) {
    return Text(
      variant == AppTextVariant.caps ? text.toUpperCase() : text,
      style: style(variant).copyWith(
        color: color ?? toneColor(context.palette, tone),
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
