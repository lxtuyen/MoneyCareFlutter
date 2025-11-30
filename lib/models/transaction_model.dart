import 'package:money_care/models/category_model.dart';
import 'package:money_care/models/notification_model.dart';

class TransactionModel {
  final int id;
  final int amount;
  final String type;
  final DateTime? transactionDate;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  final CategoryModel? category;

  final List<NotificationModel>? notifications;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    this.transactionDate,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.notifications,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] ?? 0).toDouble(),
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

      notifications:
          json['notifications'] != null
              ? (json['notifications'] as List)
                  .map((e) => NotificationModel.fromJson(e))
                  .toList()
              : null,
    );
  }

  factory TransactionModel.fromJsonSummary(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] ?? 0).toDouble(),
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
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'category': category?.toJson(),
    'notifications': notifications!.map((e) => e.toJson()).toList(),
  };
}
