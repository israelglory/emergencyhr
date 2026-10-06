import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// Display-ready first-aid card.
typedef FirstAidDisplay = ({
  String title,
  String summary,
  List<String> doSteps,
  List<String> dontSteps,
  bool showDraft,
});

/// Lays out a first-aid card: numbered Do steps, then Don't.
class FirstAidContent extends StatelessWidget {
  const FirstAidContent({super.key, required this.card});

  final FirstAidDisplay card;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (card.showDraft) ...[
          const Align(
            alignment: Alignment.centerLeft,
            child: StatusBadge(
              label: 'Draft content',
              tone: StatusTone.warning,
            ),
          ),
          const SizedBox(height: AppSpacing.x1),
        ],
        AppText.title(card.title),
        const SizedBox(height: AppSpacing.half),
        AppText(card.summary, tone: AppTextTone.secondary),
        const SizedBox(height: AppSpacing.x2),
        const AppText.label('Do'),
        const SizedBox(height: AppSpacing.x1),
        for (final (i, step) in card.doSteps.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.x1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28,
                  child: AppText.label('${i + 1}.', numeric: true),
                ),
                Expanded(child: AppText(step)),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.x1),
        const AppText.label("Don't"),
        const SizedBox(height: AppSpacing.x1),
        for (final step in card.dontSteps)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.x1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28,
                  child: Icon(Icons.close, size: 18, color: p.emergencyText),
                ),
                Expanded(child: AppText(step)),
              ],
            ),
          ),
      ],
    );
  }
}
