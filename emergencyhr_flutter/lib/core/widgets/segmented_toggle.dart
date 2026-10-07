import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_button.dart';
import 'status_badge.dart';

/// Two-way choice on a grey track, e.g. Accepting / Paused. The selected
/// side is filled with its status colour and always labelled.
class SegmentedToggle extends StatelessWidget {
  const SegmentedToggle({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftSelected,
    required this.onChanged,
    this.leftTone = StatusTone.positive,
    this.rightTone = StatusTone.neutral,
    this.leftIcon,
    this.rightIcon,
    this.height = AppSizes.buttonMedium,
    this.large = false,
  });

  final String leftLabel;
  final String rightLabel;
  final bool leftSelected;

  /// Called with true when the left side is chosen.
  final ValueChanged<bool>? onChanged;
  final StatusTone leftTone;
  final StatusTone rightTone;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double height;

  /// The desk version: 56 high, 16 / 700 labels, 14 radius track.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final h = large ? 56.0 : height;
    Color fill(StatusTone tone) => switch (tone) {
      StatusTone.positive => p.positive,
      StatusTone.warning => p.warning,
      StatusTone.critical => p.critical,
      StatusTone.neutral || StatusTone.unverified => p.textStrong,
    };

    Widget side(
      String label,
      bool selected,
      StatusTone tone,
      IconData? icon,
      bool value,
    ) {
      final fg = selected ? Colors.white : p.textStrong;
      return Expanded(
        child: Semantics(
          button: true,
          selected: selected,
          label: label,
          excludeSemantics: true,
          child: Material(
            color: selected ? fill(tone) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              large ? AppRadius.control : AppRadius.mediumButton,
            ),
            child: InkWell(
              onTap: onChanged == null ? null : () => onChanged!(value),
              borderRadius: BorderRadius.circular(
                large ? AppRadius.control : AppRadius.mediumButton,
              ),
              child: SizedBox(
                height: h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18, color: fg),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      label,
                      style: AppTypography.bodyStrong.copyWith(
                        color: fg,
                        fontSize: large ? 16 : 15,
                        fontWeight: large ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: p.segmentTrack,
        borderRadius: BorderRadius.circular(large ? 14 : AppRadius.control),
      ),
      child: Row(
        children: [
          side(leftLabel, leftSelected, leftTone, leftIcon, true),
          side(rightLabel, !leftSelected, rightTone, rightIcon, false),
        ],
      ),
    );
  }
}

/// A segmented picker on a grey track; the selected segment is white with
/// a border, e.g. hospital Type: Public / Private / Mission.
class SegmentPicker<T> extends StatelessWidget {
  const SegmentPicker({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<({String label, T value, bool selected})> items;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: p.segmentTrack,
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: Semantics(
                button: true,
                selected: item.selected,
                label: item.label,
                excludeSemantics: true,
                child: Material(
                  color: item.selected ? p.surface : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    side: item.selected
                        ? BorderSide(color: p.border)
                        : BorderSide.none,
                  ),
                  child: InkWell(
                    onTap: () => onSelected(item.value),
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          item.label,
                          style: AppTypography.bodyStrong.copyWith(
                            color: item.selected ? p.text : p.textStrong,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Seven day buttons; selected days are filled with primary.
class DayPicker extends StatelessWidget {
  const DayPicker({super.key, required this.items, required this.onToggle});

  final List<({String label, int value, bool selected})> items;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      children: [
        for (final (i, d) in items.indexed) ...[
          if (i > 0) const SizedBox(width: AppSpacing.half),
          Expanded(
            child: Semantics(
              button: true,
              selected: d.selected,
              label: d.label,
              excludeSemantics: true,
              child: Material(
                color: d.selected ? p.primary : p.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.mediumButton),
                  side: BorderSide(
                    color: d.selected ? p.primary : p.inputBorder,
                  ),
                ),
                child: InkWell(
                  onTap: () => onToggle(d.value),
                  borderRadius: BorderRadius.circular(AppRadius.mediumButton),
                  child: SizedBox(
                    height: AppSizes.tapTarget,
                    child: Center(
                      child: Text(
                        d.label,
                        style: AppTypography.meta.copyWith(
                          fontWeight: FontWeight.w600,
                          color: d.selected ? p.onPrimary : p.text,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Checkboxes in two columns inside a card, e.g. hospital capabilities.
class CheckboxGrid<T> extends StatelessWidget {
  const CheckboxGrid({
    super.key,
    required this.items,
    required this.onToggle,
  });

  final List<({String label, T value, bool selected})> items;
  final ValueChanged<T> onToggle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: p.surface,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: p.cardShadows,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = (constraints.maxWidth - AppSpacing.x1) / 2;
          return Wrap(
            spacing: AppSpacing.x1,
            children: [
              for (final item in items)
                SizedBox(
                  width: width,
                  child: MergeSemantics(
                    child: InkWell(
                      onTap: () => onToggle(item.value),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: AppSizes.tapTarget,
                        ),
                        child: Row(
                          children: [
                            SizedBox.square(
                              dimension: 20,
                              child: Checkbox(
                                value: item.selected,
                                onChanged: (_) => onToggle(item.value),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.tight),
                            Expanded(
                              child: Text(
                                item.label,
                                style: AppTypography.body.copyWith(
                                  color: p.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// A small Yes / No pill: Yes filled with primary, No white with a border.
class YesNoButton extends StatelessWidget {
  const YesNoButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticsLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      toggled: value,
      label: semanticsLabel,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 72),
        child: AppButton(
          title: value ? 'Yes' : 'No',
          variant: value
              ? AppButtonVariant.primary
              : AppButtonVariant.secondary,
          size: AppButtonSize.small,
          expand: false,
          color: p.text,
          onPressed: onChanged == null ? null : () => onChanged!(!value),
        ),
      ),
    );
  }
}

/// One-of-many choices as radio rows with dividers, e.g. report reasons.
/// [inCard] puts the rows in a card (padding 16) instead of flush rows.
class RadioOptionList<T> extends StatelessWidget {
  const RadioOptionList({
    super.key,
    required this.items,
    required this.onSelected,
    this.inCard = false,
  });

  final List<({String label, T value, bool selected})> items;
  final ValueChanged<T> onSelected;
  final bool inCard;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final selected = items.where((i) => i.selected).firstOrNull?.value;
    Widget row(({String label, T value, bool selected}) item, bool last) {
      return InkWell(
        onTap: () => onSelected(item.value),
        child: Container(
          constraints: BoxConstraints(minHeight: inCard ? 52 : 46),
          padding: EdgeInsets.symmetric(horizontal: inCard ? 16 : 4),
          decoration: BoxDecoration(
            border: last ? null : Border(bottom: BorderSide(color: p.divider)),
          ),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 20,
                child: Radio<T>(
                  value: item.value,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: Text(
                  item.label,
                  style: AppTypography.body.copyWith(color: p.text),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final rows = RadioGroup<T>(
      groupValue: selected,
      onChanged: (v) {
        if (v != null) onSelected(v);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, item) in items.indexed)
            row(item, i == items.length - 1),
        ],
      ),
    );
    if (!inCard) return rows;
    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: p.cardShadows,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: rows,
      ),
    );
  }
}
