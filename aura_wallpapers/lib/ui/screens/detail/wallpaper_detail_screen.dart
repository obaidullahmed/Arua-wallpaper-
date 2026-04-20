import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/router/app_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/wallpaper_model.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/wallpaper_provider.dart';
import '../../../ui/widgets/gradient_button.dart';
import '../../../ui/widgets/premium_badge.dart';

class WallpaperDetailScreen extends ConsumerWidget {
  final String wallpaperId;

  const WallpaperDetailScreen({super.key, required this.wallpaperId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaper = ref.watch(wallpaperByIdProvider(wallpaperId));
    final favoritesState = ref.watch(favoritesProvider);
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final channelService = ref.read(wallpaperChannelServiceProvider);

    if (wallpaper == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0B1220), title: const Text('Wallpaper Details')),
        body: const Center(child: Text('Wallpaper not found', style: TextStyle(color: Colors.white))),
      );
    }

    final isFavorite = favoritesState.maybeWhen(data: (value) => value.contains(wallpaper.id), orElse: () => false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        title: const Text('Wallpaper Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(wallpaper.thumbnailAsset, fit: BoxFit.cover, width: double.infinity, height: 260),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(wallpaper.title, style: AppTextStyles.headline.copyWith(color: Colors.white)),
                  ),
                  if (wallpaper.isPremium) const PremiumBadge(),
                ],
              ),
              const SizedBox(height: 10),
              Text(wallpaper.category.displayName, style: AppTextStyles.subtitle.copyWith(color: Colors.white70)),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: wallpaper.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2838),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(tag, style: AppTextStyles.body.copyWith(color: Colors.white70)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
              GradientButton(
                label: 'Preview',
                onPressed: () => Navigator.of(context).pushNamed(AppRouter.preview, arguments: {'wallpaperId': wallpaper.id}),
              ),
              const SizedBox(height: 16),
              GradientButton(
                label: 'Apply Wallpaper',
                onPressed: () async {
                  try {
                    await channelService.applyWallpaper(wallpaper);
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
              Text('Info', style: AppTextStyles.title.copyWith(color: Colors.white)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF141E2F),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type: ${wallpaper.type.displayName}', style: AppTextStyles.body.copyWith(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('Category: ${wallpaper.category.displayName}', style: AppTextStyles.body.copyWith(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('Premium: ${wallpaper.isPremium ? 'Yes' : 'No'}', style: AppTextStyles.body.copyWith(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('Source asset: ${wallpaper.sourceAsset}', style: AppTextStyles.caption.copyWith(color: Colors.white54)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.pinkAccent),
                  onPressed: () => favoritesNotifier.toggleFavorite(wallpaper.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
