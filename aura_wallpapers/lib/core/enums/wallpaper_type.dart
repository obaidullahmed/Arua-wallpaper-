enum WallpaperType {
  image,
  video,
  motion,
}

extension WallpaperTypeExtensions on WallpaperType {
  String get displayName {
    switch (this) {
      case WallpaperType.image:
        return 'Image';
      case WallpaperType.video:
        return 'Video';
      case WallpaperType.motion:
        return 'Motion';
    }
  }
}
