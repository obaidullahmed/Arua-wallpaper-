import '../../core/enums/wallpaper_category.dart';
import '../../core/enums/wallpaper_type.dart';
import '../models/wallpaper_model.dart';

class LocalWallpaperSource {
  const LocalWallpaperSource();

  List<WallpaperModel> loadWallpapers() {
    return const [
      WallpaperModel(
        id: 'football_video_1',
        title: 'Night Stadium Pulse',
        category: WallpaperCategory.football,
        type: WallpaperType.video,
        thumbnailAsset: 'assets/wallpapers/football/thumbs/football1.jpg',
        sourceAsset: 'assets/wallpapers/football/sources/football1.mp4',
        isPremium: true,
        tags: ['stadium', 'motion', 'sport'],
      ),
      WallpaperModel(
        id: 'football_image_1',
        title: 'Endline Ambition',
        category: WallpaperCategory.football,
        type: WallpaperType.image,
        thumbnailAsset: 'assets/wallpapers/football/thumbs/football2.jpg',
        sourceAsset: 'assets/wallpapers/football/sources/football2.jpg',
        tags: ['football', 'dark', 'arena'],
      ),
      WallpaperModel(
        id: 'anime_motion_1',
        title: 'Celestial Drift',
        category: WallpaperCategory.anime,
        type: WallpaperType.motion,
        thumbnailAsset: 'assets/wallpapers/anime/thumbs/anime1.jpg',
        sourceAsset: 'assets/wallpapers/anime/sources/anime1.jpg',
        isPremium: true,
        tags: ['anime', 'motion', 'fantasy'],
      ),
      WallpaperModel(
        id: 'anime_video_1',
        title: 'Moonlight Hero',
        category: WallpaperCategory.anime,
        type: WallpaperType.video,
        thumbnailAsset: 'assets/wallpapers/anime/thumbs/anime2.jpg',
        sourceAsset: 'assets/wallpapers/anime/sources/anime2.mp4',
        tags: ['hero', 'video', 'dynamic'],
      ),
      WallpaperModel(
        id: 'gaming_image_1',
        title: 'Neon Arena',
        category: WallpaperCategory.gaming,
        type: WallpaperType.image,
        thumbnailAsset: 'assets/wallpapers/gaming/thumbs/gaming1.jpg',
        sourceAsset: 'assets/wallpapers/gaming/sources/gaming1.jpg',
        tags: ['gaming', 'neon', 'cyber'],
      ),
      WallpaperModel(
        id: 'gaming_motion_1',
        title: 'Velocity Shift',
        category: WallpaperCategory.gaming,
        type: WallpaperType.motion,
        thumbnailAsset: 'assets/wallpapers/gaming/thumbs/gaming2.jpg',
        sourceAsset: 'assets/wallpapers/gaming/sources/gaming2.jpg',
        tags: ['speed', 'motion', 'power'],
      ),
      WallpaperModel(
        id: 'nature_image_1',
        title: 'Aurora Forest',
        category: WallpaperCategory.nature,
        type: WallpaperType.image,
        thumbnailAsset: 'assets/wallpapers/football/thumbs/football2.jpg',
        sourceAsset: 'assets/wallpapers/football/sources/football2.jpg',
        tags: ['nature', 'forest', 'calm'],
      ),
      WallpaperModel(
        id: 'trending_video_1',
        title: 'Prism Glide',
        category: WallpaperCategory.trending,
        type: WallpaperType.video,
        thumbnailAsset: 'assets/wallpapers/gaming/thumbs/gaming1.jpg',
        sourceAsset: 'assets/wallpapers/gaming/sources/gaming1.mp4',
        isPremium: true,
        tags: ['trending', 'video', 'premium'],
      ),
      WallpaperModel(
        id: 'trending_motion_1',
        title: 'Kinetic Wave',
        category: WallpaperCategory.trending,
        type: WallpaperType.motion,
        thumbnailAsset: 'assets/wallpapers/anime/thumbs/anime1.jpg',
        sourceAsset: 'assets/wallpapers/anime/sources/anime1.jpg',
        tags: ['trending', 'motion', 'flow'],
      ),
    ];
  }
}
