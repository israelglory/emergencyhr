import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_button.dart';
import 'app_sheet.dart';
import 'app_text.dart';

/// On web and desktop, a phone number shown large with copy and dial
/// buttons.
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

  /// Who answers, e.g. "Harbour Point Hospital, emergency desk".
  final String? message;
  final VoidCallback onCopy;
  final VoidCallback onDial;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppSheet(
      title: title,
      children: [
        if (message != null) AppText.caption(message!),
        SelectableText(
          number,
          style: AppTypography.heading.copyWith(
            fontSize: 32,
            height: 40 / 32,
            letterSpacing: 0.5,
            color: p.text,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppButton.secondary(
                title: 'Copy number',
                size: AppButtonSize.medium,
                onPressed: onCopy,
              ),
            ),
            const SizedBox(width: AppSpacing.tight),
            Expanded(
              child: AppButton(
                title: 'Open in phone app',
                size: AppButtonSize.medium,
                onPressed: onDial,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
