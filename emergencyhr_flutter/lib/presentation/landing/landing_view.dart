import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import 'components/landing_buttons.dart';
import 'components/landing_layout.dart';
import 'components/mockups.dart';
import 'landing_content.dart';
import 'landing_viewmodel.dart';

typedef _C = LandingContent;

/// The web landing page at `/`. Phones and computers never see it. Always
/// light, as in the design, whatever the visitor's dark mode setting.
class LandingView extends StatelessWidget {
  const LandingView({super.key, this.initialSection});

  final LandingSection? initialSection;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: ViewModelBuilder<LandingViewModel>.reactive(
        viewModelBuilder: () =>
            LandingViewModel(initialSection: initialSection),
        onViewModelReady: (model) => model.onReady(),
        builder: (context, model, _) {
          final p = context.palette;
          return Scaffold(
            backgroundColor: p.background,
            body: SingleChildScrollView(
              controller: model.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(model: model),
                  _Hero(model: model),
                  const LandingFrame(
                    top: 80,
                    bottom: 40,
                    child: _ProblemAnswer(),
                  ),
                  KeyedSubtree(
                    key: model.sectionKeys[LandingSection.how],
                    child: const LandingFrame(
                      top: 64,
                      bottom: 40,
                      child: _How(),
                    ),
                  ),
                  const LandingFrame(top: 64, bottom: 40, child: _Trust()),
                  const LandingFrame(top: 64, bottom: 40, child: _Features()),
                  const SizedBox(height: 64),
                  KeyedSubtree(
                    key: model.sectionKeys[LandingSection.hospitals],
                    child: _ForHospitals(model: model),
                  ),
                  KeyedSubtree(
                    key: model.sectionKeys[LandingSection.areas],
                    child: LandingFrame(
                      top: 80,
                      bottom: 40,
                      child: _Areas(model: model),
                    ),
                  ),
                  KeyedSubtree(
                    key: model.sectionKeys[LandingSection.faq],
                    child: LandingFrame(
                      top: 64,
                      bottom: 40,
                      child: _Faq(model: model),
                    ),
                  ),
                  KeyedSubtree(
                    key: model.sectionKeys[LandingSection.app],
                    child: LandingFrame(
                      top: 64,
                      bottom: 80,
                      child: _AppCallToAction(model: model),
                    ),
                  ),
                  _Footer(model: model),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({this.fontSize = 19});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.logoMark,
          width: 32,
          height: 32,
          excludeFromSemantics: true,
        ),
        const SizedBox(width: AppSpacing.tight),
        Text(
          _C.appName,
          style: AppTypography.title.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
            color: context.palette.text,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final nav = Wrap(
      spacing: 24,
      runSpacing: 4,
      children: [
        for (final (label, section) in _C.navLinks)
          LandingLink(
            label: label,
            onTap: () => model.scrollTo(section),
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w500,
              color: p.textStrong,
            ),
          ),
      ],
    );
    final actions = Wrap(
      spacing: AppSpacing.tight,
      runSpacing: AppSpacing.x1,
      children: [
        AppButton.text(
          title: model.accountLabel,
          onPressed: model.openAccount,
        ),
        AppButton(
          title: 'Get the app',
          size: AppButtonSize.medium,
          expand: false,
          onPressed: model.getTheApp,
        ),
      ],
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(bottom: BorderSide(color: p.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: LandingFrame(
          top: 12,
          bottom: 12,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: LayoutBuilder(
              builder: (context, constraints) => constraints.maxWidth >= 860
                  ? Row(
                      children: [
                        const _Logo(),
                        const SizedBox(width: 24),
                        Expanded(child: nav),
                        const SizedBox(width: 24),
                        actions,
                      ],
                    )
                  : Wrap(
                      spacing: 24,
                      runSpacing: AppSpacing.small,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [const _Logo(), nav, actions],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // CSS clamp(38px, 5vw, 60px).
    final titleSize = (MediaQuery.sizeOf(context).width * 0.05).clamp(
      38.0,
      60.0,
    );
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 30),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: p.primaryContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: p.primaryText,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  _C.pilotBadge,
                  style: AppTypography.meta.copyWith(
                    fontWeight: FontWeight.w600,
                    color: p.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Semantics(
          header: true,
          child: Text(
            _C.heroTitle,
            style: AppTypography.heading.copyWith(
              fontSize: titleSize,
              height: 1.06,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
              color: p.text,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            _C.heroBody,
            style: LandingText.body(p.textSecondary, 19),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            LandingButton(
              title: _C.heroEmergency,
              icon: Icons.add_rounded,
              background: p.emergency,
              foreground: p.onEmergency,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              horizontalPadding: 28,
              shadow: p.emergencyShadows,
              onPressed: model.startEmergency,
            ),
            LandingButton(
              title: 'Call 112',
              icon: Icons.call_outlined,
              background: p.surface,
              foreground: p.text,
              border: p.inputBorder,
              onPressed: model.call112,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          _C.heroNote,
          style: AppTypography.bodySmall.copyWith(color: p.textSecondary),
        ),
      ],
    );
    return ColoredBox(
      color: p.surface,
      child: LandingFrame(
        top: 72,
        bottom: 80,
        child: FlexRow(
          gap: 56,
          items: [
            (basis: 480, flex: 1, child: text),
            (basis: 340, flex: 1, child: const Center(child: PhoneMockup())),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.cap,
    required this.title,
    required this.body,
    this.highlight = false,
  });

  final String cap;
  final String title;
  final String body;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      padding: const EdgeInsets.all(32),
      color: highlight ? p.primaryContainer : null,
      borderColor: highlight ? AppColors.primaryBorder : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caps(cap, color: highlight ? p.primaryText : null),
          const SizedBox(height: AppSpacing.small),
          Text(title, style: LandingText.heading(p.text, 26)),
          const SizedBox(height: AppSpacing.small),
          Text(
            body,
            style: LandingText.body(
              highlight ? p.textStrong : p.textSecondary,
              16,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProblemAnswer extends StatelessWidget {
  const _ProblemAnswer();

  @override
  Widget build(BuildContext context) {
    return const FlexRow(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      items: [
        (
          basis: 400,
          flex: 1,
          child: _InfoCard(
            cap: _C.problemCap,
            title: _C.problemTitle,
            body: _C.problemBody,
          ),
        ),
        (
          basis: 400,
          flex: 1,
          child: _InfoCard(
            cap: _C.answerCap,
            title: _C.answerTitle,
            body: _C.answerBody,
            highlight: true,
          ),
        ),
      ],
    );
  }
}

class _How extends StatelessWidget {
  const _How();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LandingHeading(cap: _C.howCap, title: _C.howTitle),
        const SizedBox(height: 32),
        FlexRow(
          gap: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          items: [
            for (final (i, (title, body)) in _C.steps.indexed)
              (
                basis: 260,
                flex: 1,
                child: AppCard(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: p.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${i + 1}',
                          style: AppTypography.bodyStrong.copyWith(
                            fontWeight: FontWeight.w800,
                            color: p.primaryText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(title, style: LandingText.cardTitle(p.text, 20)),
                      const SizedBox(height: 14),
                      Text(body, style: LandingText.body(p.textSecondary, 15)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Trust extends StatelessWidget {
  const _Trust();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      padding: const EdgeInsets.all(40),
      child: FlexRow(
        gap: 28,
        items: [
          (
            basis: 360,
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.caps(_C.trustCap, color: p.primaryText),
                const SizedBox(height: AppSpacing.small),
                Text(_C.trustTitle, style: LandingText.heading(p.text, 34)),
                const SizedBox(height: AppSpacing.small),
                Text(
                  _C.trustBody,
                  style: LandingText.body(p.textSecondary, 16),
                ),
              ],
            ),
          ),
          (
            basis: 420,
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (i, (label, tone)) in _C.statuses.indexed) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.tight),
                  StatusLabel(
                    label: label,
                    tone: tone,
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LandingHeading(cap: _C.featuresCap, title: _C.featuresTitle),
        const SizedBox(height: 32),
        AutoGrid(
          minItemWidth: 300,
          children: [
            for (final (icon, title, body) in _C.features)
              AppCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTile(icon, size: 44),
                    const SizedBox(height: AppSpacing.small),
                    Text(title, style: LandingText.cardTitle(p.text, 18)),
                    const SizedBox(height: AppSpacing.small),
                    Text(body, style: LandingText.body(p.textSecondary, 15)),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _ForHospitals extends StatelessWidget {
  const _ForHospitals({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    // A dark band in both themes, as in the design.
    const white = Colors.white;
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.caps(_C.hospitalsCap, color: AppColors.darkPrimaryText),
        const SizedBox(height: AppSpacing.screen),
        Text(_C.hospitalsTitle, style: LandingText.heading(white, 40)),
        const SizedBox(height: AppSpacing.screen),
        Text(
          _C.hospitalsBody,
          style: LandingText.body(AppColors.inputBorder, 17),
        ),
        const SizedBox(height: AppSpacing.screen),
        for (final point in _C.hospitalPoints) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: AppColors.darkPrimaryText,
                ),
              ),
              const SizedBox(width: AppSpacing.tight),
              Expanded(
                child: Text(
                  point,
                  style: LandingText.body(AppColors.divider, 16).copyWith(
                    height: 24 / 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.tight),
        ],
        const SizedBox(height: AppSpacing.screen),
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            LandingButton(
              title: 'Join EmergencyHr',
              background: white,
              foreground: AppColors.ink,
              height: AppSizes.buttonLarge,
              radius: AppRadius.control,
              fontSize: 15,
              horizontalPadding: 18,
              onPressed: model.joinHospital,
            ),
            LandingButton(
              title: 'Request a visit',
              background: Colors.transparent,
              foreground: white,
              border: AppColors.textSecondary,
              height: AppSizes.buttonLarge,
              radius: AppRadius.control,
              fontSize: 15,
              horizontalPadding: 18,
              onPressed: model.requestVisit,
            ),
          ],
        ),
      ],
    );
    return ColoredBox(
      color: AppColors.ink,
      child: LandingFrame(
        top: 80,
        bottom: 80,
        child: FlexRow(
          gap: 56,
          items: [
            (basis: 440, flex: 1, child: text),
            (
              basis: 360,
              flex: 1,
              child: Center(
                child: DeskMockup(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Areas extends StatelessWidget {
  const _Areas({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LandingHeading(
          cap: _C.areasCap,
          title: _C.areasTitle,
          body: _C.areasBody,
        ),
        const SizedBox(height: 28),
        AutoGrid(
          minItemWidth: 240,
          gap: 14,
          children: [
            for (final a in model.areas)
              AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.name,
                      style: AppTypography.bodyStrong.copyWith(
                        fontSize: 16,
                        color: context.palette.text,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.half),
                    AppText.caption(a.detail),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Faq extends StatelessWidget {
  const _Faq({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return FlexRow(
      gap: 40,
      crossAxisAlignment: CrossAxisAlignment.start,
      items: [
        (
          basis: 300,
          flex: 1,
          child: const LandingHeading(cap: _C.faqCap, title: _C.faqTitle),
        ),
        (
          basis: 560,
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, (question, answer)) in _C.faqs.indexed) ...[
                if (i > 0) const SizedBox(height: AppSpacing.small),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Semantics(
                        button: true,
                        expanded: model.isFaqOpen(i),
                        child: InkWell(
                          onTap: () => model.toggleFaq(i),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    question,
                                    style: AppTypography.title.copyWith(
                                      color: p.text,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.small),
                                Icon(
                                  model.isFaqOpen(i)
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: p.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 150),
                        alignment: Alignment.topCenter,
                        child: model.isFaqOpen(i)
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  0,
                                  24,
                                  20,
                                ),
                                child: AppText(
                                  answer,
                                  tone: AppTextTone.secondary,
                                ),
                              )
                            : const SizedBox(width: double.infinity),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _AppCallToAction extends StatelessWidget {
  const _AppCallToAction({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    const white = Colors.white;
    final narrow = MediaQuery.sizeOf(context).width < 600;
    Widget store(String label, VoidCallback? onTap) => LandingButton(
      title: label,
      background: AppColors.ink,
      foreground: white,
      height: 60,
      radius: 14,
      fontSize: 15,
      horizontalPadding: 22,
      onPressed: onTap,
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: narrow ? 24 : 48,
        vertical: narrow ? 40 : 56,
      ),
      decoration: BoxDecoration(
        color: p.emergency,
        borderRadius: BorderRadius.circular(28),
      ),
      child: FlexRow(
        gap: 32,
        items: [
          (
            basis: 420,
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_C.appTitle, style: LandingText.heading(white, 38)),
                const SizedBox(height: AppSpacing.small),
                Text(_C.appBody, style: LandingText.body(white, 17)),
              ],
            ),
          ),
          (
            basis: 600,
            flex: 0,
            child: Wrap(
              spacing: AppSpacing.small,
              runSpacing: AppSpacing.small,
              children: [
                LandingButton(
                  title: 'Emergency now',
                  icon: Icons.add_rounded,
                  background: white,
                  foreground: p.critical,
                  height: 60,
                  radius: 14,
                  fontWeight: FontWeight.w800,
                  onPressed: model.startEmergency,
                ),
                store(_C.appStoreLink, model.onAppStore),
                store(_C.googlePlayLink, model.onGooglePlay),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.model});

  final LandingViewModel model;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final link = AppTypography.bodySmall.copyWith(color: p.textSecondary);
    Widget column(String title, List<(String, VoidCallback?)> links) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTypography.label.copyWith(color: p.text),
        ),
        for (final (label, onTap) in links) ...[
          const SizedBox(height: AppSpacing.tight),
          LandingLink(label: label, onTap: onTap, style: link),
        ],
      ],
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(top: BorderSide(color: p.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LandingFrame(
            top: 40,
            bottom: 40,
            child: Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _Logo(fontSize: 18),
                      const SizedBox(height: AppSpacing.small),
                      Text(
                        _C.disclaimer,
                        style: link.copyWith(height: 21 / 14),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 48,
                  runSpacing: 24,
                  children: [
                    column('Product', [
                      (
                        'How it works',
                        () => model.scrollTo(LandingSection.how),
                      ),
                      (
                        'Pilot areas',
                        () => model.scrollTo(LandingSection.areas),
                      ),
                      ('FAQ', () => model.scrollTo(LandingSection.faq)),
                    ]),
                    column('Hospitals', [
                      ('Join EmergencyHr', model.joinHospital),
                      ('Request a visit', model.requestVisit),
                      ('Desk sign in', model.deskSignIn),
                    ]),
                    column('Company', [
                      ('Privacy', model.onPrivacy),
                      ('Terms', model.onTerms),
                      (_C.contactEmail, model.onContact),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          LandingFrame(
            bottom: 32,
            child: AppText.caption(_C.copyright),
          ),
        ],
      ),
    );
  }
}
