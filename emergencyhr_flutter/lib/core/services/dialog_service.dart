import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import '../widgets/app_text_field.dart';
import '../theme/app_palette.dart';
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
      builder: (context) => AppDialog(
        title: title,
        message: message,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        destructive: destructive,
        onConfirm: () => Navigator.of(context).pop(true),
      ),
    );
    return result ?? false;
  }

  /// Asks for a short text, e.g. a reason. Returns null when cancelled.
  Future<String?> promptText({
    required String title,
    String? label,
    String? message,
    String confirmLabel = 'Confirm',
    bool destructive = false,
  }) async {
    final context = _navigation.navigatorKey.currentContext;
    if (context == null) return null;
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        destructive: destructive,
        onConfirm: () => Navigator.of(context).pop(controller.text.trim()),
        child: AppTextField(
          label: label,
          semanticsLabel: label ?? title,
          controller: controller,
          maxLines: 3,
          minLines: 3,
          autofocus: true,
        ),
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

/// The app's dialog: white, 16 radius, padded 20, title, 14 px message,
/// optional content, then Cancel and the action on the right.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    required this.onConfirm,
    this.message,
    this.child,
    this.cancelLabel = 'Cancel',
    this.destructive = false,
  });

  final String title;
  final String? message;
  final Widget? child;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(header: true, child: AppText.title(title)),
              if (message != null) ...[
                const SizedBox(height: 14),
                AppText.small(message!, tone: AppTextTone.secondary),
              ],
              if (child != null) ...[const SizedBox(height: 14), child!],
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppButton.text(
                    title: cancelLabel,
                    color: context.palette.text,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  AppButton(
                    title: confirmLabel,
                    variant: destructive
                        ? AppButtonVariant.destructive
                        : AppButtonVariant.primary,
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: onConfirm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
