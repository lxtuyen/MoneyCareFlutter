class TotalByType {
  final int incomeTotal;
  final int expenseTotal;

  TotalByType({
    required this.incomeTotal,
    required this.expenseTotal,
  });

  factory TotalByType.fromJson(Map<String, dynamic> json) {
    return TotalByType(
      incomeTotal: (json['income_total'] ?? 0),
      expenseTotal: (json['expense_total'] ?? 0),
    );
  }
}
