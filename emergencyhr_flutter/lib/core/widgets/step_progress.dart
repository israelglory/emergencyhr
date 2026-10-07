import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Thin segments for multi-step forms: done and current in primary, the
/// rest grey.
class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.current, required this.total});

  /// 1-based.
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      label: 'Step $current of $total',
      child: Row(
        children: [
          for (var i = 1; i <= total; i++) ...[
            if (i > 1) const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: i <= current ? p.primary : p.inputBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
