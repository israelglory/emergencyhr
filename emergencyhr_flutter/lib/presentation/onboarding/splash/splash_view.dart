import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: SplashViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final p = context.palette;
        return Scaffold(
          backgroundColor: p.emergency,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x2E000000),
                            offset: Offset(0, 12),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppAssets.splashLogo,
                        width: 88,
                        height: 88,
                        excludeFromSemantics: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.screen),
                    Text(
                      SplashViewModel.appName,
                      style: AppTypography.heading.copyWith(
                        fontSize: 32,
                        height: 40 / 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                        color: p.onEmergency,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.screen),
                    Text(
                      SplashViewModel.tagline,
                      style: AppTypography.body.copyWith(
                        fontSize: 16,
                        color: p.onEmergency.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 64,
                child: Center(
                  child: SizedBox.square(
                    dimension: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: p.onEmergency,
                      backgroundColor: p.onEmergency.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
