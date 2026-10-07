import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';

typedef TabBarItem = ({IconData icon, String label});

/// Bottom tabs: white, top border, selected icon in a primaryContainer pill
/// with a bold primary label. [compact] is the staff version (72 high,
/// 56 x 30 pill); the public version is 80 high with a 64 x 32 pill.
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    this.compact = false,
  });

  final List<TabBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final pill = compact ? const Size(56, 30) : const Size(64, 32);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(top: BorderSide(color: p.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: compact ? 72 : AppSizes.bottomNav,
          child: Row(
            crossAxisAlignment: compact
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _TabItem(
                    item: items[i],
                    selected: i == selectedIndex,
                    pill: pill,
                    topPadding: compact ? 0 : AppSpacing.x1,
                    onTap: () => onSelect(i),
                    palette: p,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.item,
    required this.selected,
    required this.pill,
    required this.topPadding,
    required this.onTap,
    required this.palette,
  });

  final TabBarItem item;
  final bool selected;
  final Size pill;
  final double topPadding;
  final VoidCallback onTap;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final p = palette;
    final colour = selected ? p.primaryText : p.textSecondary;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        containedInkWell: true,
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: pill.width,
                height: pill.height,
                decoration: BoxDecoration(
                  color: selected ? p.primaryContainer : Colors.transparent,
                  borderRadius: BorderRadius.circular(pill.height / 2),
                ),
                child: Icon(item.icon, size: 22, color: colour),
              ),
              const SizedBox(height: AppSpacing.half),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.micro.copyWith(
                  color: colour,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
