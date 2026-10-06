import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'pipeline_viewmodel.dart';

class PipelineView extends StatelessWidget {
  const PipelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PipelineViewModel>.reactive(
      viewModelBuilder: PipelineViewModel.new,
      onViewModelReady: (model) => model.load(),
      builder: (context, model, _) {
        if (model.isLoading) return const LoadingState();
        if (model.hasError) {
          return ErrorState(message: model.errorMessage!, onRetry: model.load);
        }
        return ShellPageFrame(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.x2),
            children: [
              AppText.title(model.targetLabel),
              const SizedBox(height: AppSpacing.x1),
              Wrap(
                spacing: AppSpacing.x1,
                runSpacing: AppSpacing.x1,
                children: [
                  for (final c in model.stageCounts)
                    StatusBadge(label: c, tone: StatusTone.neutral),
                ],
              ),
              const SizedBox(height: AppSpacing.x2),
              Wrap(
                spacing: AppSpacing.x2,
                runSpacing: AppSpacing.x1,
                children: [
                  DropdownMenu<String>(
                    label: const Text('Area'),
                    initialSelection: model.area,
                    onSelected: model.setArea,
                    dropdownMenuEntries: [
                      for (final a in model.areaOptions)
                        DropdownMenuEntry(value: a, label: a),
                    ],
                  ),
                  DropdownMenu<int?>(
                    label: const Text('Agent'),
                    initialSelection: model.agentId,
                    onSelected: model.setAgent,
                    dropdownMenuEntries: [
                      for (final a in model.agentOptions)
                        DropdownMenuEntry(value: a.id, label: a.label),
                    ],
                  ),
                ],
              ),
              if (model.hasSelection) ...[
                const SizedBox(height: AppSpacing.x2),
                Row(
                  children: [
                    Expanded(child: AppText.label(model.selectionLabel)),
                    AppButton(
                      title: 'Assign to agent',
                      icon: Icons.assignment_ind_outlined,
                      expand: false,
                      onPressed: model.assignSelected,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.x2),
              for (final row in model.rows)
                Column(
                  children: [
                    InkWell(
                      onTap: () => model.open(row.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.x1,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: row.selected,
                              onChanged: (_) => model.toggle(row.id),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.label(row.name),
                                  AppText.caption(
                                    '${row.stage} · ${row.agent}',
                                  ),
                                  if (row.nextAction != null)
                                    AppText.caption(row.nextAction!),
                                ],
                              ),
                            ),
                            StatusBadge(
                              label: row.progress,
                              tone: StatusTone.neutral,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
