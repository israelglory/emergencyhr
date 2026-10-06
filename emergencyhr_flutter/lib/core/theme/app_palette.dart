import 'package:flutter/material.dart';

import '../constants/colors.dart';

/// Semantic colours for the current brightness. Read with `context.palette`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.text,
    required this.textSecondary,
    required this.textTertiary,
    required this.divider,
    required this.border,
    required this.emergency,
    required this.onEmergency,
    required this.emergencyText,
    required this.positive,
    required this.positiveBg,
    required this.warning,
    required this.warningBg,
    required this.neutral,
    required this.neutralBg,
    required this.primaryAction,
    required this.onPrimaryAction,
  });

  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color text;
  final Color textSecondary;
  final Color textTertiary;
  final Color divider;
  final Color border;
  final Color emergency;
  final Color onEmergency;

  /// Red for critical text on a neutral surface.
  final Color emergencyText;
  final Color positive;
  final Color positiveBg;
  final Color warning;
  final Color warningBg;
  final Color neutral;
  final Color neutralBg;

  /// Near-black (light) or near-white (dark) fill for primary buttons.
  final Color primaryAction;
  final Color onPrimaryAction;

  static const light = AppPalette(
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    surfaceMuted: AppColors.lightSurfaceMuted,
    text: AppColors.lightText,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    divider: AppColors.lightDivider,
    border: AppColors.lightBorder,
    emergency: AppColors.emergency,
    onEmergency: AppColors.onEmergency,
    emergencyText: AppColors.emergency,
    positive: AppColors.statusGreenLight,
    positiveBg: AppColors.statusGreenBgLight,
    warning: AppColors.statusAmberLight,
    warningBg: AppColors.statusAmberBgLight,
    neutral: AppColors.statusGreyLight,
    neutralBg: AppColors.statusGreyBgLight,
    primaryAction: AppColors.lightText,
    onPrimaryAction: AppColors.lightSurface,
  );

  static const dark = AppPalette(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    surfaceMuted: AppColors.darkSurfaceMuted,
    text: AppColors.darkText,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    divider: AppColors.darkDivider,
    border: AppColors.darkBorder,
    emergency: AppColors.emergency,
    onEmergency: AppColors.onEmergency,
    emergencyText: AppColors.emergencyTextDark,
    positive: AppColors.statusGreenDark,
    positiveBg: AppColors.statusGreenBgDark,
    warning: AppColors.statusAmberDark,
    warningBg: AppColors.statusAmberBgDark,
    neutral: AppColors.statusGreyDark,
    neutralBg: AppColors.statusGreyBgDark,
    primaryAction: AppColors.darkText,
    onPrimaryAction: AppColors.darkBackground,
  );

  @override
  AppPalette copyWith() => this;

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceMuted: l(surfaceMuted, other.surfaceMuted),
      text: l(text, other.text),
      textSecondary: l(textSecondary, other.textSecondary),
      textTertiary: l(textTertiary, other.textTertiary),
      divider: l(divider, other.divider),
      border: l(border, other.border),
      emergency: l(emergency, other.emergency),
      onEmergency: l(onEmergency, other.onEmergency),
      emergencyText: l(emergencyText, other.emergencyText),
      positive: l(positive, other.positive),
      positiveBg: l(positiveBg, other.positiveBg),
      warning: l(warning, other.warning),
      warningBg: l(warningBg, other.warningBg),
      neutral: l(neutral, other.neutral),
      neutralBg: l(neutralBg, other.neutralBg),
      primaryAction: l(primaryAction, other.primaryAction),
      onPrimaryAction: l(onPrimaryAction, other.onPrimaryAction),
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
