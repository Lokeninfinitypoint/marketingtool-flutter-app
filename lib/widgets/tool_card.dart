import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/tool_model.dart';

class ToolCard extends StatelessWidget {
  final ToolModel tool;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final bool showCategory;

  const ToolCard({
    super.key,
    required this.tool,
    required this.onTap,
    this.onFavorite,
    this.showCategory = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconData(tool.icon),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  if (tool.isPremium)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'PRO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (onFavorite != null) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onFavorite,
                      child: Icon(
                        tool.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: tool.isFavorite
                            ? AppColors.accent
                            : Colors.white54,
                        size: 20,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                tool.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Text(
                  tool.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    tool.rating.toStringAsFixed(1),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    final icons = {
      'ads_click': Icons.ads_click,
      'people': Icons.people,
      'lightbulb': Icons.lightbulb,
      'tag': Icons.tag,
      'view_carousel': Icons.view_carousel,
      'videocam': Icons.videocam,
      'chat': Icons.chat,
      'replay': Icons.replay,
      'contact_page': Icons.contact_page,
      'event': Icons.event,
      'auto_stories': Icons.auto_stories,
      'groups': Icons.groups,
      'person': Icons.person,
      'touch_app': Icons.touch_app,
      'science': Icons.science,
      'short_text': Icons.short_text,
      'movie': Icons.movie,
      'calendar_month': Icons.calendar_month,
      'handshake': Icons.handshake,
      'title': Icons.title,
      'description': Icons.description,
      'key': Icons.key,
      'block': Icons.block,
      'view_list': Icons.view_list,
      'web': Icons.web,
      'shopping_bag': Icons.shopping_bag,
      'play_circle': Icons.play_circle,
      'rocket_launch': Icons.rocket_launch,
      'call_to_action': Icons.call_to_action,
      'link': Icons.link,
      'list_alt': Icons.list_alt,
      'location_on': Icons.location_on,
      'autorenew': Icons.autorenew,
      'web_asset': Icons.web_asset,
      'trending_up': Icons.trending_up,
      'compare': Icons.compare,
      'speed': Icons.speed,
      'assessment': Icons.assessment,
      'search': Icons.search,
      'analytics': Icons.analytics,
      'checklist': Icons.checklist,
      'code': Icons.code,
      'account_tree': Icons.account_tree,
      'preview': Icons.preview,
      'smartphone': Icons.smartphone,
      'article': Icons.article,
      'inventory': Icons.inventory,
      'email': Icons.email,
      'share': Icons.share,
      'format_quote': Icons.format_quote,
      'campaign': Icons.campaign,
      'info': Icons.info,
      'help': Icons.help,
      'star': Icons.star,
      'format_list_bulleted': Icons.format_list_bulleted,
      'expand': Icons.expand,
      'compress': Icons.compress,
      'tune': Icons.tune,
      'spellcheck': Icons.spellcheck,
      'format_list_numbered': Icons.format_list_numbered,
      'start': Icons.start,
      'flag': Icons.flag,
      'flash_on': Icons.flash_on,
      'diamond': Icons.diamond,
      'psychology': Icons.psychology,
      'inventory_2': Icons.inventory_2,
      'store': Icons.store,
      'shopping_cart': Icons.shopping_cart,
      'rate_review': Icons.rate_review,
      'remove_shopping_cart': Icons.remove_shopping_cart,
      'local_offer': Icons.local_offer,
      'collections': Icons.collections,
      'straighten': Icons.straighten,
      'local_shipping': Icons.local_shipping,
      'assignment_return': Icons.assignment_return,
      'mail_outline': Icons.mail_outline,
      'waving_hand': Icons.waving_hand,
      'newspaper': Icons.newspaper,
      'water_drop': Icons.water_drop,
      'ac_unit': Icons.ac_unit,
      'forward_to_inbox': Icons.forward_to_inbox,
      'favorite': Icons.favorite,
      'smart_toy': Icons.smart_toy,
      'visibility': Icons.visibility,
      'dashboard': Icons.dashboard,
      'calculate': Icons.calculate,
      'filter_alt': Icons.filter_alt,
      'hub': Icons.hub,
      'attach_money': Icons.attach_money,
      'leaderboard': Icons.leaderboard,
      'work': Icons.work,
      'push_pin': Icons.push_pin,
      'music_note': Icons.music_note,
      'forum': Icons.forum,
      'image': Icons.image,
      'brush': Icons.brush,
      'palette': Icons.palette,
      'text_fields': Icons.text_fields,
      'photo_library': Icons.photo_library,
      'insert_chart': Icons.insert_chart,
      'emoji_emotions': Icons.emoji_emotions,
      'gif': Icons.gif,
      'design_services': Icons.design_services,
      'print': Icons.print,
      'signpost': Icons.signpost,
      'radio': Icons.radio,
      'tv': Icons.tv,
      'movie_creation': Icons.movie_creation,
      'animation': Icons.animation,
      'view_in_ar': Icons.view_in_ar,
      'bolt': Icons.bolt,
      'schedule': Icons.schedule,
      'score': Icons.score,
      'category': Icons.category,
      'notifications': Icons.notifications,
      'summarize': Icons.summarize,
      'warning': Icons.warning,
      'language': Icons.language,
      'sync_alt': Icons.sync_alt,
      'event_note': Icons.event_note,
      'account_balance': Icons.account_balance,
      'timeline': Icons.timeline,
      'target': Icons.gps_fixed,
      'auto_graph': Icons.auto_graph,
      'explore': Icons.explore,
      'insights': Icons.insights,
      'podcasts': Icons.podcasts,
      'sms': Icons.sms,
      'pie_chart': Icons.pie_chart,
      'mood': Icons.mood,
    };
    return icons[iconName] ?? Icons.auto_awesome;
  }
}
