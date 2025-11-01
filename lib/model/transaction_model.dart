import 'package:flutter/material.dart';
import 'category_model.dart';

class TransactionModel {
  final String title;
  final String? note;
  final String amount;
  final DateTime date;
  final Color? color;
  final CategoryModel? category;
  final bool isExpense;

  TransactionModel({
    required this.title,
    this.note,
    required this.amount,
    required this.date,
    this.color,
    this.category,
    this.isExpense = true,
  });
}
