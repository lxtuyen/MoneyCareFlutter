import 'package:money_care/models/response/total_by_date.dart';

class TotalsByDate {
  final List<TotalByDate> income;
  final List<TotalByDate> expense;

  TotalsByDate({
    required this.income,
    required this.expense,
  });
  
  factory TotalsByDate.fromJson(Map<String, dynamic> json) {
    return TotalsByDate(
      income:
          (json['income'] as List<dynamic>)
              .map((e) => TotalByDate.fromJson(e))
              .toList(),
      expense:
          (json['expense'] as List<dynamic>)
              .map((e) => TotalByDate.fromJson(e))
              .toList(),
    );
  }
}
