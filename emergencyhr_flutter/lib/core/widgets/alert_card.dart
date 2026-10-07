import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';

/// Red-flag card: light red fill and border, warning icon, 15 / 600 dark
/// red text, then an optional action such as a large Call 112 button.
class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.message,
    this.title,
    this.actions = const [],
    this.icon = Icons.warning_amber_rounded,
  });

  final String? title;
  final String message;
  final List<Widget> actions;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      container: true,
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.list),
        decoration: BoxDecoration(
          color: p.emergencyContainer,
          border: Border.all(color: p.emergencyBorder),
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: p.cardShadows,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 22, color: p.emergencyText),
                const SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) ...[
                        Text(
                          title!,
                          style: AppTypography.bodyStrong.copyWith(
                            color: p.critical,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          message,
                          style: AppTypography.bodySmall.copyWith(
                            color: p.emergencyBody,
                          ),
                        ),
                      ] else
                        Text(
                          message,
                          style: AppTypography.bodyStrong.copyWith(
                            color: p.emergencyInk,
                            height: 21 / 15,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            for (final a in actions) ...[
              const SizedBox(height: AppSpacing.small),
              a,
            ],
          ],
        ),
      ),
    );
  }
}
