/// 8-point spacing grid. [half] exists for tight inline gaps only.
abstract final class AppSpacing {
  static const double half = 4;
  static const double x1 = 8;
  static const double x2 = 16;
  static const double x3 = 24;
  static const double x4 = 32;
  static const double x5 = 40;
  static const double x6 = 48;
  static const double x8 = 64;
}

/// Radii: 8 for controls, 12 for containers.
abstract final class AppRadius {
  static const double control = 8;
  static const double container = 12;
}

abstract final class AppSizes {
  /// Minimum tap target.
  static const double tapTarget = 48;
  static const double buttonLarge = 56;
  static const double emergencyButton = 128;

  /// Widest readable content column on large screens.
  static const double contentMaxWidth = 720;
  static const double wideContentMaxWidth = 1200;
}

/// Responsive breakpoints.
abstract final class AppBreakpoints {
  static const double medium = 600;
  static const double expanded = 1024;
}
