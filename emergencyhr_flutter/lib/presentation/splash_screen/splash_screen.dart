import 'package:emergencyhr_flutter/core/constants/app_assets.dart';
import 'package:emergencyhr_flutter/presentation/splash_screen/splash_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.initializeSplashScreen();
      },
      viewModelBuilder: () => SplashScreenVM(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              AppAssets.bglowLogoPng,
              width: 100,
              height: 100,
              //   colorBlendMode: AppColors.black,
            ),
          ),
        );
      },
    );
  }
}
