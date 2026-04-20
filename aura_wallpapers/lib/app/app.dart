import 'package:flutter/material.dart';
import '../app/theme/app_theme.dart';
import '../app/router/app_router.dart';

class AuraWallpapersApp extends StatelessWidget {
  const AuraWallpapersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura Wallpapers',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.home,
    );
  }
}
