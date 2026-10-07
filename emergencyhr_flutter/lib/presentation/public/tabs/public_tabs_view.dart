import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../assistant/assistant_view.dart';
import '../../profile/profile_view.dart';
import '../home/home_view.dart';
import 'public_tabs_viewmodel.dart';

class PublicTabsView extends StatelessWidget {
  const PublicTabsView({super.key, this.initial = PublicTab.home});

  final PublicTab initial;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PublicTabsViewModel>.reactive(
      viewModelBuilder: () => PublicTabsViewModel(initial: initial),
      builder: (context, model, _) => Scaffold(
        body: IndexedStack(
          index: model.index,
          children: [
            const HomeView(),
            if (model.isOpened(PublicTab.assistant))
              const AssistantView()
            else
              const SizedBox.shrink(),
            if (model.isOpened(PublicTab.profile))
              const ProfileView()
            else
              const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: AppTabBar(
          items: PublicTabsViewModel.items,
          selectedIndex: model.index,
          onSelect: model.select,
        ),
      ),
    );
  }
}
