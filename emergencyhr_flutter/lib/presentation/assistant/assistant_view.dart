import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import 'assistant_viewmodel.dart';
import 'components/chat_bubble.dart';

class AssistantView extends StatelessWidget {
  const AssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssistantViewModel>.reactive(
      viewModelBuilder: AssistantViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final emergencyAction = Padding(
          padding: const EdgeInsets.only(right: AppSpacing.x1),
          child: AppButton.danger(
            title: 'Emergency',
            icon: Icons.emergency_outlined,
            expand: false,
            onPressed: model.startEmergency,
          ),
        );
        if (!model.isSignedIn) {
          return AppPage(
            title: AssistantViewModel.title,
            scrollable: false,
            actions: [emergencyAction],
            body: EmptyState(
              icon: Icons.chat_bubble_outline,
              title: AssistantViewModel.signedOutTitle,
              message: AssistantViewModel.signedOutMessage,
              actionLabel: 'Sign in',
              onAction: model.signIn,
            ),
          );
        }
        final history = _History(model: model);
        final chat = _Chat(model: model);
        final wide = WindowSize.of(context).isExpanded;
        return Scaffold(
          appBar: AppBar(
            title: const AppText.title(AssistantViewModel.title),
            actions: [
              IconButton(
                tooltip: 'New conversation',
                icon: const Icon(Icons.add_comment_outlined),
                onPressed: model.newConversation,
              ),
              emergencyAction,
            ],
          ),
          drawer: wide ? null : Drawer(child: SafeArea(child: history)),
          body: SafeArea(
            child: wide
                ? Row(
                    children: [
                      SizedBox(width: 300, child: history),
                      const VerticalDivider(width: 1),
                      Expanded(child: chat),
                    ],
                  )
                : chat,
          ),
        );
      },
    );
  }
}

class _History extends StatelessWidget {
  const _History({required this.model});

  final AssistantViewModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.x2),
      children: [
        const SectionHeader('Conversations'),
        if (!model.hasConversations)
          const AppText('No conversations yet.', tone: AppTextTone.secondary),
        for (final c in model.conversations)
          ListTile(
            selected: c.selected,
            contentPadding: EdgeInsets.zero,
            title: AppText.label(c.title, maxLines: 2),
            subtitle: AppText.caption(c.updated),
            onTap: () => model.openConversation(c.id),
            trailing: IconButton(
              tooltip: 'Delete conversation',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => model.deleteConversation(c.id),
            ),
          ),
        if (model.hasConversations) ...[
          const SizedBox(height: AppSpacing.x2),
          AppButton.text(
            title: 'Delete all conversations',
            icon: Icons.delete_sweep_outlined,
            onPressed: model.deleteAll,
          ),
        ],
      ],
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({required this.model});

  final AssistantViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.x2,
            AppSpacing.x1,
            AppSpacing.x2,
            0,
          ),
          child: const NoticeBanner(message: AssistantViewModel.disclaimer),
        ),
        Expanded(
          child: model.isEmpty
              ? const EmptyState(
                  icon: Icons.chat_bubble_outline,
                  title: 'How can I help?',
                  message: AssistantViewModel.emptyHint,
                )
              : ListView.builder(
                  controller: model.scrollController,
                  padding: const EdgeInsets.all(AppSpacing.x2),
                  itemCount: model.items.length,
                  itemBuilder: (context, i) => switch (model.items[i]) {
                    final ChatText item => ChatBubble(
                      text: item.text,
                      fromUser: item.fromUser,
                      pending: item.pending,
                    ),
                    final ChatRedFlag item => RedFlagCard(
                      title: item.title,
                      message: item.message,
                      onFindCare: () => model.findCare(item.type),
                      onCall112: model.call112,
                    ),
                  },
                ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.x2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AppTextField(
                  hintText: 'Type your question',
                  controller: model.inputController,
                  maxLines: 4,
                  minLines: 1,
                  maxLength: 2000,
                  textInputAction: TextInputAction.send,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => model.send(),
                ),
              ),
              const SizedBox(width: AppSpacing.x1),
              IconButton.filled(
                tooltip: 'Send',
                iconSize: 24,
                constraints: const BoxConstraints.tightFor(
                  width: AppSizes.tapTarget,
                  height: AppSizes.tapTarget,
                ),
                icon: const Icon(Icons.send),
                onPressed: model.onSend,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
