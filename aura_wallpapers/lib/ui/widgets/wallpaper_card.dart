import 'package:flutter/material.dart';
import '../../data/models/wallpaper_model.dart';
import '../../core/theme/app_text_styles.dart';
import 'premium_badge.dart';

class WallpaperCard extends StatelessWidget {
  final WallpaperModel wallpaper;
  final VoidCallback onTap;

  const WallpaperCard({super.key, required this.wallpaper, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                wallpaper.thumbnailAsset,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wallpaper.title, style: AppTextStyles.title.copyWith(color: Colors.white)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (wallpaper.isPremium) const PremiumBadge(),
                      if (wallpaper.isPremium) const SizedBox(width: 8),
                      Text(
                        wallpaper.category.displayName,
                        style: AppTextStyles.caption.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
