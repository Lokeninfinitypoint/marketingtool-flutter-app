import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/tool_category_model.dart';

class CategoryChip extends StatelessWidget {
  final ToolCategoryModel? category;
  final String? label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isAll;

  const CategoryChip({
    super.key,
    this.category,
    this.label,
    required this.isSelected,
    required this.onTap,
    this.isAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayLabel = label ?? category?.name ?? 'All';
    final chipColor = isAll ? AppColors.primary : (category?.color ?? AppColors.primary);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? chipColor.withOpacity(0.2)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? chipColor : Colors.white.withOpacity(0.1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isAll && category != null) ...[
              Icon(
                _getIconData(category!.icon),
                color: isSelected ? chipColor : Colors.white60,
                size: 16,
              ),
              const SizedBox(width: 6),
            ],
            if (isAll) ...[
              Icon(
                Icons.apps,
                color: isSelected ? chipColor : Colors.white60,
                size: 16,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              displayLabel,
              style: TextStyle(
                color: isSelected ? chipColor : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
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
