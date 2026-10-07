import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'type_filter_viewmodel.dart';

class TypeFilterView extends StatelessWidget {
  const TypeFilterView({super.key, required this.current});

  final EmergencyType current;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TypeFilterViewModel>.nonReactive(
      viewModelBuilder: () => TypeFilterViewModel(current: current),
      builder: (context, model, _) => AppPage(
        title: TypeFilterViewModel.title,
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Close',
          onPressed: model.close,
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.half,
          AppSpacing.screen,
          AppSpacing.screen,
        ),
        bottom: AppButton(
          title: 'Show all hospitals',
          onPressed: model.showAll,
        ),
        body: SectionColumn(
          gap: AppSpacing.x2,
          children: [
            const AppText(
              TypeFilterViewModel.hint,
              tone: AppTextTone.secondary,
            ),
            _AllTypesCard(selected: model.allSelected, onTap: model.showAll),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.tight,
                crossAxisSpacing: AppSpacing.tight,
                mainAxisExtent: 112,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final o in model.options)
                  _TypeTile(
                    label: o.label,
                    icon: o.icon,
                    selected: o.selected,
                    onTap: o.onTap,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AllTypesCard extends StatelessWidget {
  const _AllTypesCard({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return _SelectableCard(
      selected: selected,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: selected ? p.primary : p.surface,
              shape: BoxShape.circle,
              border: selected
                  ? null
                  : Border.all(color: p.inputBorder, width: 2),
            ),
            child: selected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: AppSpacing.small),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subtitle(TypeFilterViewModel.allTitle),
                AppText.caption(TypeFilterViewModel.allSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeTile extends StatelessWidget {
  const _TypeTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return _SelectableCard(
      selected: selected,
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.small),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppSizes.tapTarget,
            height: AppSizes.tapTarget,
            decoration: BoxDecoration(
              color: p.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: p.primaryText),
          ),
          const SizedBox(height: AppSpacing.tight),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyStrong.copyWith(
              fontSize: 13,
              height: 17 / 13,
              color: p.text,
            ),
          ),
        ],
      ),
    );
  }
}

/// A card that shows a 2 px primary border and a light fill when selected.
class _SelectableCard extends StatelessWidget {
  const _SelectableCard({
    required this.selected,
    required this.onTap,
    required this.padding,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.card),
      side: BorderSide(
        color: selected ? p.primary : p.border,
        width: selected ? 2 : 1,
      ),
    );
    return Semantics(
      button: true,
      selected: selected,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: p.cardShadows,
        ),
        child: Material(
          color: selected ? p.primarySelected : p.surface,
          shape: shape,
          child: InkWell(
            onTap: onTap,
            customBorder: shape,
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}
