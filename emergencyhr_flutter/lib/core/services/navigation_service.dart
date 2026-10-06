import 'package:flutter/material.dart';

class NavigationService<T, U> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?>? pushNamed(String routeName, {Object? args}) async =>
      navigatorKey.currentState?.pushNamed<T>(
        routeName,
        arguments: args,
      );

  Future<T?> push(Widget page, {Object? args}) async =>
      navigatorKey.currentState?.push<T>(MaterialPageRoute(
          builder: (c) => page, settings: RouteSettings(arguments: args)));

  Future pushReplacement(Widget page, {Object? result}) async =>
      navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (c) => page,
          ),
          result: result);

  Future<T?>? pushReplacementNamed(String routeName, {Object? args}) async =>
      navigatorKey.currentState?.pushReplacementNamed<T, U>(
        routeName,
        arguments: args,
      );

  Future<T?>? pushNamedAndRemoveUntil(
    String routeName, {
    Object? args,
    bool keepPreviousPages = false,
  }) async =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
        routeName,
        (Route<dynamic> route) => keepPreviousPages,
        arguments: args,
      );

  Future<T?>? pushAndRemoveUntil(
    Widget page, {
    bool keepPreviousPages = false,
  }) async =>
      navigatorKey.currentState?.pushAndRemoveUntil<T>(
        MaterialPageRoute(builder: (c) => page),
        (Route<dynamic> route) => keepPreviousPages,
      );

  Future<bool?>? maybePop([Object? args]) async =>
      navigatorKey.currentState?.maybePop(args);

  bool? canPop() => navigatorKey.currentState?.canPop();

  void pop([T? result]) => navigatorKey.currentState?.pop<T>(result);
}

// final navigationService = Provider((ref) => NavigationService());
