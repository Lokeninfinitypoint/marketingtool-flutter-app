import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/tool_category_model.dart';

class FeatureCard extends StatelessWidget {
  final ToolCategoryModel category;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              category.color.withOpacity(0.8),
              category.color.withOpacity(0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconData(category.icon),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${category.toolCount} tools',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'facebook': Icons.facebook,
      'camera_alt': Icons.camera_alt,
      'ads_click': Icons.ads_click,
      'search': Icons.search,
      'edit_note': Icons.edit_note,
      'shopping_cart': Icons.shopping_cart,
      'email': Icons.email,
      'share': Icons.share,
      'palette': Icons.palette,
      'analytics': Icons.analytics,
      'smart_toy': Icons.smart_toy,
      'auto_mode': Icons.auto_mode,
      'grade': Icons.grade,
      'tune': Icons.tune,
      'campaign': Icons.campaign,
      'psychology': Icons.psychology,
    };
    return icons[iconName] ?? Icons.auto_awesome;
  }
}
