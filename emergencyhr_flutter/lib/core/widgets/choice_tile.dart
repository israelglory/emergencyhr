import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// A large selectable card row with an optional icon tile, used for pickers.
/// Selected: primary border and a light primary fill.
class ChoiceTile extends StatelessWidget {
  const ChoiceTile({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.subtitle,
    this.selected = false,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.card),
      side: BorderSide(
        color: selected ? p.primary : p.border,
        width: selected ? 1.5 : 1,
      ),
    );
    return Semantics(
      button: true,
      selected: selected,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: p.cardShadows,
        ),
        child: Material(
          color: selected ? p.primaryContainer : p.surface,
          shape: shape,
          child: InkWell(
            onTap: onTap,
            customBorder: shape,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 64),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.list,
                  vertical: AppSpacing.small,
                ),
                child: Row(
                  children: [
                    if (icon != null) ...[
                      Container(
                        width: AppSizes.iconTile,
                        height: AppSizes.iconTile,
                        decoration: BoxDecoration(
                          color: selected ? p.surface : p.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppRadius.control,
                          ),
                        ),
                        child: Icon(icon, size: 22, color: p.primaryText),
                      ),
                      const SizedBox(width: AppSpacing.small),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.subtitle(title),
                          if (subtitle != null) AppText.caption(subtitle!),
                        ],
                      ),
                    ),
                    trailing ??
                        (selected
                            ? Icon(Icons.check_circle, color: p.primary)
                            : Icon(Icons.chevron_right, color: p.textTertiary)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
