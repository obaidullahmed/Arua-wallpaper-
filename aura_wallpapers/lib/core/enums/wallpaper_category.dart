enum WallpaperCategory {
  football,
  anime,
  gaming,
  nature,
  trending,
}

extension WallpaperCategoryExtensions on WallpaperCategory {
  String get displayName {
    switch (this) {
      case WallpaperCategory.football:
        return 'Football';
      case WallpaperCategory.anime:
        return 'Anime';
      case WallpaperCategory.gaming:
        return 'Gaming';
      case WallpaperCategory.nature:
        return 'Nature';
      case WallpaperCategory.trending:
        return 'Trending';
    }
  }
}
