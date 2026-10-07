/// 8 pt spacing grid. Screen padding 20, lists 16, section gaps 16 to 22.
abstract final class AppSpacing {
  static const double half = 4;
  static const double x1 = 8;
  static const double x2 = 16;
  static const double x3 = 24;
  static const double x4 = 32;
  static const double x5 = 40;
  static const double x6 = 48;
  static const double x8 = 64;

  /// Gap between controls in a group.
  static const double tight = 10;
  static const double small = 12;

  /// Horizontal padding of a screen body.
  static const double screen = 20;

  /// Horizontal padding of lists.
  static const double list = 16;

  /// Gap between sections of a screen.
  static const double section = 20;
}

/// Radii: 12 controls and inputs, 16 cards, 24 the Emergency card and
/// bottom sheets, full for pills.
abstract final class AppRadius {
  static const double status = 8;
  static const double mediumButton = 10;
  static const double control = 12;
  static const double card = 16;
  static const double sheet = 24;
  static const double pill = 999;

  /// Kept for older call sites: containers are cards.
  static const double container = card;
}

abstract final class AppSizes {
  /// Minimum tap target.
  static const double tapTarget = 44;
  static const double buttonLarge = 52;
  static const double buttonMedium = 44;
  static const double buttonSmall = 36;
  static const double input = 48;
  static const double topBar = 56;
  static const double bottomNav = 80;
  static const double iconTile = 40;

  /// Readable content column on large screens.
  static const double contentMaxWidth = 560;
  static const double wideContentMaxWidth = 1200;
  static const double adminMenuWidth = 248;
}

/// Responsive breakpoints.
abstract final class AppBreakpoints {
  static const double medium = 600;
  static const double expanded = 1024;
}
