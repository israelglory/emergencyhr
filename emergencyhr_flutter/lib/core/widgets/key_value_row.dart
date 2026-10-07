import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// A label on the left and a bold value on the right. [inCard] gives it
/// card row sizing (min 52, padded 10 16) for use in an AppListCard.
class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueTone = AppTextTone.primary,
    this.inCard = false,
  });

  final String label;
  final String value;
  final AppTextTone valueTone;
  final bool inCard;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: AppText(label, tone: AppTextTone.secondary)),
        const SizedBox(width: AppSpacing.small),
        Flexible(
          child: AppText(
            value,
            tone: valueTone,
            numeric: true,
            alignment: TextAlign.end,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
    if (!inCard) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.half),
        child: row,
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.list,
          vertical: AppSpacing.tight,
        ),
        child: row,
      ),
    );
  }
}

/// A card row with an icon, a small label and a bold value underneath,
/// e.g. "Emergency desk" / the phone number.
class LabelledValueRow extends StatelessWidget {
  const LabelledValueRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.list,
            vertical: AppSpacing.tight,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: p.textSecondary),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.micro(label),
                    const SizedBox(height: 2),
                    AppText(value, fontWeight: FontWeight.w600, numeric: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
