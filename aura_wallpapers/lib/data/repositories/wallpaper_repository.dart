import '../models/wallpaper_model.dart';
import '../sources/local_wallpaper_source.dart';

class WallpaperRepository {
  final LocalWallpaperSource localSource;

  WallpaperRepository({LocalWallpaperSource? localSource}) : localSource = localSource ?? const LocalWallpaperSource();

  List<WallpaperModel> getAll() => localSource.loadWallpapers();

  WallpaperModel? getById(String id) {
    final wallpapers = localSource.loadWallpapers();
    for (final wallpaper in wallpapers) {
      if (wallpaper.id == id) {
        return wallpaper;
      }
    }
    return null;
  }

  List<WallpaperModel> getByCategory(String categoryKey) {
    return localSource.loadWallpapers().where((wallpaper) {
      return wallpaper.category.name == categoryKey;
    }).toList();
  }

  List<WallpaperModel> search(String query) {
    final normalizedQuery = query.toLowerCase();
    return localSource.loadWallpapers().where((wallpaper) {
      return wallpaper.title.toLowerCase().contains(normalizedQuery) ||
          wallpaper.tags.any((tag) => tag.toLowerCase().contains(normalizedQuery));
    }).toList();
  }
}
