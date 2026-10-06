import 'package:flutter/material.dart';
import '../cores.dart';

class BottomSheetService {
  Future<bool?> showSheet({required Widget child}) async {
    return await showModalBottomSheet(
      useSafeArea: true,
      context: navigationService.navigatorKey.currentState!.context,
      builder: (c) => SizedBox(
        child: child,
      ),
    );
  }

  Future<dynamic> show(Widget child, {bool? scrolledControl, Color? color}) {
    return showModalBottomSheet(
      context: navigationService.navigatorKey.currentState!.context,
      isScrollControlled: scrolledControl ?? true,
      isDismissible: true,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        margin: EdgeInsets.only(
          top: MediaQuery.of(
            navigationService.navigatorKey.currentState!.context,
          ).padding.top,
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      ),
    );
  }

  static void dismiss() =>
      Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
}
