import 'package:money_care/models/category_model.dart';

class TransactionModel {
  final int? id;
  final int amount;
  final String type;
  final DateTime? transactionDate;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final CategoryModel? category;

  TransactionModel({
    this.id,
    required this.amount,
    required this.type,
    this.transactionDate,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] ?? 0),
      type: json['type'] ?? '',
      transactionDate:
          json['transaction_date'] != null
              ? DateTime.parse(json['transaction_date'])
              : null,
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),

      category:
          json['category'] != null
              ? CategoryModel.fromJson(json['category'])
              : null,
    );
  }

  factory TransactionModel.fromJsonSummary(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] ?? 0),
      type: json['type'] ?? '',
      transactionDate:
          json['transaction_date'] != null
              ? DateTime.parse(json['transaction_date'])
              : null,
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'type': type,
    'transaction_date': transactionDate?.toIso8601String(),
    'note': note,
    'created_at': createdAt!.toIso8601String(),
    'updated_at': updatedAt!.toIso8601String(),
    'category': category?.toJson(),
  };
}
