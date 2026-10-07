import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// Centres a section's content at 1200 px with 24 px side padding.
class LandingFrame extends StatelessWidget {
  const LandingFrame({
    super.key,
    required this.child,
    this.top = 0,
    this.bottom = 0,
  });

  final Widget child;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, top, 24, bottom),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

/// One child of a [FlexRow]: its preferred width and its share of spare
/// room, like CSS `flex: <flex> 1 <basis>px`. A flex of 0 keeps the child
/// at its natural width, like `flex: none`.
typedef FlexItem = ({double basis, int flex, Widget child});

/// Side by side when there is room for every item's basis width, otherwise
/// stacked, like a wrapping CSS flex row.
class FlexRow extends StatelessWidget {
  const FlexRow({
    super.key,
    required this.items,
    this.gap = 24,
    this.runGap,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<FlexItem> items;
  final double gap;
  final double? runGap;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final needed =
            items.fold<double>(0, (sum, i) => sum + i.basis) +
            gap * (items.length - 1);
        if (constraints.maxWidth >= needed) {
          final row = Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              for (final (i, item) in items.indexed) ...[
                if (i > 0) SizedBox(width: gap),
                if (item.flex == 0)
                  item.child
                else
                  Expanded(flex: item.flex, child: item.child),
              ],
            ],
          );
          return crossAxisAlignment == CrossAxisAlignment.stretch
              ? IntrinsicHeight(child: row)
              : row;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, item) in items.indexed) ...[
              if (i > 0) SizedBox(height: runGap ?? gap),
              item.child,
            ],
          ],
        );
      },
    );
  }
}

/// A grid with as many columns as fit [minItemWidth], equal heights per
/// row, like CSS `repeat(auto-fit, minmax(<min>px, 1fr))`.
class AutoGrid extends StatelessWidget {
  const AutoGrid({
    super.key,
    required this.children,
    required this.minItemWidth,
    this.gap = 20,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = ((constraints.maxWidth + gap) / (minItemWidth + gap))
            .floor()
            .clamp(1, children.length);
        final rows = <Widget>[];
        for (var start = 0; start < children.length; start += columns) {
          final cells = children.skip(start).take(columns).toList();
          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < columns; i++) ...[
                    if (i > 0) SizedBox(width: gap),
                    Expanded(
                      child: i < cells.length ? cells[i] : const SizedBox(),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, r) in rows.indexed) ...[
              if (i > 0) SizedBox(height: gap),
              r,
            ],
          ],
        );
      },
    );
  }
}

/// Caption caps, a large heading and an optional paragraph, max 640 wide.
class LandingHeading extends StatelessWidget {
  const LandingHeading({
    super.key,
    required this.cap,
    required this.title,
    this.body,
    this.titleSize = 40,
  });

  final String cap;
  final String title;
  final String? body;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caps(cap, color: p.primaryText),
          const SizedBox(height: AppSpacing.tight),
          Semantics(
            header: true,
            child: Text(title, style: LandingText.heading(p.text, titleSize)),
          ),
          if (body != null) ...[
            const SizedBox(height: AppSpacing.tight),
            Text(body!, style: LandingText.body(p.textSecondary, 16)),
          ],
        ],
      ),
    );
  }
}

/// Landing page text styles on top of the app type scale.
abstract final class LandingText {
  /// 800 headings: 40 / 46 (sections), 34 / 40, 26 / 32 and so on.
  static TextStyle heading(Color color, double size) =>
      AppTypography.heading.copyWith(
        fontSize: size,
        height: size >= 38
            ? (size + 6) / size
            : size >= 34
            ? 40 / 34
            : 32 / 26,
        fontWeight: FontWeight.w800,
        letterSpacing: size >= 38
            ? -1
            : size >= 34
            ? -0.8
            : -0.4,
        color: color,
      );

  /// Body copy, 15 / 22 to 19 / 30.
  static TextStyle body(Color color, double size) =>
      AppTypography.body.copyWith(
        fontSize: size,
        height: switch (size) {
          >= 19 => 30 / 19,
          >= 17 => 28 / 17,
          >= 16 => 26 / 16,
          _ => 22 / 15,
        },
        color: color,
      );

  /// Card titles: 20 or 18, 700.
  static TextStyle cardTitle(Color color, double size) =>
      AppTypography.title.copyWith(
        fontSize: size,
        height: (size + 6) / size,
        color: color,
      );
}
