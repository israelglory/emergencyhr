import 'package:flutter/material.dart';

import '../../../core/cores.dart';

/// White header of Hospitals near you: back, title, and the Location and
/// What happened buttons. [typeSelected] fills What happened with primary.
class ResultsHeader extends StatelessWidget implements PreferredSizeWidget {
  const ResultsHeader({
    super.key,
    required this.title,
    required this.locationValue,
    required this.typeValue,
    required this.typeSelected,
    required this.onBack,
    required this.onLocation,
    required this.onType,
  });

  final String title;
  final String locationValue;
  final String typeValue;
  final bool typeSelected;
  final VoidCallback onBack;
  final VoidCallback onLocation;
  final VoidCallback onType;

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.topBar + 66);

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surface,
      shape: Border(bottom: BorderSide(color: p.border)),
      child: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.contentMaxWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: AppSizes.topBar,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, size: 28),
                          tooltip: 'Back',
                          onPressed: onBack,
                        ),
                        const SizedBox(width: AppSpacing.half),
                        Expanded(
                          child: Semantics(
                            header: true,
                            child: AppText.title(title),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 2, 16, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: _FilterButton(
                          icon: Icons.place_outlined,
                          label: 'Location',
                          value: locationValue,
                          selected: false,
                          onTap: onLocation,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.x1),
                      Expanded(
                        child: _FilterButton(
                          icon: Icons.medical_services_outlined,
                          label: 'What happened',
                          value: typeValue,
                          selected: typeSelected,
                          onTap: onType,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.icon,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final fg = selected ? p.onPrimary : p.primaryText;
    final radius = BorderRadius.circular(14);
    return Semantics(
      button: true,
      label: '$label: $value',
      excludeSemantics: true,
      child: Material(
        color: selected ? p.primary : p.primaryContainer,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: SizedBox(
            height: AppSizes.buttonLarge,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: fg),
                  const SizedBox(width: AppSpacing.x1),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.micro.copyWith(
                            fontSize: 11,
                            height: 14 / 11,
                            fontWeight: FontWeight.w600,
                            color: fg.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.label.copyWith(
                            fontWeight: FontWeight.w700,
                            color: fg,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 18, color: fg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
