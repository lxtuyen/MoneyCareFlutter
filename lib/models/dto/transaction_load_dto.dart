class TransactionLoadDto {
  final int? userId;
  final String? startDate;
  final String? endDate;

  TransactionLoadDto({this.userId, this.startDate, this.endDate});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
