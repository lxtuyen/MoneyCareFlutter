class TransactionTotals {
  final double incomeTotal;
  final double expenseTotal;

  TransactionTotals({
    required this.incomeTotal,
    required this.expenseTotal,
  });

  factory TransactionTotals.fromJson(Map<String, dynamic> json) {
    return TransactionTotals(
      incomeTotal: (json['income_total'] ?? 0).toDouble(),
      expenseTotal: (json['expense_total'] ?? 0).toDouble(),
    );
  }
}
