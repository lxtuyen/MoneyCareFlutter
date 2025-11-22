class TransactionTotalsDto {
  final String? startDate;
  final String? endDate;

  TransactionTotalsDto({ this.startDate, this.endDate});

  Map<String, dynamic> toJson() {
    return {'startDate': startDate, 'endDate': endDate};
  }
}
