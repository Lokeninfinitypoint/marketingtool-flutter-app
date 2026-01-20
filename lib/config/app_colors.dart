import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (MarketingTool Purple Theme)
  static const Color primary = Color(0xFF8B5CF6); // Purple/Violet
  static const Color primaryDark = Color(0xFF6366F1);
  static const Color accent = Color(0xFFEC4899); // Pink accent

  // Background Colors (Dark Theme - matches marketingtool.pro)
  static const Color background = Color(0xFF0E0C15);
  static const Color cardBackground = Color(0xFF1A1625);
  static const Color surfaceLight = Color(0xFF252336);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textMuted = Color(0xFF6B7280);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Category Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color google = Color(0xFF4285F4);
  static const Color seo = Color(0xFF34A853);
  static const Color content = Color(0xFF8B5CF6);
  static const Color ecommerce = Color(0xFFFF6B00);
  static const Color email = Color(0xFF4285F4);
  static const Color social = Color(0xFF1DA1F2);
  static const Color creative = Color(0xFFEC4899);
  static const Color analytics = Color(0xFF10B981);
  static const Color aiAgents = Color(0xFF8B5CF6);

  // Gradients (MarketingTool Style)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF1A1625), Color(0xFF0E0C15)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient cardGradient = LinearGradient(
    colors: [cardBackground, cardBackground.withOpacity(0.8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow
  static List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: primary.withOpacity(0.4),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
}
