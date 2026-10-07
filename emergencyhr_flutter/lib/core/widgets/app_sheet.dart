import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_text.dart';

/// Contents of a bottom sheet: h3 title with a close button on the right,
/// then children 16 apart, padded 0 20 28 (the theme draws the grab
/// handle).
class AppSheet extends StatelessWidget {
  const AppSheet({
    super.key,
    required this.title,
    required this.children,
    this.onClose,
  });

  final String title;
  final List<Widget> children;

  /// Defaults to closing the sheet.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screen,
          0,
          AppSpacing.tight,
          28,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.tight),
                      child: Semantics(
                        header: true,
                        child: AppText.title(title),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Close',
                    onPressed:
                        onClose ?? () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.tight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final child in children) ...[
                      const SizedBox(height: AppSpacing.x2),
                      child,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
