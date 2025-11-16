import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String percentage; // hoặc int để tính toán dễ hơn
  final IconData? icon;
  final String? color;

  const CategoryModel({
    required this.name,
    required this.percentage,
    this.icon,
    this.color
  });

  // ✅ Factory để convert từ Map -> Model (nếu sau này lấy từ database)
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      percentage: map['percentage'],
      icon: map['icon'],
    );
  }

  // ✅ Convert ngược lại Model -> Map (để lưu vào database)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'percentage': percentage,
      'icon': icon,
    };
  }
}
