import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_card.dart';
import 'app_text.dart';
import 'state_views.dart';

/// A web page inside a shell: 24 px title, meta subtitle, actions on the
/// right, then sections 20 apart. Padded 28 32 on wide screens.
class WebPage extends StatelessWidget {
  const WebPage({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.actions = const [],
    this.onRefresh,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final List<Widget> children;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 840;
    final list = ListView(
      padding: wide
          ? const EdgeInsets.symmetric(horizontal: 32, vertical: 28)
          : const EdgeInsets.all(AppSpacing.screen),
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: AppSpacing.x2,
          runSpacing: AppSpacing.small,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  header: true,
                  child: AppText(title, variant: AppTextVariant.webTitle),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.half),
                  AppText.caption(subtitle!),
                ],
              ],
            ),
            if (actions.isNotEmpty)
              Wrap(spacing: AppSpacing.x1, runSpacing: 8, children: actions),
          ],
        ),
        for (final c in children) ...[
          const SizedBox(height: AppSpacing.section),
          c,
        ],
      ],
    );
    return onRefresh == null
        ? list
        : RefreshIndicator(onRefresh: onRefresh!, child: list);
  }
}

/// One column of a [DataTableCard]: a flexible share or a fixed width.
class TableColumn {
  const TableColumn(this.label, {this.flex = 1, this.width});

  final String label;
  final int flex;
  final double? width;
}

/// A white table card with a grey caps header row. Scrolls sideways when
/// narrower than [minWidth].
class DataTableCard extends StatelessWidget {
  const DataTableCard({
    super.key,
    required this.columns,
    required this.rows,
    this.minWidth = 760,
    this.empty,
  });

  final List<TableColumn> columns;
  final List<List<Widget>> rows;
  final double minWidth;

  /// Shown instead of rows when there are none.
  final Widget? empty;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget line(List<Widget> cells, {bool header = false, bool last = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: header ? p.surfaceSubtle : null,
          border: last ? null : Border(bottom: BorderSide(color: p.divider)),
        ),
        child: Row(
          children: [
            for (final (i, c) in columns.indexed) ...[
              if (i > 0) const SizedBox(width: AppSpacing.x2),
              if (c.width != null)
                SizedBox(width: c.width, child: cells[i])
              else
                Expanded(flex: c.flex, child: cells[i]),
            ],
          ],
        ),
      );
    }

    final header = line([
      for (final c in columns)
        Text(
          c.label.toUpperCase(),
          style: AppTypography.caps.copyWith(
            letterSpacing: 0.5,
            color: p.textSecondary,
          ),
        ),
    ], header: true);

    return AppCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth < minWidth
                ? minWidth
                : constraints.maxWidth;
            final table = SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  if (rows.isEmpty && empty != null)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: empty,
                    ),
                  for (final (i, r) in rows.indexed)
                    line(r, last: i == rows.length - 1),
                ],
              ),
            );
            return constraints.maxWidth < minWidth
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: table,
                  )
                : table;
          },
        ),
      ),
    );
  }
}

/// Bold name over a meta line, for table cells and cards.
class NameCell extends StatelessWidget {
  const NameCell(this.name, {super.key, this.detail});

  final String name;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.subtitle(name),
        if (detail != null) AppText.caption(detail!),
      ],
    );
  }
}

/// A small count card, e.g. pipeline stage totals.
class CountTile extends StatelessWidget {
  const CountTile({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 110),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.caption(label),
            Text(
              value,
              style: AppTypography.title.copyWith(
                fontSize: 22,
                height: 28 / 22,
                color: p.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A compact 40 px search box for web toolbars.
class ToolbarSearch extends StatelessWidget {
  const ToolbarSearch({
    super.key,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.width = 320,
  });

  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    OutlineInputBorder border(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.mediumButton),
      borderSide: BorderSide(color: c),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: p.text,
          ),
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            enabledBorder: border(p.inputBorder),
            focusedBorder: border(p.primary),
            border: border(p.inputBorder),
          ),
        ),
      ),
    );
  }
}

/// Loading and error states for web pages, so each page reads the same.
class WebPageState extends StatelessWidget {
  const WebPageState({
    super.key,
    required this.isLoading,
    required this.error,
    required this.onRetry,
    required this.child,
  });

  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const LoadingState();
    if (error != null) return ErrorState(message: error!, onRetry: onRetry);
    return child;
  }
}

/// A compact 40 px select for web toolbars, e.g. "All areas".
class ToolbarSelect<T> extends StatelessWidget {
  const ToolbarSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.semanticsLabel,
  });

  final T value;
  final List<({T value, String label})> options;
  final ValueChanged<T?> onChanged;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      label: semanticsLabel,
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 12, right: 6),
        decoration: BoxDecoration(
          color: p.surface,
          border: Border.all(color: p.inputBorder),
          borderRadius: BorderRadius.circular(AppRadius.mediumButton),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            onChanged: onChanged,
            borderRadius: BorderRadius.circular(AppRadius.mediumButton),
            dropdownColor: p.surface,
            icon: Icon(Icons.keyboard_arrow_down, color: p.textSecondary),
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: p.text,
            ),
            items: [
              for (final o in options)
                DropdownMenuItem(value: o.value, child: Text(o.label)),
            ],
          ),
        ),
      ),
    );
  }
}
