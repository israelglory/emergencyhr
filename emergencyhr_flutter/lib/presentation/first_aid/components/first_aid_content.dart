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

/// Lays out a first-aid card: heading and summary, numbered Do steps, then
/// Don't.
class FirstAidContent extends StatelessWidget {
  const FirstAidContent({super.key, required this.card});

  final FirstAidDisplay card;

  @override
  Widget build(BuildContext context) {
    return SectionColumn(
      gap: AppSpacing.x2,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headline(card.title),
            const SizedBox(height: 6),
            AppText(card.summary, tone: AppTextTone.secondary),
          ],
        ),
        _Group(
          title: 'Do',
          children: [
            for (final (i, step) in card.doSteps.indexed)
              NumberedStepRow(number: i + 1, text: step),
          ],
        ),
        if (card.dontSteps.isNotEmpty)
          _Group(
            title: "Don't",
            children: [
              for (final step in card.dontSteps) DontStepRow(text: step),
            ],
          ),
      ],
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: AppText.caps(title)),
        const SizedBox(height: AppSpacing.x1),
        AppListCard(children: children),
      ],
    );
  }
}
