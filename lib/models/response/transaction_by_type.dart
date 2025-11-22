import 'package:money_care/models/transaction_model.dart';

class TransactionByType {
  final List<TransactionModel> incomeTransactions;
  final List<TransactionModel> expenseTransactions;

  TransactionByType({
    required this.incomeTransactions,
    required this.expenseTransactions,
  });
  
  factory TransactionByType.fromJson(Map<String, dynamic> json) {
    return TransactionByType(
      incomeTransactions:
          (json['income'] as List<dynamic>)
              .map((e) => TransactionModel.fromJson(e))
              .toList(),
      expenseTransactions:
          (json['expense'] as List<dynamic>)
              .map((e) => TransactionModel.fromJson(e))
              .toList(),
    );
  }
}
