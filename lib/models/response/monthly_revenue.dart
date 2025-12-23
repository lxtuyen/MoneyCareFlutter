class MonthlyRevenue {
  final int month;
  final double total;

  MonthlyRevenue({
    required this.month,
    required this.total,
  });

  factory MonthlyRevenue.fromJson(Map<String, dynamic> json) {
    return MonthlyRevenue(
      month: json['month'],
      total: (json['total'] as num).toDouble(),
    );
  }
}
