import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../components/page_dots.dart';
import 'intro_viewmodel.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IntroViewModel>.reactive(
      viewModelBuilder: IntroViewModel.new,
      builder: (context, model, _) {
        final p = context.palette;
        return Scaffold(
          backgroundColor: p.surface,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            title: 'Emergency',
                            variant: AppButtonVariant.emergencySoft,
                            size: AppButtonSize.small,
                            expand: false,
                            onPressed: model.startEmergency,
                          ),
                          AppButton.text(
                            title: 'Skip intro',
                            color: p.textSecondary,
                            onPressed: model.skip,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: model.pageController,
                        onPageChanged: model.onPageChanged,
                        children: [
                          for (final (i, slide)
                              in IntroViewModel.slides.indexed)
                            _Slide(
                              slide: slide,
                              index: i,
                              count: IntroViewModel.slides.length,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                      child: AppButton(
                        title: model.primaryLabel,
                        size: AppButtonSize.tall,
                        onPressed: model.next,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.slide, required this.index, required this.count});

  final IntroSlide slide;
  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Image.asset(
                slide.image,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageDots(count: count, current: index),
                const SizedBox(height: 14),
                Semantics(
                  header: true,
                  child: Text(
                    slide.title,
                    style: AppTypography.heading.copyWith(
                      fontSize: 28,
                      height: 34 / 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      color: p.text,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  slide.body,
                  style: AppTypography.body.copyWith(
                    fontSize: 16,
                    height: 24 / 16,
                    color: p.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
