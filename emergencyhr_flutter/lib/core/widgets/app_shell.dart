import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../utilities/window_size.dart';
import 'app_text.dart';

typedef ShellDestination = ({IconData icon, String label});

/// Navigation frame for the Desk, Admin and Field Agent shells: a side rail
/// when expanded, a bottom bar on phones (or a drawer when there are more
/// than five destinations).
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
  });

  final String title;
  final String? subtitle;
  final List<ShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget body;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final size = WindowSize.of(context);
    final p = context.palette;
    final useBottomBar = !size.isExpanded && destinations.length <= 5;
    final useDrawer = !size.isExpanded && !useBottomBar;

    final appBar = AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.title(title),
          if (subtitle != null) AppText.caption(subtitle!),
        ],
      ),
      actions: actions,
    );

    if (size.isExpanded) {
      return Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Row(
            children: [
              NavigationRail(
                extended: true,
                minExtendedWidth: 232,
                selectedIndex: selectedIndex,
                onDestinationSelected: onSelect,
                destinations: [
                  for (final d in destinations)
                    NavigationRailDestination(
                      icon: Icon(d.icon),
                      label: Text(d.label),
                    ),
                ],
              ),
              VerticalDivider(width: 1, color: p.divider),
              Expanded(child: body),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      drawer: useDrawer
          ? NavigationDrawer(
              selectedIndex: selectedIndex,
              onDestinationSelected: (i) {
                Navigator.of(context).pop();
                onSelect(i);
              },
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.x3,
                    AppSpacing.x2,
                    AppSpacing.x2,
                    AppSpacing.x1,
                  ),
                  child: AppText.title(title),
                ),
                for (final d in destinations)
                  NavigationDrawerDestination(
                    icon: Icon(d.icon),
                    label: Text(d.label),
                  ),
              ],
            )
          : null,
      body: SafeArea(child: body),
      bottomNavigationBar: useBottomBar
          ? DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: p.divider)),
              ),
              child: NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: onSelect,
                height: 64,
                destinations: [
                  for (final d in destinations)
                    NavigationDestination(icon: Icon(d.icon), label: d.label),
                ],
              ),
            )
          : null,
    );
  }
}

/// Max-width wrapper for shell pages on wide screens.
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
