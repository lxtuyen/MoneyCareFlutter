import 'package:money_care/models/transaction_model.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  bool isRead;
  final DateTime createdAt;
  final TransactionModel? transaction;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.transaction,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      isRead: json['is_read'] ?? false,
      transaction:
          json['transaction'] != null
              ? TransactionModel.fromJsonSummary(json['transaction'])
              : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'type': type,
    'is_read': isRead,
    'transaction': transaction?.toJson(),
    'created_at': createdAt.toIso8601String(),
  };
}
