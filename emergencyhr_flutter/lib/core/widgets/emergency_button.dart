import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// The single large Emergency button. Uses the one emergency red.
class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    super.key,
    required this.onPressed,
    this.title = 'Emergency',
    this.subtitle = 'Find a hospital that can take you now',
    this.height = AppSizes.emergencyButton,
  });

  final VoidCallback onPressed;
  final String title;
  final String subtitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      button: true,
      label: '$title. $subtitle',
      excludeSemantics: true,
      child: Material(
        color: p.emergency,
        borderRadius: BorderRadius.circular(AppRadius.container),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.container),
          focusColor: p.onEmergency.withValues(alpha: 0.16),
          hoverColor: p.onEmergency.withValues(alpha: 0.08),
          highlightColor: p.onEmergency.withValues(alpha: 0.12),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.x3),
              child: Row(
                children: [
                  Icon(
                    Icons.emergency_outlined,
                    size: 40,
                    color: p.onEmergency,
                  ),
                  const SizedBox(width: AppSpacing.x2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText.display(title, tone: AppTextTone.onEmergency),
                        const SizedBox(height: AppSpacing.half),
                        AppText(subtitle, tone: AppTextTone.onEmergency),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: p.onEmergency),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
