import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'accept_invite_viewmodel.dart';

class AcceptInviteView extends StatelessWidget {
  const AcceptInviteView({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AcceptInviteViewModel>.reactive(
      viewModelBuilder: () => AcceptInviteViewModel(code: code),
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) => AppPage(
        title: 'Invite',
        scrollable: false,
        body: switch (model.state) {
          InviteScreenState.loading => const LoadingState(
            label: 'Checking invite',
          ),
          InviteScreenState.notFound => ErrorState(
            title: 'Invite not found',
            message: model.errorMessage!,
            onRetry: model.goHome,
            retryLabel: 'Go to home',
          ),
          InviteScreenState.valid => EmptyState(
            icon: Icons.local_hospital_outlined,
            title: model.heading,
            message: model.message,
            actionLabel: model.actionLabel,
            onAction: model.accept,
          ),
          InviteScreenState.unusable => EmptyState(
            icon: Icons.link_off_outlined,
            title: 'This invite cannot be used',
            message: model.message,
            actionLabel: 'Go to home',
            onAction: model.goHome,
          ),
        },
      ),
    );
  }
}
