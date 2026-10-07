import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';

/// Standard screen: a 56 px top bar (back chevron and title), a centred
/// readable body padded 8 20 20 with 20 between sections, and an optional
/// white footer with a top border for the main action.
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.maxWidth = AppSizes.contentMaxWidth,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.screen,
      AppSpacing.x1,
      AppSpacing.screen,
      AppSpacing.screen,
    ),
    this.scrollable = true,
    this.showAppBar = true,
    this.showBack = true,
    this.appBarColor,
    this.appBarBorder = false,
    this.bottomNavigationBar,
    this.appBar,
  });

  final String? title;
  final Widget body;
  final List<Widget>? actions;

  /// Replaces the back chevron, e.g. a close button.
  final Widget? leading;

  /// Pinned below the content in a white footer, e.g. a primary button.
  final Widget? bottom;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool scrollable;
  final bool showAppBar;
  final bool showBack;

  /// Defaults to the screen background. Results uses white with a border.
  final Color? appBarColor;
  final bool appBarBorder;
  final Widget? bottomNavigationBar;

  /// Replaces the standard top bar, e.g. the Home logo bar.
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final content = Padding(padding: padding, child: body);
    final canPop = Navigator.of(context).canPop();
    Widget? lead = leading;
    if (lead == null && showBack && canPop) {
      lead = IconButton(
        icon: const Icon(Icons.chevron_left, size: 28),
        tooltip: 'Back',
        onPressed: () => Navigator.of(context).maybePop(),
      );
    }
    return Scaffold(
      appBar: !showAppBar
          ? null
          : appBar ??
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appBarColor,
                  leading: lead,
                  leadingWidth: lead == null ? 0 : 52,
                  titleSpacing: lead == null ? AppSpacing.screen : 4,
                  title: title == null ? null : AppText.title(title!),
                  actions: actions,
                  shape: appBarBorder
                      ? Border(bottom: BorderSide(color: p.border))
                      : null,
                ),
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        bottom: bottom == null && bottomNavigationBar == null,
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: scrollable
                      ? SingleChildScrollView(child: content)
                      : content,
                ),
              ),
            ),
            if (bottom != null) PageFooter(maxWidth: maxWidth, child: bottom!),
          ],
        ),
      ),
    );
  }
}

/// White footer with a top border, padded 12 16 24.
class PageFooter extends StatelessWidget {
  const PageFooter({
    super.key,
    required this.child,
    this.maxWidth = AppSizes.contentMaxWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(top: BorderSide(color: p.border)),
      ),
      child: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.list,
                AppSpacing.small,
                AppSpacing.list,
                AppSpacing.x3,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Stacks children with the standard gap between sections (20).
class SectionColumn extends StatelessWidget {
  const SectionColumn({
    super.key,
    required this.children,
    this.gap = AppSpacing.section,
  });

  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) SizedBox(height: gap),
          children[i],
        ],
      ],
    );
  }
}
