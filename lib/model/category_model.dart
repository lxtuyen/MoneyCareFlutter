import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String percent; // hoặc int để tính toán dễ hơn
  final IconData icon;

  const CategoryModel({
    required this.name,
    required this.percent,
    required this.icon,
  });

  // ✅ Factory để convert từ Map -> Model (nếu sau này lấy từ database)
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      percent: map['percent'],
      icon: map['icon'],
    );
  }

  // ✅ Convert ngược lại Model -> Map (để lưu vào database)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'percent': percent,
      'icon': icon,
    };
  }
}

