import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'not_found_viewmodel.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotFoundViewModel>.nonReactive(
      viewModelBuilder: NotFoundViewModel.new,
      builder: (context, model, _) {
        final p = context.palette;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.x3,
                  vertical: AppSpacing.x4,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSizes.contentMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        NotFoundViewModel.code,
                        style: AppTypography.heading.copyWith(
                          fontSize: 56,
                          height: 1.1,
                          letterSpacing: -1,
                          color: p.inputBorder,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const AppText.headline(NotFoundViewModel.title),
                      const SizedBox(height: 14),
                      const AppText(
                        NotFoundViewModel.message,
                        tone: AppTextTone.secondary,
                      ),
                      const SizedBox(height: 22),
                      AppButton(title: 'Go to home', onPressed: model.goHome),
                      const SizedBox(height: 14),
                      AppButton.dangerOutline(
                        title: 'Emergency',
                        onPressed: model.startEmergency,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
