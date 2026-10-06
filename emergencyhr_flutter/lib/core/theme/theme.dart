import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_palette.dart';

/// Light and dark themes built from the same tokens. Type scale:
/// 32 / 24 / 18 / 16 / 14 / 12, platform system font.
abstract final class AppTheme {
  static final ThemeData lightTheme = _build(
    AppPalette.light,
    Brightness.light,
  );
  static final ThemeData darkTheme = _build(AppPalette.dark, Brightness.dark);

  static TextTheme textTheme(AppPalette p) => TextTheme(
    displaySmall: TextStyle(
      fontSize: 32,
      height: 1.2,
      fontWeight: FontWeight.w700,
      color: p.text,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: p.text,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: p.text,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 1.4,
      fontWeight: FontWeight.w600,
      color: p.text,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.45,
      fontWeight: FontWeight.w400,
      color: p.text,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.45,
      fontWeight: FontWeight.w400,
      color: p.text,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: p.text,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: p.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: p.textSecondary,
    ),
  );

  static ThemeData _build(AppPalette p, Brightness brightness) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: p.primaryAction,
      onPrimary: p.onPrimaryAction,
      secondary: p.textSecondary,
      onSecondary: p.surface,
      error: p.emergencyText,
      onError: p.onEmergency,
      surface: p.surface,
      onSurface: p.text,
      surfaceContainerHighest: p.surfaceMuted,
      outline: p.border,
      outlineVariant: p.divider,
    );
    final text = textTheme(p);
    final controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
    );
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      textTheme: text,
      extensions: [p],
      dividerTheme: DividerThemeData(color: p.divider, thickness: 1, space: 1),
      splashFactory: NoSplash.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      focusColor: p.text.withValues(alpha: 0.12),
      hoverColor: p.text.withValues(alpha: 0.04),
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
        shape: Border(bottom: BorderSide(color: p.divider)),
      ),
      iconTheme: IconThemeData(color: p.text, size: 24),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.x2,
          vertical: 14,
        ),
        hintStyle: text.bodyLarge?.copyWith(color: p.textTertiary),
        errorStyle: text.bodySmall?.copyWith(color: p.emergencyText),
        enabledBorder: border(p.border),
        disabledBorder: border(p.divider),
        focusedBorder: border(p.text, 2),
        errorBorder: border(p.emergencyText),
        focusedErrorBorder: border(p.emergencyText, 2),
        border: border(p.border),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.surface : p.textTertiary,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.positive : p.surfaceMuted,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.positive : p.border,
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: p.background,
        indicatorColor: p.surfaceMuted,
        selectedIconTheme: IconThemeData(color: p.text),
        unselectedIconTheme: IconThemeData(color: p.textSecondary),
        selectedLabelTextStyle: text.labelLarge,
        unselectedLabelTextStyle: text.labelLarge?.copyWith(
          color: p.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.surface,
        indicatorColor: p.surfaceMuted,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(text.labelSmall),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected) ? p.text : p.textSecondary,
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: p.background,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.container),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.container),
        ),
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyLarge,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.text,
        contentTextStyle: text.bodyMedium?.copyWith(color: p.background),
        shape: controlShape,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.text,
        linearTrackColor: p.surfaceMuted,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: p.surface,
        selectedColor: p.surfaceMuted,
        side: BorderSide(color: p.border),
        shape: controlShape,
        labelStyle: text.labelLarge,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: p.textSecondary,
        textColor: p.text,
        minVerticalPadding: AppSpacing.x1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
