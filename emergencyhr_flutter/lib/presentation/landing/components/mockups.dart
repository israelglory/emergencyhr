import 'package:flutter/material.dart';

import '../../../core/cores.dart';

// Illustrations from the design. Names and figures are fictional; they are
// pictures, so screen readers get one short description instead.

/// The phone in the hero, showing Hospitals near you.
class PhoneMockup extends StatelessWidget {
  const PhoneMockup({super.key});

  static const _rows = [
    (
      'Harbour Point Hospital',
      '9 min',
      'Accepting. Confirmed 4 min ago.',
      StatusTone.positive,
      true,
    ),
    (
      'Crestview Medical Centre',
      '12 min',
      'Last confirmed 45 min ago. Call ahead.',
      StatusTone.warning,
      true,
    ),
    (
      'Lakeside General Hospital',
      '4 min',
      'Unverified. Call before going.',
      StatusTone.neutral,
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget pill(String label) => Container(
      height: 38,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: p.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTypography.micro.copyWith(
          fontWeight: FontWeight.w700,
          color: p.primaryText,
        ),
      ),
    );
    Widget fakeButton(String label, bool primary) => Container(
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary ? p.primary : null,
        border: primary ? null : Border.all(color: p.inputBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTypography.micro.copyWith(
          fontWeight: FontWeight.w600,
          color: primary ? p.onPrimary : p.text,
        ),
      ),
    );

    final phone = Container(
      width: 320,
      height: 640,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(44),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2E101828),
            offset: Offset(0, 30),
            blurRadius: 60,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: ColoredBox(
          color: p.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
                decoration: BoxDecoration(
                  color: p.surface,
                  border: Border(bottom: BorderSide(color: p.border)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Hospitals near you',
                      style: AppTypography.title.copyWith(
                        fontSize: 16,
                        color: p.text,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tight),
                    Row(
                      children: [
                        Expanded(child: pill('Near you')),
                        const SizedBox(width: 6),
                        Expanded(child: pill('All types')),
                      ],
                    ),
                  ],
                ),
              ),
              // The screen clips anything taller, like the design.
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      for (final (i, r) in _rows.indexed) ...[
                        if (i > 0) const SizedBox(height: AppSpacing.tight),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: p.surface,
                            border: Border.all(color: p.border),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      r.$1,
                                      style: AppTypography.meta.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: p.text,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    r.$2,
                                    style: AppTypography.micro.copyWith(
                                      color: p.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.x1),
                              StatusLabel(
                                label: r.$3,
                                tone: r.$4,
                                fontSize: 11.5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                              ),
                              if (r.$5) ...[
                                const SizedBox(height: AppSpacing.x1),
                                Row(
                                  children: [
                                    Expanded(child: fakeButton('Call', true)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: fakeButton('Directions', false),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Semantics(
      image: true,
      label: 'The app showing hospitals near you',
      child: ExcludeSemantics(
        child: FittedBox(fit: BoxFit.scaleDown, child: phone),
      ),
    );
  }
}

/// The hospital desk card in the For hospitals section.
class DeskMockup extends StatelessWidget {
  const DeskMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget figure(String label, Widget value) => Row(
      children: [
        Expanded(child: AppText.subtitle(label)),
        value,
      ],
    );
    final big = AppTypography.title.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: p.text,
    );
    return Semantics(
      image: true,
      label: 'The hospital desk status screen',
      child: ExcludeSemantics(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SectionColumn(
            gap: AppSpacing.x2,
            children: [
              const Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSpacing.small,
                runSpacing: AppSpacing.x1,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.subtitle('Harbour Point Hospital'),
                      AppText.caption('Hospital desk'),
                    ],
                  ),
                  StatusBadge(
                    label: 'Updated 4 min ago',
                    tone: StatusTone.positive,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: p.segmentTrack,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: p.positive,
                          borderRadius: BorderRadius.circular(
                            AppRadius.control,
                          ),
                        ),
                        child: Text(
                          'Accepting',
                          style: AppTypography.bodyStrong.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Paused',
                          style: AppTypography.bodyStrong.copyWith(
                            color: p.textStrong,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              figure('ER beds free', Text('3', style: big)),
              figure('ICU beds free', Text('1', style: big)),
              figure(
                'Doctor on duty',
                const StatusBadge(
                  label: 'Yes',
                  tone: StatusTone.positive,
                  dot: false,
                ),
              ),
              Container(
                height: AppSizes.buttonLarge,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: p.primary,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
                child: Text(
                  'Still accurate',
                  style: AppTypography.bodyStrong.copyWith(color: p.onPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
