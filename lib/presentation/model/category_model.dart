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
final List<CategoryModel> categories = [
  const CategoryModel(name: 'Cần thiết', percent: '55%', icon: Icons.shopping_bag),
  const CategoryModel(name: 'Đào tạo', percent: '10%', icon: Icons.school),
  const CategoryModel(name: 'Hưởng thụ', percent: '10%', icon: Icons.spa),
  const CategoryModel(name: 'Tiết kiệm', percent: '10%', icon: Icons.savings),
  const CategoryModel(name: 'Từ thiện', percent: '5%', icon: Icons.volunteer_activism),
];
