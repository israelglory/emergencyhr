import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// One chat message. User messages sit right, replies left.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.text,
    required this.fromUser,
    this.pending = false,
  });

  final String text;
  final bool fromUser;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.x1),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.x2,
            vertical: AppSpacing.x1 + AppSpacing.half,
          ),
          decoration: BoxDecoration(
            color: fromUser ? p.surfaceMuted : p.surface,
            border: Border.all(color: p.divider),
            borderRadius: BorderRadius.circular(AppRadius.container),
          ),
          child: pending && text.isEmpty
              ? const AppLoader(size: 16)
              : SelectableText(
                  text,
                  style: AppText.styleFor(context, AppTextVariant.body),
                ),
        ),
      ),
    );
  }
}

/// Shown in the chat when a red flag is detected.
class RedFlagCard extends StatelessWidget {
  const RedFlagCard({
    super.key,
    required this.title,
    required this.message,
    required this.onFindCare,
    required this.onCall112,
  });

  final String title;
  final String message;
  final VoidCallback onFindCare;
  final VoidCallback onCall112;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.x1),
      padding: const EdgeInsets.all(AppSpacing.x2),
      decoration: BoxDecoration(
        color: p.surface,
        border: Border.all(color: p.emergency, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.container),
      ),
      child: Semantics(
        liveRegion: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.subtitle(title, tone: AppTextTone.critical),
            const SizedBox(height: AppSpacing.half),
            AppText(message),
            const SizedBox(height: AppSpacing.x2),
            AppButton.danger(
              title: 'Find emergency care now',
              icon: Icons.emergency_outlined,
              onPressed: onFindCare,
            ),
            const SizedBox(height: AppSpacing.x1),
            AppButton.secondary(
              title: 'Call 112',
              icon: Icons.call_outlined,
              onPressed: onCall112,
            ),
          ],
        ),
      ),
    );
  }
}
