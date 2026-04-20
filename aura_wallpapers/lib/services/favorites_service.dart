import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

class FavoritesService {
  Future<Set<String>> loadFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    final favorites = preferences.getStringList(AppConstants.preferenceFavoritesKey);
    return favorites?.toSet() ?? <String>{};
  }

  Future<void> updateFavorites(Set<String> favorites) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(AppConstants.preferenceFavoritesKey, favorites.toList());
  }

  Future<bool> isFavorite(String wallpaperId) async {
    final favorites = await loadFavorites();
    return favorites.contains(wallpaperId);
  }
}
