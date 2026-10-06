import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import 'app_text.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.subtitle, this.trailing});

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.x1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(header: true, child: AppText.title(title)),
                if (subtitle != null) AppText.caption(subtitle!),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
