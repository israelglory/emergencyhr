import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_text.dart';

/// Standard screen: app bar, centred readable column, safe areas.
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.maxWidth = AppSizes.contentMaxWidth,
    this.padding = const EdgeInsets.all(AppSpacing.x2),
    this.scrollable = true,
    this.showAppBar = true,
  });

  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;

  /// Pinned below the content, e.g. a primary button.
  final Widget? bottom;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool scrollable;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: body);
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: title == null ? null : AppText.title(title!),
              actions: actions,
              leading: leading,
            )
          : null,
      body: SafeArea(
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
            if (bottom != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.x2,
                      AppSpacing.x1,
                      AppSpacing.x2,
                      AppSpacing.x2,
                    ),
                    child: bottom,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
