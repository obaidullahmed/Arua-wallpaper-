import 'package:flutter/material.dart';
import '../../core/enums/wallpaper_category.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/category/category_screen.dart';
import '../../ui/screens/detail/wallpaper_detail_screen.dart';
import '../../ui/screens/preview/wallpaper_preview_screen.dart';
import '../../ui/screens/favorites/favorites_screen.dart';
import '../../ui/screens/settings/settings_screen.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String category = '/category';
  static const String detail = '/detail';
  static const String preview = '/preview';
  static const String favorites = '/favorites';
  static const String settings = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName == home) {
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    }

    if (routeName == category) {
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => CategoryScreen(category: args?['category'] as WallpaperCategory?),
      );
    }

    if (routeName == detail) {
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => WallpaperDetailScreen(wallpaperId: args?['wallpaperId'] as String),
      );
    }

    if (routeName == preview) {
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => WallpaperPreviewScreen(wallpaperId: args?['wallpaperId'] as String),
      );
    }

    if (routeName == favorites) {
      return MaterialPageRoute(builder: (_) => const FavoritesScreen());
    }

    if (routeName == settings) {
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    }

    return MaterialPageRoute(builder: (_) => const HomeScreen());
  }
}
