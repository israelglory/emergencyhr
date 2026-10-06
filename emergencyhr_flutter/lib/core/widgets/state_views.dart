import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_button.dart';
import 'app_loader.dart';
import 'app_text.dart';

/// Shown when a list or screen has nothing to show.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _StateLayout(
      icon: icon,
      title: title,
      message: message,
      action: actionLabel != null && onAction != null
          ? AppButton.secondary(
              title: actionLabel!,
              onPressed: onAction,
              expand: false,
            )
          : null,
    );
  }
}

/// Shown when loading failed. Always offers a way forward.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.title = 'Something went wrong',
    this.onRetry,
    this.retryLabel = 'Try again',
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return _StateLayout(
      icon: Icons.error_outline,
      title: title,
      message: message,
      action: onRetry == null
          ? null
          : AppButton.secondary(
              title: retryLabel,
              onPressed: onRetry,
              icon: Icons.refresh,
              expand: false,
            ),
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.label = 'Loading'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        liveRegion: true,
        label: label,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLoader(),
            const SizedBox(height: AppSpacing.x2),
            AppText(label, tone: AppTextTone.secondary),
          ],
        ),
      ),
    );
  }
}

class _StateLayout extends StatelessWidget {
  const _StateLayout({
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.x3),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: context.palette.textTertiary),
              const SizedBox(height: AppSpacing.x2),
              AppText.title(title, alignment: TextAlign.center),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.x1),
                AppText(
                  message!,
                  tone: AppTextTone.secondary,
                  alignment: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: AppSpacing.x3),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
