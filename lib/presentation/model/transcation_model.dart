import 'package:flutter/material.dart';
import 'category_model.dart';

class TransactionModel {
  final String title;
  final String subtitle;
  final String amount; // hoặc chuyển sang double tuỳ bạn
  final DateTime date;
  final Color color;
  final CategoryModel? category; // ✅ cho phép null

  TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.color,
    required this.category,
  });

  // 👉 Convert để lưu vào Firestore/DB (tạm thời loại bỏ Color vì không lưu trực tiếp được)
  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'subtitle': subtitle,
  //     'amount': amount,
  //     'date': date.toIso8601String(),
  //     'color': color.value,
  //     'category': category.toMap(),
  //   };
  // }

  // 👉 Convert từ Firestore/DB
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'],
      subtitle: map['subtitle'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      color: Color(map['color']),
      category: CategoryModel.fromMap(map['category']),
    );
  }
}
