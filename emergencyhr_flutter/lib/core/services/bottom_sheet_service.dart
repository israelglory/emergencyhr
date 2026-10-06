import 'package:flutter/material.dart';

import 'navigation_service.dart';

/// Opens bottom sheets from viewmodels.
class BottomSheetService {
  BottomSheetService(this._navigation);

  final NavigationService _navigation;

  Future<T?> show<T>(Widget child) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return null;
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: child,
      ),
    );
  }

  void dismiss<T>([T? result]) => _navigation.pop(result);
}
