import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// Shows the exported data with a copy button.
class ExportSheet extends StatelessWidget {
  const ExportSheet({super.key, required this.json, required this.onCopy});

  final String json;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.x3,
        0,
        AppSpacing.x3,
        AppSpacing.x3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppText.title('Your data'),
          const SizedBox(height: AppSpacing.x1),
          const AppText(
            'Everything Emergencyhr stores about you. Copy it to keep a record.',
            tone: AppTextTone.secondary,
          ),
          const SizedBox(height: AppSpacing.x2),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: AppCard(
              muted: true,
              child: SingleChildScrollView(
                child: SelectableText(
                  json,
                  style: AppText.styleFor(
                    context,
                    AppTextVariant.caption,
                  )?.copyWith(fontFamily: 'monospace'),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.x2),
          AppButton(
            title: 'Copy all',
            icon: Icons.copy_outlined,
            onPressed: onCopy,
          ),
        ],
      ),
    );
  }
}
