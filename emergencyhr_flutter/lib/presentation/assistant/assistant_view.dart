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
        final wide = WindowSize.of(context).isExpanded;
        final emergency = Padding(
          padding: const EdgeInsets.only(right: AppSpacing.small),
          child: Center(
            child: AppButton.danger(
              title: 'Emergency',
              size: AppButtonSize.small,
              expand: false,
              onPressed: model.startEmergency,
            ),
          ),
        );
        if (!model.isSignedIn) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: AppSpacing.screen,
              title: const AppText.title(AssistantViewModel.title),
              actions: [emergency],
            ),
            body: SafeArea(
              child: _Centred(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: IconTile(
                        Icons.chat_bubble_outline,
                        size: 52,
                        circle: true,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _Heading(AssistantViewModel.signedOutTitle),
                    const SizedBox(height: 14),
                    const AppText(
                      AssistantViewModel.signedOutMessage,
                      tone: AppTextTone.secondary,
                    ),
                    const SizedBox(height: 14),
                    AppButton(title: 'Sign in', onPressed: model.signIn),
                  ],
                ),
              ),
            ),
          );
        }
        final history = _History(model: model, inDrawer: !wide);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: wide
                ? null
                : Builder(
                    builder: (context) => IconButton(
                      tooltip: 'Conversations',
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
            titleSpacing: wide ? AppSpacing.screen : 4,
            title: const AppText.title(AssistantViewModel.title),
            actions: [
              if (!model.isEmpty)
                IconButton(
                  tooltip: 'New conversation',
                  icon: const Icon(Icons.edit_square),
                  onPressed: model.newConversation,
                ),
              emergency,
            ],
          ),
          drawer: wide ? null : Drawer(width: 320, child: history),
          body: SafeArea(
            child: wide
                ? Row(
                    children: [
                      SizedBox(width: 320, child: history),
                      VerticalDivider(width: 1, color: context.palette.border),
                      Expanded(child: _Chat(model: model)),
                    ],
                  )
                : _Chat(model: model),
          ),
        );
      },
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(
        text,
        style: AppTypography.heading.copyWith(
          fontSize: 22,
          height: 28 / 22,
          color: context.palette.text,
        ),
      ),
    );
  }
}

class _Centred extends StatelessWidget {
  const _Centred({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.x3),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}

class _History extends StatelessWidget {
  const _History({required this.model, required this.inDrawer});

  final AssistantViewModel model;
  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: AppSizes.tapTarget,
              child: Row(
                children: [
                  const Expanded(child: AppText.title('Conversations')),
                  if (inDrawer)
                    IconButton(
                      tooltip: 'Close',
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.x1),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  if (!model.hasConversations)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.x1),
                      child: AppText(
                        'No conversations yet.',
                        tone: AppTextTone.secondary,
                      ),
                    ),
                  for (final c in model.conversations)
                    Container(
                      margin: const EdgeInsets.only(right: AppSpacing.x1),
                      decoration: BoxDecoration(
                        color: c.selected ? p.background : null,
                        borderRadius: c.selected
                            ? BorderRadius.circular(AppRadius.mediumButton)
                            : null,
                        border: c.selected
                            ? null
                            : Border(bottom: BorderSide(color: p.divider)),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (inDrawer) Navigator.of(context).maybePop();
                          model.openConversation(c.id);
                        },
                        borderRadius: BorderRadius.circular(
                          AppRadius.mediumButton,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.subtitle(c.title, maxLines: 2),
                                    AppText.caption(c.updated),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Delete conversation',
                                color: p.textSecondary,
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => model.deleteConversation(c.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.small,
                right: AppSpacing.x1,
              ),
              child: AppButton.secondary(
                title: 'New conversation',
                size: AppButtonSize.medium,
                onPressed: () {
                  if (inDrawer) Navigator.of(context).maybePop();
                  model.newConversation();
                },
              ),
            ),
            const Spacer(),
            if (model.hasConversations)
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton.text(
                  title: 'Delete all conversations',
                  color: p.critical,
                  onPressed: model.deleteAll,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({required this.model});

  final AssistantViewModel model;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: p.neutralBg,
            borderRadius: BorderRadius.circular(AppRadius.status),
          ),
          child: Text(
            AssistantViewModel.disclaimer,
            style: AppTypography.micro.copyWith(
              height: 17 / 12,
              color: p.neutral,
            ),
          ),
        ),
        Expanded(
          child: model.isEmpty
              ? const _Centred(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Heading('How can I help?'),
                      SizedBox(height: AppSpacing.tight),
                      AppText(
                        AssistantViewModel.emptyHint,
                        tone: AppTextTone.secondary,
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  controller: model.scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  itemCount: model.items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.small),
                  itemBuilder: (context, i) => switch (model.items[i]) {
                    final ChatText item => ChatBubble(
                      text: item.text,
                      fromUser: item.fromUser,
                      pending: item.pending,
                    ),
                    final ChatRedFlag item => RedFlagCard(
                      title: item.title,
                      message: item.message,
                      onFindCare: model.findCare,
                      onCall112: model.call112,
                    ),
                  },
                ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: p.surface,
            border: Border(top: BorderSide(color: p.border)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'Type your question',
                    semanticsLabel: 'Type your question',
                    rounded: true,
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
                  style: IconButton.styleFrom(
                    backgroundColor: p.primary,
                    foregroundColor: p.onPrimary,
                    disabledBackgroundColor: p.disabledBg,
                    disabledForegroundColor: p.textSecondary,
                  ),
                  constraints: const BoxConstraints.tightFor(
                    width: AppSizes.tapTarget,
                    height: AppSizes.tapTarget,
                  ),
                  icon: const Icon(Icons.arrow_upward, size: 22),
                  onPressed: model.onSend,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
