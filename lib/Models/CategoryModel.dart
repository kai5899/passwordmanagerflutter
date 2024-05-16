import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class Category {
  int? id;
  String name;
  String color;
  IconData icon;
  String description;
  int createdAt;
  int updatedAt;

  Category({
    this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {

    IconData iconDataFromMap  = deserializeIcon(jsonDecode(json['icon']))!;
    return Category(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      icon:iconDataFromMap ,
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {

    String iconMap = jsonEncode(serializeIcon(icon));
    return {
      'id': id,
      'name': name,
      'color': color,
      'icon': iconMap,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
