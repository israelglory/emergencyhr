import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Navigation from viewmodels through named routes, so every screen has a
/// web URL and deep link (see `AppRoutes`).
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _nav => navigatorKey.currentState;

  // Routes are built as Route<dynamic>, so push as Object? and narrow the
  // result; pushing as Route<T> would fail the cast for screens that
  // return a value (e.g. the chosen area).
  Future<T?> pushNamed<T>(String routeName, {Object? args}) async =>
      _narrow<T>(await _nav?.pushNamed<Object?>(routeName, arguments: args));

  Future<T?> replaceWith<T>(String routeName, {Object? args}) async =>
      _narrow<T>(
        await _nav?.pushReplacementNamed<Object?, Object?>(
          routeName,
          arguments: args,
        ),
      );

  /// Clears the stack and opens [routeName].
  Future<T?> clearStackAndShow<T>(String routeName, {Object? args}) async =>
      _narrow<T>(
        await _nav?.pushNamedAndRemoveUntil<Object?>(
          routeName,
          (_) => false,
          arguments: args,
        ),
      );

  static T? _narrow<T>(Object? result) => result is T ? result : null;

  /// Pops back to [routeName] if it is on the stack, otherwise opens it.
  void popUntilOrShow(String routeName) {
    var found = false;
    _nav?.popUntil((route) {
      if (route.settings.name == routeName || route.isFirst) {
        found = route.settings.name == routeName;
        return true;
      }
      return false;
    });
    if (!found) clearStackAndShow<void>(routeName);
  }

  bool canPop() => _nav?.canPop() ?? false;

  /// Changes the address bar on the web without opening a page, e.g. when
  /// switching bottom tabs.
  void updateUrl(String path) => SystemNavigator.routeInformationUpdated(
    uri: Uri.parse(path),
    replace: true,
  );

  void pop<T>([T? result]) => _nav?.pop<T>(result);

  /// Pops when possible, otherwise opens [fallbackRoute] (web deep links).
  void back({required String fallbackRoute}) {
    if (canPop()) {
      pop<void>();
    } else {
      clearStackAndShow<void>(fallbackRoute);
    }
  }
}
