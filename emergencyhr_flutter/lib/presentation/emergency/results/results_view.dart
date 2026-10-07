import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/route_args.dart';
import '../components/results_header.dart';
import 'results_viewmodel.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key, this.args});

  final EmergencyResultsArgs? args;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResultsViewModel>.reactive(
      viewModelBuilder: () => ResultsViewModel(args: args),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final p = context.palette;
        final header = ResultsHeader(
          title: ResultsViewModel.title,
          locationValue: model.locationValue,
          typeValue: model.typeValue,
          typeSelected: model.typeSelected,
          onBack: model.back,
          onLocation: model.chooseArea,
          onType: model.chooseType,
        );
        final call112Footer = PageFooter(
          child: AppButton.secondary(
            title: 'Call 112',
            icon: Icons.call_outlined,
            size: AppButtonSize.medium,
            onPressed: model.call112,
          ),
        );
        final hiddenToggle = AppButton.text(
          title: model.hiddenToggleLabel,
          color: p.textSecondary,
          onPressed: model.toggleHidden,
        );

        Widget list(List<Widget> children) => RefreshIndicator(
          onRefresh: model.refresh,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSizes.contentMaxWidth,
                  ),
                  child: SectionColumn(
                    gap: AppSpacing.small,
                    children: [
                      if (model.isOffline)
                        NoticeBanner(
                          message: model.offlineNotice,
                          icon: Icons.cloud_off_outlined,
                        ),
                      ...children,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        final (Widget body, Widget? footer) = switch (model.state) {
          ResultsState.loading => (
            const _LoadingList(label: ResultsViewModel.loadingLabel),
            call112Footer,
          ),
          ResultsState.failed => (
            _Message(
              icon: Icons.wifi_off_rounded,
              critical: true,
              title: ResultsViewModel.failedTitle,
              message: ResultsViewModel.failedMessage,
              actions: [
                AppButton.danger(
                  title: 'Call 112',
                  onPressed: model.call112,
                ),
                AppButton.secondary(
                  title: 'Try again',
                  onPressed: model.retry,
                ),
              ],
            ),
            null,
          ),
          ResultsState.empty => (
            _Message(
              icon: Icons.search_off_rounded,
              title: ResultsViewModel.emptyTitle,
              message: ResultsViewModel.emptyMessage,
              actions: [
                AppButton.danger(
                  title: 'Call 112',
                  onPressed: model.call112,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppButton.text(
                    title: 'Choose a different area',
                    onPressed: model.chooseArea,
                  ),
                ),
              ],
            ),
            null,
          ),
          ResultsState.nothingAccepting => (
            list([
              AlertCard(
                message: ResultsViewModel.call112Notice,
                actions: [
                  AppButton.danger(
                    title: 'Call 112',
                    icon: Icons.call_outlined,
                    size: AppButtonSize.extraLarge,
                    onPressed: model.call112,
                  ),
                ],
              ),
              AppListCard(
                children: [
                  for (final row in model.allRows)
                    HospitalCompactRow(
                      name: row.name,
                      distanceLabel: row.distance,
                      statusLabel: row.status,
                      statusTone: row.tone,
                      onTap: row.onTap,
                      onCall: row.onCall,
                    ),
                ],
              ),
              if (model.hasHidden) Center(child: hiddenToggle),
            ]),
            null,
          ),
          ResultsState.results => (
            list([
              AppText.caption(model.summary),
              for (final row in model.allRows)
                HospitalListTile(
                  name: row.name,
                  distanceLabel: row.distance,
                  statusLabel: row.status,
                  statusTone: row.tone,
                  metrics: row.metrics,
                  capabilities: row.capabilities,
                  footnote: row.footnote,
                  onTap: row.onTap,
                  onCall: row.onCall,
                  onDirections: row.onDirections,
                ),
            ]),
            PageFooter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (model.hasHidden) Center(child: hiddenToggle),
                  AppButton.secondary(
                    title: 'Call 112',
                    icon: Icons.call_outlined,
                    size: AppButtonSize.medium,
                    onPressed: model.call112,
                  ),
                ],
              ),
            ),
          ),
        };

        return Scaffold(
          appBar: header,
          body: SafeArea(bottom: footer == null, child: body),
          bottomNavigationBar: footer,
        );
      },
    );
  }
}

/// Spinner with a label, then two placeholder hospital cards.
class _LoadingList extends StatelessWidget {
  const _LoadingList({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget bar(double height, double? factor, Color color, double radius) {
      final box = Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
      return factor == null
          ? box
          : FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: factor,
              child: box,
            );
    }

    Widget card(double first, double second) => AppCard(
      child: SectionColumn(
        gap: AppSpacing.small,
        children: [
          bar(16, first, p.divider, 8),
          bar(12, second, p.divider, 6),
          bar(34, null, p.primaryContainer, 8),
          bar(44, null, p.primaryContainer, 10),
        ],
      ),
    );

    return Semantics(
      liveRegion: true,
      label: label,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.contentMaxWidth,
              ),
              child: SectionColumn(
                gap: AppSpacing.small,
                children: [
                  Row(
                    children: [
                      const AppLoader(size: 22),
                      const SizedBox(width: AppSpacing.small),
                      Expanded(child: AppText.subtitle(label)),
                    ],
                  ),
                  card(0.6, 0.4),
                  card(0.7, 0.35),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Failed and none-found: round icon, 22 px heading, text and actions.
class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    required this.message,
    required this.actions,
    this.critical = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final List<Widget> actions;
  final bool critical;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: critical ? p.criticalBg : p.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: critical ? p.critical : p.primaryText,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.x2),
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: AppTypography.heading.copyWith(
                    fontSize: 22,
                    height: 28 / 22,
                    color: p.text,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.x2),
              AppText(message, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x3),
              SectionColumn(gap: AppSpacing.tight, children: actions),
            ],
          ),
        ),
      ),
    );
  }
}
