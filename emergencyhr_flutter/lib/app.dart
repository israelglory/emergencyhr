import 'package:flutter/material.dart';

import 'core/cores.dart';
import 'core/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergencyhr',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      navigatorKey: navigationService.navigatorKey,
      scaffoldMessengerKey: snackbarService.scaffoldMessengerKey,
      initialRoute: AppRoutes.landing,
      onGenerateInitialRoutes: AppRouter.onGenerateInitialRoutes,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
