import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'dart:convert';


class Password {
  int? id; //auto generate
  String site; //application
  String auth; //
  String password;
  int categoryId;
  int createdAt;
  int updatedAt;
  IconData icon;

  Password({
    this.id,
    required this.site,
    required this.auth,
    required this.password,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.icon,
  });

  factory Password.fromJson(Map<String, dynamic> json) {
    IconData iconDataFromMap  = deserializeIcon(jsonDecode(json['icon']))!;
    return Password(
      id: json['id'],
      site: json['site'],
      auth: json['auth'],
      icon: iconDataFromMap,
      password: json['password'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {

    String iconMap = jsonEncode(serializeIcon(icon));
    return {
      'id': id,
      'site': site,
      'auth': auth,
      'icon': iconMap,
      'password': password,
      'category_id': categoryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}