import 'package:flutter/material.dart';
import '../models/tool_model.dart';
import '../models/tool_category_model.dart';
import '../services/tools_service.dart';

class ToolsProvider extends ChangeNotifier {
  List<ToolModel> _allTools = [];
  List<ToolCategoryModel> _categories = [];
  List<ToolModel> _recentTools = [];
  List<ToolModel> _favoriteTools = [];
  List<String> _favoriteIds = [];
  String? _selectedCategoryId;
  String _searchQuery = '';
  bool _isLoading = false;

  // Getters
  List<ToolModel> get allTools => _allTools;
  List<ToolCategoryModel> get categories => _categories;
  List<ToolModel> get recentTools => _recentTools;
  List<ToolModel> get favoriteTools => _favoriteTools;
  List<String> get favoriteIds => _favoriteIds;
  String? get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  List<ToolModel> get filteredTools {
    var tools = _allTools;

    // Filter by category
    if (_selectedCategoryId != null && _selectedCategoryId!.isNotEmpty) {
      tools = tools.where((t) => t.categoryId == _selectedCategoryId).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      tools = tools.where((tool) =>
        tool.name.toLowerCase().contains(query) ||
        tool.description.toLowerCase().contains(query) ||
        tool.tags.any((tag) => tag.toLowerCase().contains(query))
      ).toList();
    }

    return tools;
  }

  List<ToolModel> get featuredTools {
    return _allTools.where((t) => t.rating >= 4.7).take(10).toList();
  }

  List<ToolModel> get premiumTools {
    return _allTools.where((t) => t.isPremium).toList();
  }

  int get totalToolsCount => _allTools.length;

  // Initialize
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _allTools = ToolsService.getAllTools();
    _categories = ToolsService.getAllCategories();
    _favoriteIds = await ToolsService.getFavoriteIds();
    _recentTools = await ToolsService.getRecentTools();
    _favoriteTools = await ToolsService.getFavoriteTools();

    // Update favorite status on tools
    for (var i = 0; i < _allTools.length; i++) {
      _allTools[i].isFavorite = _favoriteIds.contains(_allTools[i].id);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Set category filter
  void setCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _selectedCategoryId = null;
    _searchQuery = '';
    notifyListeners();
  }

  // Toggle favorite
  Future<void> toggleFavorite(String toolId) async {
    await ToolsService.toggleFavorite(toolId);

    // Update local state
    if (_favoriteIds.contains(toolId)) {
      _favoriteIds.remove(toolId);
    } else {
      _favoriteIds.add(toolId);
    }

    // Update tool's favorite status
    final toolIndex = _allTools.indexWhere((t) => t.id == toolId);
    if (toolIndex != -1) {
      _allTools[toolIndex].isFavorite = _favoriteIds.contains(toolId);
    }

    _favoriteTools = await ToolsService.getFavoriteTools();
    notifyListeners();
  }

  // Track tool usage
  Future<void> trackToolUsage(String toolId) async {
    await ToolsService.trackToolUsage(toolId);
    _recentTools = await ToolsService.getRecentTools();
    notifyListeners();
  }

  // Get tools by category
  List<ToolModel> getToolsByCategory(String categoryId) {
    return _allTools.where((t) => t.categoryId == categoryId).toList();
  }

  // Get category by ID
  ToolCategoryModel? getCategoryById(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  // Check if tool is favorite
  bool isFavorite(String toolId) {
    return _favoriteIds.contains(toolId);
  }

  // Refresh data
  Future<void> refresh() async {
    await initialize();
  }
}
