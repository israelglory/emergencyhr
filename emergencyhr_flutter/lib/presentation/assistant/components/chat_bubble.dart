import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// One chat message. User messages sit right in blue, replies left in
/// white with a border.
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
    const r = Radius.circular(16);
    const tail = Radius.circular(4);
    return LayoutBuilder(
      builder: (context, constraints) => Align(
        alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * (fromUser ? 0.8 : 0.88),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: fromUser ? p.primary : p.surface,
              border: fromUser ? null : Border.all(color: p.border),
              borderRadius: BorderRadius.only(
                topLeft: r,
                topRight: r,
                bottomLeft: fromUser ? r : tail,
                bottomRight: fromUser ? tail : r,
              ),
            ),
            child: pending && text.isEmpty
                ? const AppLoader(size: 16)
                : SelectableText(
                    text,
                    style: AppTypography.body.copyWith(
                      color: fromUser ? p.onPrimary : p.text,
                      height: (fromUser ? 21 : 22) / 15,
                    ),
                  ),
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
    return AlertCard(
      title: title,
      message: message,
      actions: [
        AppButton.danger(
          title: 'Find emergency care now',
          size: AppButtonSize.medium,
          onPressed: onFindCare,
        ),
        AppButton.secondary(
          title: 'Call 112',
          size: AppButtonSize.medium,
          onPressed: onCall112,
        ),
      ],
    );
  }
}
