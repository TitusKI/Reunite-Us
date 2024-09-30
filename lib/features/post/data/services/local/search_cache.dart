import 'package:shared_preferences/shared_preferences.dart';

class SearchCacheService {
  static const _recentSearchesKey = 'recent_searches';

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  Future<void> addSearch(String searchText) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = await getRecentSearches();

    // Add new search text at the start, ensuring only the latest five are kept
    recentSearches.insert(0, searchText);
    final uniqueSearches = recentSearches.toSet().toList(); // remove duplicates
    await prefs.setStringList(
      _recentSearchesKey,
      uniqueSearches.take(5).toList(),
    );
  }

  Future<void> clearSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
  }
}
