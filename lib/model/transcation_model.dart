import 'package:flutter/material.dart';
import 'category_model.dart';

class TransactionModel {
  final String title;
  final String? subtitle;
  final String amount;
  final DateTime date;
  final Color? color;
  final CategoryModel? category;
  final bool isExpense;

  TransactionModel({
    required this.title,
    this.subtitle,
    required this.amount,
    required this.date,
    this.color,
    this.category,
    this.isExpense = true,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'],
      subtitle: map['subtitle'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      color: Color(map['color']),
      category: CategoryModel.fromMap(map['category']),
      isExpense: map['isExpense'] ?? true,
    );
  }
}
