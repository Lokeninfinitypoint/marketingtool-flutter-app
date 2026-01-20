import 'package:flutter/material.dart';

class ToolCategoryModel {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final String description;
  final int toolCount;

  const ToolCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    this.toolCount = 0,
  });

  factory ToolCategoryModel.fromJson(Map<String, dynamic> json) {
    return ToolCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: Color(int.parse(json['color'].toString().replaceFirst('#', '0xFF'))),
      description: json['description'] as String,
      toolCount: json['toolCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': '#${color.value.toRadixString(16).substring(2)}',
      'description': description,
      'toolCount': toolCount,
    };
  }

  ToolCategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    Color? color,
    String? description,
    int? toolCount,
  }) {
    return ToolCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      description: description ?? this.description,
      toolCount: toolCount ?? this.toolCount,
    );
  }
}
