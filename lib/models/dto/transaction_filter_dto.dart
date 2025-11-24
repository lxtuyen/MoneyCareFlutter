class TransactionFilterDto {
  final int userId;
  final String? type;
  final String? note;
  final int? categoryId;
  final String? startDate;
  final String? endDate;

  TransactionFilterDto({
    required this.userId,
    this.type,
    this.categoryId,
    this.note, 
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toQueryParams() {
    final map = <String, dynamic>{};
    if (type != null) map['type'] = type;
    if (note != null) map['note'] = note;
    if (categoryId != null) map['categoryId'] = categoryId;
    if (startDate != null) map['start_date'] = startDate;
    if (endDate != null) map['end_date'] = endDate;
    return map;
  }
}
