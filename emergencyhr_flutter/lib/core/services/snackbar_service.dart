import 'package:flutter/material.dart';

import '../widgets/app_text.dart';

/// Short confirmations and errors. Viewmodels call this; views never show
/// snackbars themselves.
class SnackbarService {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void success({required String message}) => _show(message, Icons.check);

  void error({required String message}) => _show(message, Icons.error_outline);

  void info({required String message}) => _show(message, Icons.info_outline);

  void _show(String message, IconData icon) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Builder(
            builder: (context) {
              final color = Theme.of(
                context,
              ).snackBarTheme.contentTextStyle?.color;
              return Row(
                children: [
                  Icon(icon, size: 20, color: color),
                  const SizedBox(width: 12),
                  Expanded(child: AppText.small(message, color: color)),
                ],
              );
            },
          ),
        ),
      );
  }
}
