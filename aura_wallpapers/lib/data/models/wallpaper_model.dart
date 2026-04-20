import '../../core/enums/wallpaper_category.dart';
import '../../core/enums/wallpaper_type.dart';

class WallpaperModel {
  final String id;
  final String title;
  final WallpaperCategory category;
  final WallpaperType type;
  final String thumbnailAsset;
  final String sourceAsset;
  final bool isPremium;
  final List<String> tags;

  const WallpaperModel({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.thumbnailAsset,
    required this.sourceAsset,
    this.isPremium = false,
    this.tags = const [],
  });

  bool get isVideo => type == WallpaperType.video;
  bool get isMotion => type == WallpaperType.motion;
}
