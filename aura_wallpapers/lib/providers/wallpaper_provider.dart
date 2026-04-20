import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/wallpaper_model.dart';
import '../data/repositories/wallpaper_repository.dart';
import '../services/wallpaper_channel_service.dart';

final wallpaperRepositoryProvider = Provider<WallpaperRepository>((ref) {
  return WallpaperRepository();
});

final wallpaperChannelServiceProvider = Provider<WallpaperChannelService>((ref) {
  return WallpaperChannelService();
});

final wallpaperListProvider = Provider<List<WallpaperModel>>((ref) {
  return ref.read(wallpaperRepositoryProvider).getAll();
});

final wallpaperByIdProvider = Provider.family<WallpaperModel?, String>((ref, wallpaperId) {
  return ref.read(wallpaperRepositoryProvider).getById(wallpaperId);
});

final wallpaperSearchProvider = Provider.family<List<WallpaperModel>, String>((ref, query) {
  if (query.isEmpty) {
    return ref.read(wallpaperListProvider);
  }
  return ref.read(wallpaperRepositoryProvider).search(query);
});
