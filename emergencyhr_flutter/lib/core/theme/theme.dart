import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_palette.dart';

/// Plus Jakarta Sans type scale from the design system. Figures use tabular
/// numbers everywhere.
abstract final class AppTypography {
  static const family = 'Plus Jakarta Sans';
  static const _figures = [FontFeature.tabularFigures()];

  static TextStyle _s(
    double size,
    FontWeight weight, {
    double? height,
    double? spacing,
  }) => TextStyle(
    fontFamily: family,
    fontSize: size,
    fontWeight: weight,
    height: height == null ? null : height / size,
    letterSpacing: spacing,
    fontFeatures: _figures,
  );

  /// Emergency card title: 28 / 32, 800.
  static final emergency = _s(28, FontWeight.w800, height: 32);

  /// Page heading (h1): 26 / 32, 700.
  static final heading = _s(26, FontWeight.w700, height: 32, spacing: -0.3);

  /// Home greeting: 24, 800.
  static final greeting = _s(24, FontWeight.w800, height: 30, spacing: -0.3);

  /// Web page title: 24, 700.
  static final webTitle = _s(24, FontWeight.w700, height: 30, spacing: -0.3);

  /// App bar and card titles (h3): 17 / 22, 700.
  static final title = _s(17, FontWeight.w700, height: 22);

  /// Figures such as bed counts: 16, 600.
  static final value = _s(16, FontWeight.w600, height: 22);

  /// Body strong: 15, 600.
  static final bodyStrong = _s(15, FontWeight.w600, height: 22);

  /// Body: 15 / 22, 400.
  static final body = _s(15, FontWeight.w400, height: 22);

  /// Field labels, links, status labels: 14, 600.
  static final label = _s(14, FontWeight.w600, height: 19);

  /// Small body: 14, 400.
  static final bodySmall = _s(14, FontWeight.w400, height: 20);

  /// Meta: 13 / 18, 400.
  static final meta = _s(13, FontWeight.w400, height: 18);

  /// Badges: 12, 600.
  static final badge = _s(12, FontWeight.w600, height: 16);

  /// Small labels above figures: 12, 400.
  static final micro = _s(12, FontWeight.w400, height: 16);

  /// Caption caps: 12, 700, letter spacing 0.6, uppercase (apply upper case
  /// to the text).
  static final caps = _s(12, FontWeight.w700, height: 16, spacing: 0.6);
}

/// Light and dark themes built from the same tokens.
abstract final class AppTheme {
  static final ThemeData lightTheme = _build(
    AppPalette.light,
    Brightness.light,
  );
  static final ThemeData darkTheme = _build(AppPalette.dark, Brightness.dark);

  static TextTheme textTheme(AppPalette p) => TextTheme(
    displaySmall: AppTypography.emergency.copyWith(color: p.text),
    headlineMedium: AppTypography.greeting.copyWith(color: p.text),
    headlineSmall: AppTypography.heading.copyWith(color: p.text),
    titleLarge: AppTypography.title.copyWith(color: p.text),
    titleMedium: AppTypography.bodyStrong.copyWith(color: p.text),
    bodyLarge: AppTypography.body.copyWith(color: p.text),
    bodyMedium: AppTypography.bodySmall.copyWith(color: p.text),
    bodySmall: AppTypography.meta.copyWith(color: p.textSecondary),
    labelLarge: AppTypography.label.copyWith(color: p.text),
    labelMedium: AppTypography.caps.copyWith(color: p.textSecondary),
    labelSmall: AppTypography.badge.copyWith(color: p.textSecondary),
  );

  static ThemeData _build(AppPalette p, Brightness brightness) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      primaryContainer: p.primaryContainer,
      onPrimaryContainer: p.primaryText,
      secondary: p.textSecondary,
      onSecondary: p.surface,
      error: p.critical,
      onError: p.onEmergency,
      surface: p.surface,
      onSurface: p.text,
      onSurfaceVariant: p.textSecondary,
      surfaceContainerHighest: p.divider,
      outline: p.inputBorder,
      outlineVariant: p.border,
    );
    final text = textTheme(p);
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTypography.family,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      textTheme: text,
      extensions: [p],
      dividerTheme: DividerThemeData(color: p.border, thickness: 1, space: 1),
      splashFactory: InkSparkle.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      focusColor: p.primary.withValues(alpha: 0.12),
      hoverColor: p.text.withValues(alpha: 0.04),
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: AppSizes.topBar,
        titleSpacing: 4,
        titleTextStyle: text.titleLarge,
        iconTheme: IconThemeData(color: p.text, size: 24),
      ),
      iconTheme: IconThemeData(color: p.text, size: 22),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(AppSizes.tapTarget, AppSizes.tapTarget),
          foregroundColor: p.text,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        hintStyle: text.bodyLarge?.copyWith(color: p.textTertiary),
        helperStyle: text.bodySmall,
        errorStyle: text.bodySmall?.copyWith(color: p.critical),
        enabledBorder: border(p.inputBorder),
        disabledBorder: border(p.border),
        focusedBorder: border(p.primary, 1.5),
        errorBorder: border(p.critical),
        focusedErrorBorder: border(p.critical, 1.5),
        border: border(p.inputBorder),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.primary : p.inputBorder,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        thumbIcon: const WidgetStatePropertyAll(null),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.primary : p.surface,
        ),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        side: BorderSide(color: p.inputBorder, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.primary : p.inputBorder,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.surface,
        indicatorColor: p.primaryContainer,
        indicatorShape: const StadiumBorder(),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: AppSizes.bottomNav,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppTypography.micro.copyWith(
                  color: p.primaryText,
                  fontWeight: FontWeight.w700,
                )
              : AppTypography.micro.copyWith(
                  color: p.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            size: 22,
            color: s.contains(WidgetState.selected)
                ? p.primaryText
                : p.textSecondary,
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        modalBarrierColor: p.scrim,
        showDragHandle: true,
        dragHandleColor: p.inputBorder,
        dragHandleSize: const Size(40, 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        barrierColor: p.scrim,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyLarge?.copyWith(color: p.textSecondary),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.text,
        contentTextStyle: text.bodyMedium?.copyWith(color: p.background),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.primary,
        linearTrackColor: p.border,
        circularTrackColor: p.border,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: p.surface,
        selectedColor: p.primaryContainer,
        side: BorderSide(color: p.inputBorder),
        shape: const StadiumBorder(),
        labelStyle: text.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        checkmarkColor: p.primaryText,
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
