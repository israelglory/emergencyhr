import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_text.dart';
import 'list_rows.dart';
import 'status_badge.dart';

/// One figure in a hospital row, e.g. "ER beds" / "3". [tone] colours the
/// value, e.g. a required deposit in the stale colour.
class TileMetric {
  const TileMetric(this.label, this.value, {this.tone = AppTextTone.primary});

  final String label;
  final String value;
  final AppTextTone tone;
}

/// A hospital card: name and distance, status label, figures, capability
/// chips, and Call / Directions. All text arrives display-ready.
class HospitalListTile extends StatelessWidget {
  const HospitalListTile({
    super.key,
    required this.name,
    required this.distanceLabel,
    required this.statusLabel,
    required this.statusTone,
    required this.metrics,
    this.capabilities = const [],
    this.footnote,
    this.onTap,
    this.onCall,
    this.onDirections,
    this.callLabel = 'Call',
  });

  final String name;

  /// "2.4 km · About 9 min drive".
  final String distanceLabel;
  final String statusLabel;
  final StatusTone statusTone;
  final List<TileMetric> metrics;
  final List<String> capabilities;
  final String? footnote;
  final VoidCallback? onTap;
  final VoidCallback? onCall;
  final VoidCallback? onDirections;
  final String callLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    const gap = SizedBox(height: AppSpacing.small);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.status),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.title(name),
                      const SizedBox(height: AppSpacing.half),
                      AppText.caption(distanceLabel),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(Icons.chevron_right, size: 20, color: p.textTertiary),
              ],
            ),
          ),
          gap,
          StatusLabel(label: statusLabel, tone: statusTone),
          if (metrics.isNotEmpty) ...[
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final m in metrics)
                  Expanded(
                    child: FigureTile(
                      label: m.label,
                      value: m.value,
                      tone: m.tone,
                    ),
                  ),
              ],
            ),
          ],
          if (capabilities.isNotEmpty) ...[
            gap,
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final c in capabilities) AppChip(c)],
            ),
          ],
          if (footnote != null) ...[
            const SizedBox(height: AppSpacing.x1),
            AppText.caption(footnote!),
          ],
          if (onCall != null || onDirections != null) ...[
            gap,
            Row(
              children: [
                if (onCall != null)
                  Expanded(
                    child: AppButton(
                      title: callLabel,
                      icon: Icons.call_outlined,
                      size: AppButtonSize.medium,
                      onPressed: onCall,
                      semanticsLabel: '$callLabel $name',
                    ),
                  ),
                if (onCall != null && onDirections != null)
                  const SizedBox(width: AppSpacing.tight),
                if (onDirections != null)
                  Expanded(
                    child: AppButton.secondary(
                      title: 'Directions',
                      icon: Icons.near_me_outlined,
                      size: AppButtonSize.medium,
                      onPressed: onDirections,
                      semanticsLabel: 'Directions to $name',
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// A compact hospital row for the "nothing accepting" list: name,
/// distance, status badge and a round outlined Call button. Use inside an
/// [AppListCard].
class HospitalCompactRow extends StatelessWidget {
  const HospitalCompactRow({
    super.key,
    required this.name,
    required this.distanceLabel,
    required this.statusLabel,
    required this.statusTone,
    this.onTap,
    this.onCall,
  });

  final String name;
  final String distanceLabel;
  final String statusLabel;
  final StatusTone statusTone;
  final VoidCallback? onTap;
  final VoidCallback? onCall;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.subtitle(name),
                  const SizedBox(height: 6),
                  AppText.caption(distanceLabel),
                  const SizedBox(height: 6),
                  StatusBadge(label: statusLabel, tone: statusTone),
                ],
              ),
            ),
            if (onCall != null) ...[
              const SizedBox(width: AppSpacing.small),
              SizedBox.square(
                dimension: AppSizes.tapTarget,
                child: OutlinedButton(
                  onPressed: onCall,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                    side: BorderSide(color: p.inputBorder),
                    foregroundColor: p.text,
                  ),
                  child: Icon(
                    Icons.call_outlined,
                    size: 20,
                    semanticLabel: 'Call $name',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
