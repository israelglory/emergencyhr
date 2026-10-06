import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import '../widgets/app_text_field.dart';
import 'navigation_service.dart';

/// Confirmation and information dialogs, opened from viewmodels.
class DialogService {
  DialogService(this._navigation);

  final NavigationService _navigation;

  Future<bool> confirm({
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return false;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: AppText.title(title),
        content: AppText(message),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          AppButton.text(
            title: cancelLabel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          destructive
              ? AppButton.danger(
                  title: confirmLabel,
                  expand: false,
                  onPressed: () => Navigator.of(context).pop(true),
                )
              : AppButton(
                  title: confirmLabel,
                  expand: false,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Asks for a short text, e.g. a reason. Returns null when cancelled.
  Future<String?> promptText({
    required String title,
    required String label,
    String confirmLabel = 'Confirm',
    bool destructive = false,
  }) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return null;
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: AppText.title(title),
        content: SizedBox(
          width: 420,
          child: AppTextField(
            label: label,
            controller: controller,
            maxLines: 3,
            minLines: 2,
            autofocus: true,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          AppButton.text(
            title: 'Cancel',
            onPressed: () => Navigator.of(context).pop(),
          ),
          destructive
              ? AppButton.danger(
                  title: confirmLabel,
                  expand: false,
                  onPressed: () =>
                      Navigator.of(context).pop(controller.text.trim()),
                )
              : AppButton(
                  title: confirmLabel,
                  expand: false,
                  onPressed: () =>
                      Navigator.of(context).pop(controller.text.trim()),
                ),
        ],
      ),
    );
    controller.dispose();
    return result == null || result.isEmpty ? null : result;
  }

  Future<TimeOfDay?> pickTime(TimeOfDay initial) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return null;
    return showTimePicker(context: context, initialTime: initial);
  }

  Future<DateTime?> pickDate(DateTime initial) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return null;
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
  }

  /// Shows any widget as a dialog, e.g. a form.
  Future<T?> show<T>(Widget child) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return null;
    return showDialog<T>(context: context, builder: (_) => child);
  }
}
