import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_button.dart';
import 'app_tab_bar.dart';
import 'app_text.dart';

typedef ShellDestination = ({IconData icon, String label});

/// Navigation frame for the Desk, Admin and Field Agent shells.
///
/// Wide screens: a white side menu (title, subtitle, items, Home at the
/// bottom) beside the page. Phones: a white 64 px top bar with title,
/// subtitle and a small Home button, plus bottom tabs, or a drawer when
/// there are more than five destinations (Admin).
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelect,
    required this.body,
    this.subtitle,
    this.actions,
    this.onHome,
    this.onTitleTap,
  });

  final String title;
  final String? subtitle;
  final List<ShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget body;

  /// Extra top bar buttons on phones.
  final List<Widget>? actions;

  /// Shows a "Home" button (top bar on phones, menu foot on wide screens).
  final VoidCallback? onHome;

  /// Makes the title a button with a chevron, e.g. to switch hospital.
  final VoidCallback? onTitleTap;

  static const sideMenuBreakpoint = 840.0;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final wide = MediaQuery.sizeOf(context).width >= sideMenuBreakpoint;
    final useDrawer = !wide && destinations.length > 5;

    if (wide) {
      return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SideMenu(
              title: title,
              subtitle: subtitle,
              destinations: destinations,
              selectedIndex: selectedIndex,
              onSelect: onSelect,
              onHome: onHome,
              onTitleTap: onTitleTap,
            ),
            Expanded(child: SafeArea(left: false, child: body)),
          ],
        ),
      );
    }

    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _ShellTitle(title: title, onTap: onTitleTap),
        if (subtitle != null) AppText.caption(subtitle!),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: p.surface,
        toolbarHeight: 64,
        automaticallyImplyLeading: useDrawer,
        titleSpacing: useDrawer ? 0 : AppSpacing.screen,
        shape: Border(bottom: BorderSide(color: p.border)),
        title: titleBlock,
        actions: [
          ...?actions,
          if (onHome != null)
            AppButton.secondary(
              title: 'Home',
              size: AppButtonSize.small,
              expand: false,
              onPressed: onHome,
            ),
          const SizedBox(width: AppSpacing.small),
        ],
      ),
      drawer: useDrawer
          ? Drawer(
              width: AppSizes.adminMenuWidth + 32,
              child: _SideMenu(
                title: title,
                subtitle: subtitle,
                destinations: destinations,
                selectedIndex: selectedIndex,
                onSelect: (i) {
                  Navigator.of(context).pop();
                  onSelect(i);
                },
                onHome: onHome,
                inDrawer: true,
              ),
            )
          : null,
      body: SafeArea(child: body),
      bottomNavigationBar: useDrawer || destinations.length < 2
          ? null
          : AppTabBar(
              compact: true,
              items: destinations,
              selectedIndex: selectedIndex,
              onSelect: onSelect,
            ),
    );
  }
}

class _ShellTitle extends StatelessWidget {
  const _ShellTitle({required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Flexible(
      child: AppText.title(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    if (onTap == null) {
      return Row(mainAxisSize: MainAxisSize.min, children: [text]);
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.status),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          text,
          const SizedBox(width: AppSpacing.half),
          const Icon(Icons.keyboard_arrow_down, size: 20),
        ],
      ),
    );
  }
}

/// White menu with a right border, as in the admin and desk web designs.
class _SideMenu extends StatelessWidget {
  const _SideMenu({
    required this.title,
    required this.subtitle,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelect,
    this.onHome,
    this.onTitleTap,
    this.inDrawer = false,
  });

  final String title;
  final String? subtitle;
  final List<ShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback? onHome;
  final VoidCallback? onTitleTap;
  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // Long menus (Admin) use 40 px items at 14 px; short ones 44 at 15.
    final dense = destinations.length > 5;
    final itemHeight = dense ? 40.0 : AppSizes.tapTarget;
    final itemStyle = dense ? AppTypography.bodySmall : AppTypography.body;
    return Container(
      width: AppSizes.adminMenuWidth,
      decoration: BoxDecoration(
        color: p.surface,
        border: inDrawer ? null : Border(right: BorderSide(color: p.border)),
      ),
      child: SafeArea(
        right: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 24, 14, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.small,
                ),
                child: _ShellTitle(title: title, onTap: onTitleTap),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
                  child: AppText.caption(subtitle!),
                ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    for (var i = 0; i < destinations.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: _MenuItem(
                          label: destinations[i].label,
                          selected: i == selectedIndex,
                          height: itemHeight,
                          style: itemStyle,
                          onTap: () => onSelect(i),
                        ),
                      ),
                  ],
                ),
              ),
              if (onHome != null)
                AppButton.secondary(
                  title: 'Home',
                  size: AppButtonSize.medium,
                  onPressed: onHome,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.label,
    required this.selected,
    required this.height,
    required this.style,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final double height;
  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final radius = BorderRadius.circular(AppRadius.mediumButton);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? p.primaryContainer : Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            height: height,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
            child: Text(
              label,
              style: style.copyWith(
                color: selected ? p.primaryText : p.textStrong,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Web page content for shells: padded 28 32, max width, with an optional
/// 24 px title row ("wh" in the designs).
class ShellPageFrame extends StatelessWidget {
  const ShellPageFrame({
    super.key,
    required this.child,
    this.maxWidth = AppSizes.wideContentMaxWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
