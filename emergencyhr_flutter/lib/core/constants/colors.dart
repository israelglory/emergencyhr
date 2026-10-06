import 'package:flutter/material.dart';

/// Raw colour tokens. Widgets read colours through [AppPalette]
/// (`context.palette`) so light and dark themes follow the same rules.
///
/// Rules: one emergency red, used only for the Emergency button, Call 112 and
/// critical states. Status is always text plus colour, never colour alone.
abstract final class AppColors {
  // Light neutrals
  static const lightBackground = Color(0xFFFAFAF9);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceMuted = Color(0xFFF2F2F0);
  static const lightText = Color(0xFF141414);
  static const lightTextSecondary = Color(0xFF4F4F4F);
  static const lightTextTertiary = Color(0xFF6B6B6B);
  static const lightDivider = Color(0xFFE4E4E2);
  static const lightBorder = Color(0xFFC9C9C6);

  // Dark neutrals
  static const darkBackground = Color(0xFF0E0E0E);
  static const darkSurface = Color(0xFF171717);
  static const darkSurfaceMuted = Color(0xFF212121);
  static const darkText = Color(0xFFF1F1F1);
  static const darkTextSecondary = Color(0xFFB8B8B8);
  static const darkTextTertiary = Color(0xFF959595);
  static const darkDivider = Color(0xFF2A2A2A);
  static const darkBorder = Color(0xFF404040);

  // The one emergency red. White text on it passes WCAG AA.
  static const emergency = Color(0xFFC62828);
  static const onEmergency = Color(0xFFFFFFFF);
  static const emergencyTextDark = Color(0xFFFF7A6E);

  // Status: green = confirmed accepting, amber = stale, grey = unverified or
  // paused.
  static const statusGreenLight = Color(0xFF1E7B34);
  static const statusGreenBgLight = Color(0xFFE6F3E9);
  static const statusAmberLight = Color(0xFF855600);
  static const statusAmberBgLight = Color(0xFFFFF1D1);
  static const statusGreyLight = Color(0xFF555555);
  static const statusGreyBgLight = Color(0xFFECECEA);

  static const statusGreenDark = Color(0xFF74D08A);
  static const statusGreenBgDark = Color(0xFF15301D);
  static const statusAmberDark = Color(0xFFF2BC52);
  static const statusAmberBgDark = Color(0xFF33290F);
  static const statusGreyDark = Color(0xFFB5B5B5);
  static const statusGreyBgDark = Color(0xFF282828);
}
