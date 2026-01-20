class ToolModel {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String icon;
  final String webUrl;
  final bool isPremium;
  final List<String> tags;
  final double rating;
  bool isFavorite;
  int usageCount;
  DateTime? lastUsed;

  ToolModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.icon,
    required this.webUrl,
    this.isPremium = false,
    this.tags = const [],
    this.rating = 4.5,
    this.isFavorite = false,
    this.usageCount = 0,
    this.lastUsed,
  });

  factory ToolModel.fromJson(Map<String, dynamic> json) {
    return ToolModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      icon: json['icon'] as String? ?? 'auto_awesome',
      webUrl: json['webUrl'] as String,
      isPremium: json['isPremium'] as bool? ?? false,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      isFavorite: json['isFavorite'] as bool? ?? false,
      usageCount: json['usageCount'] as int? ?? 0,
      lastUsed: json['lastUsed'] != null
          ? DateTime.parse(json['lastUsed'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'icon': icon,
      'webUrl': webUrl,
      'isPremium': isPremium,
      'tags': tags,
      'rating': rating,
      'isFavorite': isFavorite,
      'usageCount': usageCount,
      'lastUsed': lastUsed?.toIso8601String(),
    };
  }

  ToolModel copyWith({
    String? id,
    String? name,
    String? description,
    String? categoryId,
    String? icon,
    String? webUrl,
    bool? isPremium,
    List<String>? tags,
    double? rating,
    bool? isFavorite,
    int? usageCount,
    DateTime? lastUsed,
  }) {
    return ToolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      icon: icon ?? this.icon,
      webUrl: webUrl ?? this.webUrl,
      isPremium: isPremium ?? this.isPremium,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      usageCount: usageCount ?? this.usageCount,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }
}
