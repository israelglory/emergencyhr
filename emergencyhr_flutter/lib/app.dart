import 'package:emergencyhr_flutter/core/constants/colors.dart';
import 'package:emergencyhr_flutter/core/theme/theme.dart';

import 'package:emergencyhr_flutter/screens/greetings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:overlay_support/overlay_support.dart';

import '../core/di/locator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(
        background: AppColors.lightGreen,
        textColor: Colors.white,
      ),
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigationService.navigatorKey,
            title: 'Emergency hr',
            theme: AppTheme.lightTheme,

            home: GreetingsScreen(),
          );
        },
      ),
    );
  }
}
