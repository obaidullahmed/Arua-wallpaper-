import 'package:flutter/services.dart';
import '../core/constants/app_constants.dart';
import '../data/models/wallpaper_model.dart';

class WallpaperChannelService {
  static const MethodChannel _channel = MethodChannel(AppConstants.wallpaperChannel);

  Future<void> applyWallpaper(WallpaperModel wallpaper) async {
    await _channel.invokeMethod<void>('applyWallpaper', {
      'id': wallpaper.id,
      'type': wallpaper.type.name,
      'sourceAsset': wallpaper.sourceAsset,
      'isPremium': wallpaper.isPremium,
    });
  }
}
