import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_button.dart';
import 'app_text.dart';
import 'status_badge.dart';

/// One figure in the hospital tile, e.g. ("ER beds", "3").
typedef TileMetric = ({String label, String value});

/// A dense, scannable hospital row with Call and Directions.
/// All text arrives display-ready from the viewmodel.
class HospitalListTile extends StatelessWidget {
  const HospitalListTile({
    super.key,
    required this.name,
    required this.distanceLabel,
    required this.statusLabel,
    required this.statusTone,
    required this.metrics,
    this.etaLabel,
    this.capabilitiesLabel,
    this.footnote,
    this.onTap,
    this.onCall,
    this.onDirections,
    this.callLabel = 'Call',
  });

  final String name;
  final String distanceLabel;
  final String? etaLabel;
  final String statusLabel;
  final StatusTone statusTone;
  final List<TileMetric> metrics;
  final String? capabilitiesLabel;
  final String? footnote;
  final VoidCallback? onTap;
  final VoidCallback? onCall;
  final VoidCallback? onDirections;
  final String callLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.x2,
            vertical: AppSpacing.x2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: AppText.subtitle(name)),
                  const SizedBox(width: AppSpacing.x2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText.label(distanceLabel, numeric: true),
                      if (etaLabel != null)
                        AppText.caption(etaLabel!, numeric: true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.x1),
              StatusBadge(label: statusLabel, tone: statusTone),
              if (metrics.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.x1 + AppSpacing.half),
                Wrap(
                  spacing: AppSpacing.x3,
                  runSpacing: AppSpacing.x1,
                  children: [
                    for (final m in metrics)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.caption(m.label),
                          AppText.label(m.value, numeric: true),
                        ],
                      ),
                  ],
                ),
              ],
              if (capabilitiesLabel != null) ...[
                const SizedBox(height: AppSpacing.x1),
                AppText.caption(capabilitiesLabel!),
              ],
              if (footnote != null) ...[
                const SizedBox(height: AppSpacing.half),
                AppText.caption(footnote!, tone: AppTextTone.tertiary),
              ],
              if (onCall != null || onDirections != null) ...[
                const SizedBox(height: AppSpacing.x2),
                Row(
                  children: [
                    if (onCall != null)
                      Expanded(
                        child: AppButton(
                          title: callLabel,
                          icon: Icons.call_outlined,
                          onPressed: onCall,
                          semanticsLabel: '$callLabel $name',
                        ),
                      ),
                    if (onCall != null && onDirections != null)
                      const SizedBox(width: AppSpacing.x1),
                    if (onDirections != null)
                      Expanded(
                        child: AppButton.secondary(
                          title: 'Directions',
                          icon: Icons.directions_outlined,
                          onPressed: onDirections,
                          semanticsLabel: 'Directions to $name',
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
