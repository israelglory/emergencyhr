import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_card.dart';
import 'app_text.dart';

/// A row inside a card: at least 52 high, 10 x 16 padding.
class AppListRow extends StatelessWidget {
  const AppListRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showChevron,
    this.titleTone = AppTextTone.primary,
    this.strongTitle = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Defaults to showing a chevron when the row is tappable and has no
  /// trailing widget.
  final bool? showChevron;
  final AppTextTone titleTone;

  /// 15 / 600 titles (most rows); false for plain action rows.
  final bool strongTitle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final chevron = showChevron ?? (onTap != null && trailing == null);
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppSpacing.small),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      title,
                      tone: titleTone,
                      fontWeight: strongTitle ? FontWeight.w600 : null,
                    ),
                    if (subtitle != null) AppText.caption(subtitle!),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.small),
                trailing!,
              ],
              if (chevron)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.x1),
                  child: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: p.textTertiary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A card holding rows separated by thin dividers.
class AppListCard extends StatelessWidget {
  const AppListCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, child) in children.indexed) ...[
            if (i > 0) Divider(height: 1, thickness: 1, color: p.divider),
            child,
          ],
        ],
      ),
    );
  }
}

/// A small label above a figure: "ER beds" / "3".
class FigureTile extends StatelessWidget {
  const FigureTile({
    super.key,
    required this.label,
    required this.value,
    this.tone = AppTextTone.primary,
  });

  final String label;
  final String value;
  final AppTextTone tone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.micro(label),
        const SizedBox(height: 2),
        AppText.value(value, tone: tone),
      ],
    );
  }
}
