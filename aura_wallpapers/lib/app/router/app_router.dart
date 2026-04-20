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
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case category:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(category: args?['category'] as WallpaperCategory?),
        );
      case detail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => WallpaperDetailScreen(wallpaperId: args?['wallpaperId'] as String),
        );
      case preview:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => WallpaperPreviewScreen(wallpaperId: args?['wallpaperId'] as String),
        );
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
