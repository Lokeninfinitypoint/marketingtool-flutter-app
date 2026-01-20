import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../config/app_colors.dart';

class HeroBanner extends StatefulWidget {
  final Function(int)? onBannerTap;

  const HeroBanner({super.key, this.onBannerTap});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  int _currentIndex = 0;

  final List<BannerData> _banners = [
    BannerData(
      title: 'Smart Marketing',
      subtitle: 'with AI Tools',
      description: 'Supercharge your marketing with 206+ AI-powered tools',
      gradient: [AppColors.primary, AppColors.primaryDark],
      icon: Icons.rocket_launch,
    ),
    BannerData(
      title: 'Content Creation',
      subtitle: 'Made Easy',
      description: 'Generate blogs, ads, emails, and more in seconds',
      gradient: [AppColors.accent, AppColors.primary],
      icon: Icons.edit_note,
    ),
    BannerData(
      title: 'SEO & Analytics',
      subtitle: 'Insights',
      description: 'Optimize your content and track performance',
      gradient: [AppColors.seo, AppColors.analytics],
      icon: Icons.analytics,
    ),
    BannerData(
      title: 'Social Media',
      subtitle: 'Mastery',
      description: 'Dominate Facebook, Instagram, Twitter & more',
      gradient: [AppColors.facebook, AppColors.instagram],
      icon: Icons.share,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          itemBuilder: (context, index, realIndex) {
            final banner = _banners[index];
            return GestureDetector(
              onTap: () => widget.onBannerTap?.call(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: banner.gradient,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: banner.gradient.first.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Icon(
                        banner.icon,
                        size: 150,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  banner.icon,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            banner.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            banner.subtitle,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore Now',
                                  style: TextStyle(
                                    color: banner.gradient.first,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  color: banner.gradient.first,
                                  size: 14,
                                ),
                              ],
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
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 20 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == entry.key
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class BannerData {
  final String title;
  final String subtitle;
  final String description;
  final List<Color> gradient;
  final IconData icon;

  BannerData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradient,
    required this.icon,
  });
}
