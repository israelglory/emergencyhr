import 'package:flutter/material.dart';

/// Raw colour tokens from the approved design (design/DESIGN_HANDOFF.md).
/// Widgets read colours through [AppPalette] (`context.palette`) so light and
/// dark themes follow the same rules.
///
/// Blue for everyday actions, red only for Emergency and Call 112. Status is
/// always words plus colour, never colour alone.
abstract final class AppColors {
  // Light
  static const ink = Color(0xFF101828);
  static const textSecondary = Color(0xFF475467);
  static const textTertiary = Color(0xFF98A2B3);
  static const textStrong = Color(0xFF344054);
  static const background = Color(0xFFF6F7F9);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSubtle = Color(0xFFF9FAFB);
  static const border = Color(0xFFEAECF0);
  static const divider = Color(0xFFF2F4F7);
  static const inputBorder = Color(0xFFD0D5DD);
  static const primary = Color(0xFF1A56DB);
  static const primaryContainer = Color(0xFFEEF4FF);
  static const primarySelected = Color(0xFFF5F8FF);

  /// Border of the highlighted "Our answer" card on the landing page.
  static const primaryBorder = Color(0xFFD1E0FF);
  static const emergency = Color(0xFFD92D20);
  static const emergencyContainer = Color(0xFFFEF3F2);
  static const emergencyBorder = Color(0xFFFECDCA);
  static const emergencyInk = Color(0xFF7A271A);
  static const emergencyBody = Color(0xFF3A1018);
  static const okText = Color(0xFF067647);
  static const okBg = Color(0xFFE7F6EC);
  static const staleText = Color(0xFF93370D);
  static const staleBg = Color(0xFFFEF4E6);
  static const offText = Color(0xFF344054);
  static const offBg = Color(0xFFF2F4F7);
  static const badText = Color(0xFFB42318);
  static const badBg = Color(0xFFFEECEE);
  static const segmentTrack = Color(0xFFEEF2F6);
  static const disabledBg = Color(0xFFEAECF0);
  static const scrim = Color(0x7316181A); // rgba(22,24,26,.45)
  static const cardShadow = Color(0x0D101828); // rgba(16,24,40,.05)
  static const emergencyShadow = Color(0x47D92D20); // rgba(217,45,32,.28)

  // Dark: mirrors every light token.
  static const darkInk = Color(0xFFF5F5F6);
  static const darkTextSecondary = Color(0xFF94969C);
  static const darkTextTertiary = Color(0xFF61646C);
  static const darkTextStrong = Color(0xFFCECFD2);
  static const darkBackground = Color(0xFF0C111D);
  static const darkSurface = Color(0xFF161B26);
  static const darkSurfaceSubtle = Color(0xFF1B212C);
  static const darkBorder = Color(0xFF1F242F);
  static const darkDivider = Color(0xFF1F242F);
  static const darkInputBorder = Color(0xFF333741);
  static const darkPrimaryText = Color(0xFF84ADFF);
  static const darkPrimaryContainer = Color(0xFF102A56);
  static const darkEmergencyText = Color(0xFFF97066);
  static const darkEmergencyContainer = Color(0xFF55160C);
  static const darkEmergencyBorder = Color(0xFF912018);
  static const darkEmergencyInk = Color(0xFFFECDCA);
  static const darkEmergencyBody = Color(0xFFFEE4E2);
  static const darkOkText = Color(0xFF47CD89);
  static const darkOkBg = Color(0xFF053321);
  static const darkStaleText = Color(0xFFFDB022);
  static const darkStaleBg = Color(0xFF4E1D09);
  static const darkOffText = Color(0xFFCECFD2);
  static const darkOffBg = Color(0xFF1F242F);
  static const darkBadText = Color(0xFFFDA29B);
  static const darkBadBg = Color(0xFF55160C);
  static const darkSegmentTrack = Color(0xFF1F242F);
  static const darkDisabledBg = Color(0xFF1F242F);
}
