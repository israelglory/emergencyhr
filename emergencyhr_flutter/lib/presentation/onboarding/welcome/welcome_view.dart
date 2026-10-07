import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.nonReactive(
      viewModelBuilder: WelcomeViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final p = context.palette;
        final heading = AppTypography.heading.copyWith(
          fontSize: 28,
          height: 34 / 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
          color: p.text,
        );
        return Scaffold(
          backgroundColor: p.surface,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) =>
                            SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                56,
                                24,
                                16,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight - 72,
                                ),
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AppAssets.logoMark,
                                        width: 56,
                                        height: 56,
                                        excludeFromSemantics: true,
                                      ),
                                      const SizedBox(height: 22),
                                      Semantics(
                                        header: true,
                                        child: Text(
                                          WelcomeViewModel.title,
                                          style: heading,
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.x1),
                                      Text(
                                        WelcomeViewModel.subtitle,
                                        style: AppTypography.body.copyWith(
                                          fontSize: 16,
                                          height: 24 / 16,
                                          color: p.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 22),
                                      for (final b
                                          in WelcomeViewModel.benefits) ...[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 1,
                                              ),
                                              child: Icon(
                                                Icons.check_rounded,
                                                size: 20,
                                                color: p.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(child: AppText(b)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.small,
                                        ),
                                      ],
                                      const Spacer(),
                                      const SizedBox(height: AppSpacing.tight),
                                      _EmergencyNote(
                                        onEmergency: model.startEmergency,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppButton(
                            title: 'Create account',
                            size: AppButtonSize.tall,
                            onPressed: model.createAccount,
                          ),
                          const SizedBox(height: AppSpacing.tight),
                          AppButton.secondary(
                            title: 'Sign in',
                            size: AppButtonSize.tall,
                            onPressed: model.signIn,
                          ),
                          const SizedBox(height: AppSpacing.tight),
                          AppButton.text(
                            title: 'Skip for now',
                            color: p.textSecondary,
                            expand: true,
                            onPressed: model.skip,
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
      },
    );
  }
}

/// Pale red note with a small red Emergency button.
class _EmergencyNote extends StatelessWidget {
  const _EmergencyNote({required this.onEmergency});

  final VoidCallback onEmergency;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: p.emergencyContainer,
        border: Border.all(color: p.emergencyBorder),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        children: [
          Icon(Icons.add_rounded, size: 20, color: p.critical),
          const SizedBox(width: AppSpacing.small),
          Expanded(
            child: Text(
              WelcomeViewModel.emergencyNote,
              style: AppTypography.bodySmall.copyWith(color: p.emergencyInk),
            ),
          ),
          const SizedBox(width: AppSpacing.small),
          AppButton.danger(
            title: 'Emergency',
            size: AppButtonSize.small,
            expand: false,
            onPressed: onEmergency,
          ),
        ],
      ),
    );
  }
}
