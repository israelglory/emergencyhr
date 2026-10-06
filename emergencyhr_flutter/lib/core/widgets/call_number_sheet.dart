import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_button.dart';
import 'app_text.dart';

/// On web and desktop, a phone number shown large with copy and dial links.
class CallNumberSheet extends StatelessWidget {
  const CallNumberSheet({
    super.key,
    required this.title,
    required this.number,
    required this.onCopy,
    required this.onDial,
    this.message,
  });

  final String title;
  final String number;
  final String? message;
  final VoidCallback onCopy;
  final VoidCallback onDial;

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
          AppText.title(title),
          const SizedBox(height: AppSpacing.x2),
          SelectableText(
            number,
            style: AppText.styleFor(
              context,
              AppTextVariant.display,
            )?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.x1),
            AppText(message!, tone: AppTextTone.secondary),
          ],
          const SizedBox(height: AppSpacing.x3),
          AppButton(
            title: 'Copy number',
            icon: Icons.copy_outlined,
            onPressed: onCopy,
          ),
          const SizedBox(height: AppSpacing.x1),
          AppButton.secondary(
            title: 'Open in phone app',
            icon: Icons.call_outlined,
            onPressed: onDial,
          ),
        ],
      ),
    );
  }
}
