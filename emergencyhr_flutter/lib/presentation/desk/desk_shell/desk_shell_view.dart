import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../facility/setup/facility_setup_view.dart';
import '../audit_log/audit_log_view.dart';
import '../staff/staff_view.dart';
import '../status/status_view.dart';
import 'desk_shell_viewmodel.dart';

class DeskShellView extends StatelessWidget {
  const DeskShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeskShellViewModel>.reactive(
      viewModelBuilder: DeskShellViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        if (!model.isReady) {
          return const Scaffold(body: LoadingState());
        }
        final id = model.facilityId!;
        return AppShell(
          title: model.title,
          subtitle: DeskShellViewModel.subtitle,
          destinations: model.destinations,
          selectedIndex: model.selectedIndex,
          onSelect: model.select,
          actions: [
            if (model.showFacilitySwitcher)
              PopupMenuButton<int>(
                tooltip: 'Switch hospital',
                icon: const Icon(Icons.swap_horiz),
                onSelected: model.selectFacility,
                itemBuilder: (_) => [
                  for (final f in model.facilityOptions)
                    CheckedPopupMenuItem(
                      value: f.id,
                      checked: f.selected,
                      child: Text(f.name),
                    ),
                ],
              ),
            IconButton(
              tooltip: 'Public home',
              icon: const Icon(Icons.home_outlined),
              onPressed: model.goHome,
            ),
          ],
          body: KeyedSubtree(
            key: ValueKey('${model.currentTab}-$id'),
            child: switch (model.currentTab) {
              DeskTab.status => StatusView(facilityId: id),
              DeskTab.audit => AuditLogView(facilityId: id),
              DeskTab.staff => StaffView(facilityId: id),
              DeskTab.hospital => FacilitySetupView(facilityId: id),
            },
          ),
        );
      },
    );
  }
}
