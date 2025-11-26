class TransactionFilterDto {
  final int? categoryId;
  final String? startDate;
  final String? endDate;

  TransactionFilterDto({
    this.categoryId,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toQueryParams() {
    final map = <String, dynamic>{};
    if (categoryId != null) map['categoryId'] = categoryId;
    if (startDate != null) map['start_date'] = startDate;
    if (endDate != null) map['end_date'] = endDate;
    return map;
  }

  factory TransactionFilterDto.fromJson(Map<String, dynamic> json) {
    return TransactionFilterDto(
      categoryId: json['categoryId'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}
