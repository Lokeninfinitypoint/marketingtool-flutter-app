import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../providers/tools_provider.dart';
import '../services/auth_service.dart';
import '../widgets/hero_banner.dart';
import '../widgets/feature_card.dart';
import '../widgets/tool_card.dart';
import '../models/tool_model.dart';
import 'tool_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  final Function(int)? onNavigateToTab;

  const DashboardScreen({super.key, this.onNavigateToTab});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _userName;
  bool _isPro = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AuthService.getCurrentUser();
    if (mounted && user != null) {
      setState(() {
        _userName = user.name;
      });
    }
  }

  void _openToolDetail(ToolModel tool) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToolDetailScreen(tool: tool),
      ),
    );
  }

  void _navigateToCategory(String categoryId) {
    final toolsProvider = context.read<ToolsProvider>();
    toolsProvider.setCategory(categoryId);
    widget.onNavigateToTab?.call(1); // Navigate to Tools tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<ToolsProvider>(
          builder: (context, toolsProvider, child) {
            return RefreshIndicator(
              onRefresh: () => toolsProvider.refresh(),
              color: AppColors.primary,
              backgroundColor: AppColors.cardBackground,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Profile Header
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    // Hero Banner
                    const HeroBanner(),
                    const SizedBox(height: 24),
                    // Quick Stats
                    _buildQuickStats(toolsProvider),
                    const SizedBox(height: 24),
                    // Power Tools Section
                    _buildSectionHeader(
                      'Power Tools',
                      'Explore categories',
                      () => widget.onNavigateToTab?.call(1),
                    ),
                    const SizedBox(height: 12),
                    _buildCategoriesRow(toolsProvider),
                    const SizedBox(height: 24),
                    // Featured Tools
                    _buildSectionHeader(
                      'Featured Tools',
                      'See all',
                      () => widget.onNavigateToTab?.call(1),
                    ),
                    const SizedBox(height: 12),
                    _buildFeaturedToolsGrid(toolsProvider),
                    const SizedBox(height: 24),
                    // Recent Tools
                    if (toolsProvider.recentTools.isNotEmpty) ...[
                      _buildSectionHeader('Recent Tools', '', null),
                      const SizedBox(height: 12),
                      _buildRecentToolsList(toolsProvider),
                      const SizedBox(height: 24),
                    ],
                    const SizedBox(height: 80), // Bottom padding for nav bar
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              _userName?.isNotEmpty == true ? _userName![0].toUpperCase() : 'U',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${_userName ?? 'User'}!',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                'Welcome back to MarketingTool',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        if (!_isPro)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildQuickStats(ToolsProvider provider) {
    return Row(
      children: [
        _buildStatCard(
          '${provider.totalToolsCount}',
          'Total Tools',
          Icons.auto_awesome,
          AppColors.primary,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          '${provider.recentTools.length}',
          'Recently Used',
          Icons.history,
          AppColors.seo,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          '${provider.favoriteTools.length}',
          'Favorites',
          Icons.favorite,
          AppColors.accent,
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, VoidCallback? onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        if (action.isNotEmpty)
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 14,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCategoriesRow(ToolsProvider provider) {
    final categories = provider.categories.take(6).toList();
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return FeatureCard(
            category: category,
            onTap: () => _navigateToCategory(category.id),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedToolsGrid(ToolsProvider provider) {
    final featuredTools = provider.featuredTools.take(4).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: featuredTools.length,
      itemBuilder: (context, index) {
        final tool = featuredTools[index];
        return ToolCard(
          tool: tool,
          onTap: () => _openToolDetail(tool),
          onFavorite: () => provider.toggleFavorite(tool.id),
        );
      },
    );
  }

  Widget _buildRecentToolsList(ToolsProvider provider) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.recentTools.length,
        itemBuilder: (context, index) {
          final tool = provider.recentTools[index];
          return GestureDetector(
            onTap: () => _openToolDetail(tool),
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tool.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Used recently',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
