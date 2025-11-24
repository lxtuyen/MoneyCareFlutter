class TotalByDate {
  final DateTime date;
  final double total;

  TotalByDate({required this.date, required this.total});

  factory TotalByDate.fromJson(Map<String, dynamic> json) {
    final raw = DateTime.parse(json['date']).toLocal();

    return TotalByDate(
      date: DateTime(raw.year, raw.month, raw.day),
      total: (json['total'] ?? 0).toDouble(),
    );
  }
}
