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
      builder: (context, model, _) {
        final goHome = AppButton.secondary(
          title: 'Go to home',
          onPressed: model.goHome,
        );
        return Scaffold(
          body: SafeArea(
            child: switch (model.state) {
              InviteScreenState.loading => const LoadingState(
                label: 'Checking invite',
              ),
              InviteScreenState.notFound => MessagePage(
                icon: Icons.link_off_rounded,
                title: AcceptInviteViewModel.notFoundTitle,
                message: AcceptInviteViewModel.notFoundMessage,
                children: [goHome],
              ),
              InviteScreenState.valid => MessagePage(
                icon: Icons.local_hospital_outlined,
                solidIcon: true,
                title: model.heading,
                message: model.message,
                children: [
                  AppListCard(
                    children: [
                      for (final d in model.details)
                        KeyValueRow(
                          label: d.label,
                          value: d.value,
                          inCard: true,
                        ),
                    ],
                  ),
                  AppButton(
                    title: model.actionLabel,
                    loading: model.isAccepting,
                    onPressed: model.accept,
                  ),
                ],
              ),
              InviteScreenState.unusable => MessagePage(
                icon: Icons.schedule_rounded,
                tone: IconTileTone.warning,
                title: AcceptInviteViewModel.unusableTitle,
                message: model.message,
                children: [goHome],
              ),
            },
          ),
        );
      },
    );
  }
}
