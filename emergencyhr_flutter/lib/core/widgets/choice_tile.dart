import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// A large selectable row with an icon, used for pickers.
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
      borderRadius: BorderRadius.circular(AppRadius.container),
      side: BorderSide(
        color: selected ? p.text : p.divider,
        width: selected ? 2 : 1,
      ),
    );
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: p.surface,
        shape: shape,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppSizes.buttonLarge),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.x2,
                vertical: AppSpacing.x1 + AppSpacing.half,
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: p.text),
                    const SizedBox(width: AppSpacing.x2),
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
                  trailing ?? Icon(Icons.chevron_right, color: p.textTertiary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
