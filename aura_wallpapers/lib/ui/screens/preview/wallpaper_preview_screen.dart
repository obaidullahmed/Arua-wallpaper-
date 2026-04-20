import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/wallpaper_model.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/wallpaper_provider.dart';
import '../../../services/wallpaper_channel_service.dart';
import '../../widgets/gradient_button.dart';

class WallpaperPreviewScreen extends ConsumerStatefulWidget {
  final String wallpaperId;

  const WallpaperPreviewScreen({super.key, required this.wallpaperId});

  @override
  ConsumerState<WallpaperPreviewScreen> createState() => _WallpaperPreviewScreenState();
}

class _WallpaperPreviewScreenState extends ConsumerState<WallpaperPreviewScreen> {
  VideoPlayerController? _videoController;
  bool _isInitialized = false;

  WallpaperModel? get wallpaper => ref.read(wallpaperByIdProvider(widget.wallpaperId));

  @override
  void initState() {
    super.initState();
    _initializePreview();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _initializePreview() async {
    final selectedWallpaper = wallpaper;
    if (selectedWallpaper == null || !selectedWallpaper.isVideo) {
      return;
    }

    _videoController = VideoPlayerController.asset(selectedWallpaper.sourceAsset);
    await _videoController!.initialize();
    _videoController!
      ..setLooping(true)
      ..play();

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedWallpaper = wallpaper;
    final channelService = ref.read(wallpaperChannelServiceProvider);

    if (selectedWallpaper == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0B1220), title: const Text('Preview')),
        body: const Center(child: Text('Wallpaper not found', style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        title: const Text('Preview Wallpaper'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFF0B1220),
                child: selectedWallpaper.isVideo
                    ? _isInitialized && _videoController != null
                        ? AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          )
                        : const Center(child: CircularProgressIndicator())
                    : Image.asset(selectedWallpaper.sourceAsset, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedWallpaper.title, style: AppTextStyles.title.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(selectedWallpaper.category.displayName, style: AppTextStyles.subtitle.copyWith(color: Colors.white70)),
                  const SizedBox(height: 20),
                  GradientButton(
                    label: 'Apply Live Wallpaper',
                    onPressed: () async {
                      try {
                        await channelService.applyWallpaper(selectedWallpaper);
                      } catch (error) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('Apply Failed'),
                            content: Text('Unable to open the live wallpaper flow. ${error.toString()}'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('OK')),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
