import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_text.dart';

/// Caption caps above a group, e.g. "QUICK HELP". Use [large] for an h3
/// heading instead.
class SectionHeader extends StatelessWidget {
  const SectionHeader(
    this.title, {
    super.key,
    this.subtitle,
    this.trailing,
    this.large = false,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: large ? AppText.title(title) : AppText.caps(title),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.half),
                  AppText.caption(subtitle!),
                ],
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
