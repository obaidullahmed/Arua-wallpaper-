import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/favorites_service.dart';

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService();
});

class FavoritesNotifier extends StateNotifier<AsyncValue<Set<String>>> {
  FavoritesNotifier(this._service) : super(const AsyncValue.loading()) {
    _loadFavorites();
  }

  final FavoritesService _service;

  Future<void> _loadFavorites() async {
    try {
      final favorites = await _service.loadFavorites();
      state = AsyncValue.data(favorites);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> toggleFavorite(String wallpaperId) async {
    final current = state.value ?? <String>{};
    final updated = current.contains(wallpaperId)
        ? current.difference({wallpaperId})
        : {...current, wallpaperId};

    state = AsyncValue.data(updated);
    await _service.updateFavorites(updated);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, AsyncValue<Set<String>>>((ref) {
  return FavoritesNotifier(ref.read(favoritesServiceProvider));
});
