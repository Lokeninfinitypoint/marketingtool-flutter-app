import 'package:shared_preferences/shared_preferences.dart';
import '../models/tool_model.dart';
import '../models/tool_category_model.dart';
import '../data/tools_data.dart';

class ToolsService {
  static const String _favoritesKey = 'favorite_tools';
  static const String _recentToolsKey = 'recent_tools';
  static const String _usageCountKey = 'tool_usage_';

  // Get all tools
  static List<ToolModel> getAllTools() {
    return ToolsData.tools;
  }

  // Get all categories
  static List<ToolCategoryModel> getAllCategories() {
    return ToolsData.categories;
  }

  // Get tools by category
  static List<ToolModel> getToolsByCategory(String categoryId) {
    return ToolsData.getToolsByCategory(categoryId);
  }

  // Search tools
  static List<ToolModel> searchTools(String query) {
    return ToolsData.searchTools(query);
  }

  // Get featured tools (high rating)
  static List<ToolModel> getFeaturedTools() {
    return ToolsData.getFeaturedTools();
  }

  // Get tool by ID
  static ToolModel? getToolById(String id) {
    try {
      return ToolsData.tools.firstWhere((tool) => tool.id == id);
    } catch (_) {
      return null;
    }
  }

  // Favorites Management
  static Future<List<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  static Future<void> toggleFavorite(String toolId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    if (favorites.contains(toolId)) {
      favorites.remove(toolId);
    } else {
      favorites.add(toolId);
    }

    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String toolId) async {
    final favorites = await getFavoriteIds();
    return favorites.contains(toolId);
  }

  static Future<List<ToolModel>> getFavoriteTools() async {
    final favoriteIds = await getFavoriteIds();
    return ToolsData.tools
        .where((tool) => favoriteIds.contains(tool.id))
        .toList();
  }

  // Recent Tools Management
  static Future<List<String>> getRecentToolIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentToolsKey) ?? [];
  }

  static Future<void> addToRecent(String toolId) async {
    final prefs = await SharedPreferences.getInstance();
    final recent = prefs.getStringList(_recentToolsKey) ?? [];

    // Remove if already exists (to move to front)
    recent.remove(toolId);
    // Add to front
    recent.insert(0, toolId);
    // Keep only last 20
    if (recent.length > 20) {
      recent.removeRange(20, recent.length);
    }

    await prefs.setStringList(_recentToolsKey, recent);
  }

  static Future<List<ToolModel>> getRecentTools({int limit = 10}) async {
    final recentIds = await getRecentToolIds();
    final limitedIds = recentIds.take(limit).toList();

    return limitedIds
        .map((id) => getToolById(id))
        .where((tool) => tool != null)
        .cast<ToolModel>()
        .toList();
  }

  // Usage Tracking
  static Future<void> trackToolUsage(String toolId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_usageCountKey$toolId';
    final count = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, count + 1);

    // Also add to recent
    await addToRecent(toolId);
  }

  static Future<int> getToolUsageCount(String toolId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_usageCountKey$toolId') ?? 0;
  }

  static Future<Map<String, int>> getAllUsageStats() async {
    final prefs = await SharedPreferences.getInstance();
    final stats = <String, int>{};

    for (final tool in ToolsData.tools) {
      final count = prefs.getInt('$_usageCountKey${tool.id}') ?? 0;
      if (count > 0) {
        stats[tool.id] = count;
      }
    }

    return stats;
  }

  static Future<List<ToolModel>> getMostUsedTools({int limit = 5}) async {
    final stats = await getAllUsageStats();
    final sortedIds = stats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedIds
        .take(limit)
        .map((entry) => getToolById(entry.key))
        .where((tool) => tool != null)
        .cast<ToolModel>()
        .toList();
  }

  // Stats
  static int get totalToolsCount => ToolsData.totalToolsCount;
  static int get premiumToolsCount => ToolsData.premiumToolsCount;
  static int get freeToolsCount => ToolsData.freeToolsCount;
  static int get categoriesCount => ToolsData.categories.length;
}
