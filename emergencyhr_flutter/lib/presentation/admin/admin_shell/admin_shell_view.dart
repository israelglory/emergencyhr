import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../agents/agents_view.dart';
import '../claims/claims_view.dart';
import '../directory/directory_view.dart';
import '../freshness/freshness_view.dart';
import '../joins/joins_view.dart';
import '../metrics/metrics_view.dart';
import '../new_hospitals/new_hospitals_view.dart';
import '../pipeline/pipeline_view.dart';
import '../reports/reports_view.dart';
import '../users/users_view.dart';
import '../verification/verification_view.dart';
import 'admin_shell_viewmodel.dart';

class AdminShellView extends StatelessWidget {
  const AdminShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminShellViewModel>.reactive(
      viewModelBuilder: AdminShellViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        if (!model.isReady) return const Scaffold(body: LoadingState());
        return AppShell(
          title: AdminShellViewModel.title,
          subtitle: model.subtitle,
          destinations: model.destinations,
          selectedIndex: model.selectedIndex,
          onSelect: model.select,
          actions: [
            IconButton(
              tooltip: 'Public home',
              icon: const Icon(Icons.home_outlined),
              onPressed: model.goHome,
            ),
          ],
          body: KeyedSubtree(
            key: ValueKey(model.currentTab),
            child: switch (model.currentTab) {
              AdminTab.verification => const VerificationView(),
              AdminTab.pipeline => const PipelineView(),
              AdminTab.directory => const DirectoryView(),
              AdminTab.freshness => const FreshnessView(),
              AdminTab.reports => const ReportsView(),
              AdminTab.claims => const ClaimsView(),
              AdminTab.joins => const JoinsView(),
              AdminTab.agents => const AgentsView(),
              AdminTab.newHospitals => const NewHospitalsView(),
              AdminTab.metrics => const MetricsView(),
              AdminTab.users => const UsersView(),
            },
          ),
        );
      },
    );
  }
}
