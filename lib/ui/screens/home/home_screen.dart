import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/router/app_router.dart';
import '../../../core/enums/wallpaper_category.dart';
import '../../../core/enums/wallpaper_type.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../providers/wallpaper_provider.dart';
import '../../../ui/widgets/category_chip.dart';
import '../../../ui/widgets/section_header.dart';
import '../../../ui/widgets/wallpaper_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  WallpaperCategory? _selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallpapers = ref.watch(wallpaperListProvider);
    final searchQuery = _searchController.text.trim();
    final searchResults = searchQuery.isEmpty
        ? wallpapers
        : ref.read(wallpaperRepositoryProvider).search(searchQuery);
    final featured = wallpapers.where((wallpaper) => wallpaper.isPremium).take(3).toList();
    final trending = wallpapers.where((wallpaper) => wallpaper.category == WallpaperCategory.trending).toList();
    final liveWallpapers = searchResults.where((wallpaper) => wallpaper.type != WallpaperType.image).toList();
    final latestWallpapers = searchResults.where((wallpaper) => wallpaper.type == WallpaperType.image || wallpaper.type == WallpaperType.motion).toList();
    final collection = _selectedTab == 0 ? latestWallpapers : liveWallpapers;
    final categoryList = WallpaperCategory.values;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        title: const Text('Aura Wallpapers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.of(context).pushNamed(AppRouter.favorites),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(AppRouter.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text('Discover premium wallpaper actions', style: AppTextStyles.headline.copyWith(color: Colors.white)),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search wallpapers, categories, tags',
                        prefixIcon: const Icon(Icons.search, color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF141E2F),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final category = categoryList[index];
                          final selected = _selectedCategory == category;
                          return CategoryChip(
                            category: category,
                            isSelected: selected,
                            onTap: () {
                              setState(() {
                                if (selected) {
                                  _selectedCategory = null;
                                } else {
                                  _selectedCategory = category;
                                }
                              });
                              Navigator.of(context).pushNamed(AppRouter.category, arguments: {'category': category});
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SectionHeader(
                      title: 'Featured',
                      actionLabel: 'See all',
                      onAction: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final wallpaper = featured[index];
                    return WallpaperCard(
                      wallpaper: wallpaper,
                      onTap: () => Navigator.of(context).pushNamed(AppRouter.detail, arguments: {'wallpaperId': wallpaper.id}),
                    );
                  },
                  childCount: featured.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SectionHeader(title: 'Trending', actionLabel: 'Explore', onAction: () {}),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final wallpaper = trending[index];
                      return SizedBox(
                        width: 260,
                        child: WallpaperCard(
                          wallpaper: wallpaper,
                          onTap: () => Navigator.of(context).pushNamed(AppRouter.detail, arguments: {'wallpaperId': wallpaper.id}),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: trending.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedTab = 0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _selectedTab == 0 ? const Color(0xFF2B3562) : const Color(0xFF141E2F),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text('Latest', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedTab = 1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _selectedTab == 1 ? const Color(0xFF2B3562) : const Color(0xFF141E2F),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(18),
                                  bottomRight: Radius.circular(18),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text('Live', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final wallpaper = collection[index];
                    return WallpaperCard(
                      wallpaper: wallpaper,
                      onTap: () => Navigator.of(context).pushNamed(AppRouter.detail, arguments: {'wallpaperId': wallpaper.id}),
                    );
                  },
                  childCount: collection.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
