import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_text.dart';
import 'icon_tile.dart';

/// Shown when a list or screen has nothing to show.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.search,
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
    return _StateCard(
      tile: IconTile(icon),
      title: title,
      message: message,
      action: actionLabel != null && onAction != null
          ? AppButton.secondary(
              title: actionLabel!,
              size: AppButtonSize.small,
              expand: false,
              onPressed: onAction,
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
    this.title = 'We could not load this',
    this.onRetry,
    this.retryLabel = 'Try again',
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return _StateCard(
      tile: const IconTile(
        Icons.warning_amber_rounded,
        tone: IconTileTone.critical,
      ),
      title: title,
      message: message,
      action: onRetry == null
          ? null
          : AppButton.secondary(
              title: retryLabel,
              size: AppButtonSize.small,
              expand: false,
              onPressed: onRetry,
            ),
    );
  }
}

/// Spinner, a bold label and two placeholder bars.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.label = 'Loading'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget bar(double factor) => FractionallySizedBox(
      widthFactor: factor,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          color: p.divider,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
    return Semantics(
      liveRegion: true,
      label: label,
      child: _Frame(
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: p.primary,
                  backgroundColor: p.border,
                ),
              ),
              const SizedBox(height: AppSpacing.tight),
              AppText.subtitle(label),
              const SizedBox(height: AppSpacing.tight),
              bar(0.8),
              const SizedBox(height: AppSpacing.tight),
              bar(0.55),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.tile,
    required this.title,
    this.message,
    this.action,
  });

  final Widget tile;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return _Frame(
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            tile,
            const SizedBox(height: AppSpacing.x1),
            AppText.subtitle(title),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.x1),
              AppText.caption(message!),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.x1),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Places a state card at the top of the available space with screen
/// padding, scrolling if needed.
class _Frame extends StatelessWidget {
  const _Frame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screen),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

/// A full-page message: round icon, heading, text, then actions, centred
/// vertically and left aligned (invites, guest Health Assistant).
class MessagePage extends StatelessWidget {
  const MessagePage({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.tone = IconTileTone.primary,
    this.solidIcon = false,
    this.children = const [],
  });

  final IconData icon;
  final String title;
  final String? message;
  final IconTileTone tone;

  /// Primary-filled icon with a white glyph (a valid invite).
  final bool solidIcon;

  /// Shown under the message, 14 apart, full width.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: solidIcon
                    ? Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: p.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 26, color: p.onPrimary),
                      )
                    : IconTile(icon, tone: tone, size: 52, circle: true),
              ),
              const SizedBox(height: 14),
              Semantics(header: true, child: AppText.headline(title)),
              if (message != null) ...[
                const SizedBox(height: 14),
                AppText(message!, tone: AppTextTone.secondary),
              ],
              for (final c in children) ...[const SizedBox(height: 14), c],
            ],
          ),
        ),
      ),
    );
  }
}
