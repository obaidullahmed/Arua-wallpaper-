import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/wallpaper_provider.dart';
import '../../widgets/wallpaper_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);
    final wallpaperList = ref.watch(wallpaperListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        title: const Text('Favorites'),
      ),
      body: SafeArea(
        child: favoritesState.when(
          data: (favorites) {
            final favoriteWallpapers = wallpaperList.where((wallpaper) => favorites.contains(wallpaper.id)).toList();

            if (favoriteWallpapers.isEmpty) {
              return const Center(
                child: Text('No favorite wallpapers yet.', style: TextStyle(color: Colors.white70)),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: favoriteWallpapers.length,
              itemBuilder: (context, index) {
                final wallpaper = favoriteWallpapers[index];
                return WallpaperCard(
                  wallpaper: wallpaper,
                  onTap: () => Navigator.of(context).pushNamed(AppRouter.detail, arguments: {'wallpaperId': wallpaper.id}),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('Unable to load favorites', style: const TextStyle(color: Colors.white70).copyWith()),
          ),
        ),
      ),
    );
  }
}
