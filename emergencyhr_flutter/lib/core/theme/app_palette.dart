import 'package:flutter/material.dart';

import '../constants/colors.dart';

/// Semantic colours for the current brightness. Read with `context.palette`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.surfaceMuted,
    required this.text,
    required this.textStrong,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.divider,
    required this.inputBorder,
    required this.primary,
    required this.onPrimary,
    required this.primaryText,
    required this.primaryContainer,
    required this.primarySelected,
    required this.emergency,
    required this.onEmergency,
    required this.emergencyText,
    required this.emergencyContainer,
    required this.emergencyBorder,
    required this.emergencyInk,
    required this.emergencyBody,
    required this.positive,
    required this.positiveBg,
    required this.warning,
    required this.warningBg,
    required this.neutral,
    required this.neutralBg,
    required this.critical,
    required this.criticalBg,
    required this.segmentTrack,
    required this.disabledBg,
    required this.cardShadow,
    required this.emergencyShadow,
    required this.scrim,
  });

  /// Screen background.
  final Color background;

  /// Cards, sheets, app bars.
  final Color surface;

  /// Table headers and subtle fills.
  final Color surfaceSubtle;

  /// Quiet fills, e.g. chat bubbles and skeleton bars.
  final Color surfaceMuted;

  /// Main text (ink).
  final Color text;

  /// Slightly softer than ink: unselected menu items, grey status text.
  final Color textStrong;
  final Color textSecondary;

  /// Chevrons and disabled icons.
  final Color textTertiary;

  /// Card borders and dividers.
  final Color border;

  /// Row dividers inside cards.
  final Color divider;

  /// Text fields and outlined buttons.
  final Color inputBorder;

  /// Everyday buttons, selected tabs, checkboxes.
  final Color primary;
  final Color onPrimary;

  /// Links and primary-coloured text (lighter in dark mode).
  final Color primaryText;

  /// Icon tiles, chips, selected nav pill.
  final Color primaryContainer;

  /// Fill of a selected option card.
  final Color primarySelected;

  /// Emergency button and Call 112 only.
  final Color emergency;
  final Color onEmergency;

  /// Red text and outlines on a neutral surface.
  final Color emergencyText;

  /// Red-flag and warning cards.
  final Color emergencyContainer;

  /// Border and text of the red alert card ("No hospital ... accepting").
  final Color emergencyBorder;
  final Color emergencyInk;

  /// Body text of a titled red-flag card.
  final Color emergencyBody;

  /// "Accepting. Confirmed X min ago."
  final Color positive;
  final Color positiveBg;

  /// "Last confirmed X min ago. Call ahead."
  final Color warning;
  final Color warningBg;

  /// Unverified, Paused.
  final Color neutral;
  final Color neutralBg;

  /// Under review, errors.
  final Color critical;
  final Color criticalBg;

  /// Track of the Accepting / Paused segmented control.
  final Color segmentTrack;
  final Color disabledBg;
  final Color cardShadow;
  final Color emergencyShadow;

  /// Behind sheets and dialogs.
  final Color scrim;

  /// Kept for existing call sites: the primary button fill.
  Color get primaryAction => primary;
  Color get onPrimaryAction => onPrimary;

  static const light = AppPalette(
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceSubtle: AppColors.surfaceSubtle,
    surfaceMuted: AppColors.divider,
    text: AppColors.ink,
    textStrong: AppColors.textStrong,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    border: AppColors.border,
    divider: AppColors.divider,
    inputBorder: AppColors.inputBorder,
    primary: AppColors.primary,
    onPrimary: AppColors.surface,
    primaryText: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    primarySelected: AppColors.primarySelected,
    emergency: AppColors.emergency,
    onEmergency: AppColors.surface,
    emergencyText: AppColors.emergency,
    emergencyContainer: AppColors.emergencyContainer,
    emergencyBorder: AppColors.emergencyBorder,
    emergencyInk: AppColors.emergencyInk,
    emergencyBody: AppColors.emergencyBody,
    positive: AppColors.okText,
    positiveBg: AppColors.okBg,
    warning: AppColors.staleText,
    warningBg: AppColors.staleBg,
    neutral: AppColors.offText,
    neutralBg: AppColors.offBg,
    critical: AppColors.badText,
    criticalBg: AppColors.badBg,
    segmentTrack: AppColors.segmentTrack,
    disabledBg: AppColors.disabledBg,
    cardShadow: AppColors.cardShadow,
    emergencyShadow: AppColors.emergencyShadow,
    scrim: AppColors.scrim,
  );

  static const dark = AppPalette(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    surfaceSubtle: AppColors.darkSurfaceSubtle,
    surfaceMuted: AppColors.darkDivider,
    text: AppColors.darkInk,
    textStrong: AppColors.darkTextStrong,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    border: AppColors.darkBorder,
    divider: AppColors.darkDivider,
    inputBorder: AppColors.darkInputBorder,
    primary: AppColors.primary,
    onPrimary: AppColors.surface,
    primaryText: AppColors.darkPrimaryText,
    primaryContainer: AppColors.darkPrimaryContainer,
    primarySelected: AppColors.darkPrimaryContainer,
    emergency: AppColors.emergency,
    onEmergency: AppColors.surface,
    emergencyText: AppColors.darkEmergencyText,
    emergencyContainer: AppColors.darkEmergencyContainer,
    emergencyBorder: AppColors.darkEmergencyBorder,
    emergencyInk: AppColors.darkEmergencyInk,
    emergencyBody: AppColors.darkEmergencyBody,
    positive: AppColors.darkOkText,
    positiveBg: AppColors.darkOkBg,
    warning: AppColors.darkStaleText,
    warningBg: AppColors.darkStaleBg,
    neutral: AppColors.darkOffText,
    neutralBg: AppColors.darkOffBg,
    critical: AppColors.darkBadText,
    criticalBg: AppColors.darkBadBg,
    segmentTrack: AppColors.darkSegmentTrack,
    disabledBg: AppColors.darkDisabledBg,
    cardShadow: Color(0x33000000),
    emergencyShadow: Color(0x47D92D20),
    scrim: Color(0x99000000),
  );

  /// Card shadow: 0 1px 2px.
  List<BoxShadow> get cardShadows => [
    BoxShadow(color: cardShadow, offset: const Offset(0, 1), blurRadius: 2),
  ];

  /// Emergency card shadow: 0 8px 20px.
  List<BoxShadow> get emergencyShadows => [
    BoxShadow(
      color: emergencyShadow,
      offset: const Offset(0, 8),
      blurRadius: 20,
    ),
  ];

  @override
  AppPalette copyWith() => this;

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceSubtle: l(surfaceSubtle, other.surfaceSubtle),
      surfaceMuted: l(surfaceMuted, other.surfaceMuted),
      text: l(text, other.text),
      textStrong: l(textStrong, other.textStrong),
      textSecondary: l(textSecondary, other.textSecondary),
      textTertiary: l(textTertiary, other.textTertiary),
      border: l(border, other.border),
      divider: l(divider, other.divider),
      inputBorder: l(inputBorder, other.inputBorder),
      primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary),
      primaryText: l(primaryText, other.primaryText),
      primaryContainer: l(primaryContainer, other.primaryContainer),
      primarySelected: l(primarySelected, other.primarySelected),
      emergency: l(emergency, other.emergency),
      onEmergency: l(onEmergency, other.onEmergency),
      emergencyText: l(emergencyText, other.emergencyText),
      emergencyContainer: l(emergencyContainer, other.emergencyContainer),
      emergencyBorder: l(emergencyBorder, other.emergencyBorder),
      emergencyInk: l(emergencyInk, other.emergencyInk),
      emergencyBody: l(emergencyBody, other.emergencyBody),
      positive: l(positive, other.positive),
      positiveBg: l(positiveBg, other.positiveBg),
      warning: l(warning, other.warning),
      warningBg: l(warningBg, other.warningBg),
      neutral: l(neutral, other.neutral),
      neutralBg: l(neutralBg, other.neutralBg),
      critical: l(critical, other.critical),
      criticalBg: l(criticalBg, other.criticalBg),
      segmentTrack: l(segmentTrack, other.segmentTrack),
      disabledBg: l(disabledBg, other.disabledBg),
      cardShadow: l(cardShadow, other.cardShadow),
      emergencyShadow: l(emergencyShadow, other.emergencyShadow),
      scrim: l(scrim, other.scrim),
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
