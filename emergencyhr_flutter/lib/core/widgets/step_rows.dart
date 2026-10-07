import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_text.dart';

/// A card row with a numbered blue circle, for first-aid "Do" steps.
class NumberedStepRow extends StatelessWidget {
  const NumberedStepRow({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return _StepRow(
      marker: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: p.primary, shape: BoxShape.circle),
        child: Text(
          '$number',
          style: AppTypography.meta.copyWith(
            color: p.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      text: text,
    );
  }
}

/// A card row with a red cross, for first-aid "Don't" steps.
class DontStepRow extends StatelessWidget {
  const DontStepRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return _StepRow(
      marker: Icon(
        Icons.close_rounded,
        size: 22,
        color: context.palette.emergency,
        semanticLabel: "Don't",
      ),
      text: text,
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.marker, required this.text});

  final Widget marker;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          marker,
          const SizedBox(width: AppSpacing.small),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: AppText(text),
            ),
          ),
        ],
      ),
    );
  }
}
