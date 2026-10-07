import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import 'app_text.dart';
import 'list_rows.dart';

typedef ChecklistLine = ({String label, bool done});

/// A read-only checklist card: a green tick circle when done, an empty
/// circle when not, and the label.
class ChecklistView extends StatelessWidget {
  const ChecklistView({super.key, required this.items});

  final List<ChecklistLine> items;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppListCard(
      children: [
        for (final item in items)
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 52),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  DoneMark(done: item.done),
                  const SizedBox(width: AppSpacing.small),
                  Expanded(child: AppText(item.label)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// 24 px circle: green with a white tick when done, grey ring otherwise.
class DoneMark extends StatelessWidget {
  const DoneMark({super.key, required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      label: done ? 'Done' : 'To do',
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: done ? p.positive : null,
          shape: BoxShape.circle,
          border: done ? null : Border.all(color: p.inputBorder, width: 2),
        ),
        child: done
            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
