import 'package:flutter/material.dart';

/// Navigation from viewmodels through named routes, so every screen has a
/// web URL and deep link (see `AppRoutes`).
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _nav => navigatorKey.currentState;

  Future<T?> pushNamed<T>(String routeName, {Object? args}) async =>
      _nav?.pushNamed<T>(routeName, arguments: args);

  Future<T?> replaceWith<T>(String routeName, {Object? args}) async =>
      _nav?.pushReplacementNamed<T, Object?>(routeName, arguments: args);

  /// Clears the stack and opens [routeName].
  Future<T?> clearStackAndShow<T>(String routeName, {Object? args}) async =>
      _nav?.pushNamedAndRemoveUntil<T>(
        routeName,
        (_) => false,
        arguments: args,
      );

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
