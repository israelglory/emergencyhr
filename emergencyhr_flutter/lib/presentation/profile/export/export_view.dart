import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// Shows the exported data with a copy button.
class ExportSheet extends StatelessWidget {
  const ExportSheet({super.key, required this.json, required this.onCopy});

  final String json;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppSheet(
      title: 'Your data',
      children: [
        const AppText.caption('Everything EmergencyHr stores about you.'),
        Container(
          constraints: const BoxConstraints(maxHeight: 330),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: p.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.mediumButton),
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              json,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                height: 18 / 12,
                color: p.text,
              ),
            ),
          ),
        ),
        AppButton(title: 'Copy all', onPressed: onCopy),
      ],
    );
  }
}
