import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/router/app_router.dart';
import '../../../core/enums/wallpaper_category.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../providers/wallpaper_provider.dart';
import '../../widgets/section_header.dart';
import '../../widgets/wallpaper_card.dart';

class CategoryScreen extends ConsumerWidget {
  final WallpaperCategory? category;

  const CategoryScreen({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpapers = ref.watch(wallpaperListProvider);
    final filtered = category == null
        ? wallpapers
        : wallpapers.where((wallpaper) => wallpaper.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category?.displayName ?? 'Browse Categories'),
        backgroundColor: const Color(0xFF0B1220),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Top picks',
                  actionLabel: 'All wallpapers',
                  onAction: () {},
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final wallpaper = filtered[index];
                    return WallpaperCard(
                      wallpaper: wallpaper,
                      onTap: () => Navigator.of(context).pushNamed(AppRouter.detail, arguments: {'wallpaperId': wallpaper.id}),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
              if (filtered.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No wallpapers found for this category.', style: TextStyle(color: Colors.white70)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
