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
      builder: (context, model, _) => WebPageState(
        isLoading: model.isLoading,
        error: model.hasError ? model.errorMessage : null,
        onRetry: model.load,
        child: WebPage(
          title: 'Pipeline',
          subtitle: model.targetLabel,
          onRefresh: model.load,
          children: [
            Wrap(
              spacing: AppSpacing.tight,
              runSpacing: AppSpacing.tight,
              children: [
                for (final c in model.stageCounts)
                  CountTile(label: c.label, value: c.value),
              ],
            ),
            Wrap(
              spacing: AppSpacing.tight,
              runSpacing: AppSpacing.tight,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ToolbarSelect<String>(
                  semanticsLabel: 'Area',
                  value: model.area,
                  options: model.areaOptions,
                  onChanged: model.setArea,
                ),
                ToolbarSelect<int?>(
                  semanticsLabel: 'Agent',
                  value: model.agentId,
                  options: model.agentOptions,
                  onChanged: model.setAgent,
                ),
                if (model.hasSelection) ...[
                  AppText(
                    model.selectionLabel,
                    variant: AppTextVariant.caption,
                    tone: AppTextTone.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  AppButton(
                    title: 'Assign to agent',
                    size: AppButtonSize.medium,
                    expand: false,
                    onPressed: model.assignSelected,
                  ),
                ],
              ],
            ),
            DataTableCard(
              columns: const [
                TableColumn('', width: 32),
                TableColumn('Hospital', flex: 20),
                TableColumn('Stage · agent', flex: 14),
                TableColumn('Next action', flex: 10),
                TableColumn('Checklist', width: 110),
              ],
              rows: [
                for (final row in model.rows)
                  [
                    SizedBox.square(
                      dimension: 20,
                      child: Checkbox(
                        value: row.selected,
                        semanticLabel: 'Select ${row.name}',
                        onChanged: (_) => model.toggle(row.id),
                      ),
                    ),
                    InkWell(
                      onTap: () => model.open(row.id),
                      child: NameCell(row.name, detail: row.area),
                    ),
                    AppText.small(row.stageAgent),
                    AppText.small(row.nextAction),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StatusBadge(
                        label: row.progress,
                        tone: row.progressTone,
                        dot: false,
                      ),
                    ),
                  ],
              ],
            ),
            if (model.hasMore)
              Center(
                child: AppButton.secondary(
                  title: 'Load more',
                  size: AppButtonSize.medium,
                  expand: false,
                  onPressed: model.loadMore,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
