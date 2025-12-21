class TotalByCategory {
  final String categoryName;
  final String categoryIcon;
  final int percentage;
  final int total;

  TotalByCategory({
    required this.categoryName,
    required this.categoryIcon,
    required this.percentage,
    required this.total,
  });

  factory TotalByCategory.fromJson(Map<String, dynamic> json) {
    return TotalByCategory(
      categoryName: json['categoryName'] ?? '',
      categoryIcon: json['categoryIcon'] ?? '',
      percentage: json['percentage'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'categoryIcon': categoryIcon,
      'percentage': percentage,
      'total': total,
    };
  }
}
