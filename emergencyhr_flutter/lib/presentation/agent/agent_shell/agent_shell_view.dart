import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../agent_facilities/agent_facilities_view.dart';
import '../onboard_start/onboard_start_view.dart';
import 'agent_shell_viewmodel.dart';

class AgentShellView extends StatelessWidget {
  const AgentShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgentShellViewModel>.reactive(
      viewModelBuilder: AgentShellViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        if (!model.isReady) return const Scaffold(body: LoadingState());
        return AppShell(
          title: AgentShellViewModel.title,
          destinations: AgentShellViewModel.destinations,
          selectedIndex: model.selectedIndex,
          onSelect: model.select,
          onHome: model.goHome,
          body: switch (model.currentTab) {
            AgentTab.onboard => const OnboardStartView(),
            AgentTab.facilities => const AgentFacilitiesView(),
          },
        );
      },
    );
  }
}
