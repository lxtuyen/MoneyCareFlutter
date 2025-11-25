class ScanResponse {
  final String rawText;
  final String merchantName;
  final String address;
  final String date;
  final int totalAmount;
  final String currency;
  final String categoryKey;
  final String categoryName;

  ScanResponse({
    required this.rawText,
    required this.merchantName,
    required this.address,
    required this.date,
    required this.totalAmount,
    required this.currency,
    required this.categoryKey,
    required this.categoryName,
  });

  factory ScanResponse.fromJson(Map<String, dynamic> json) {
    return ScanResponse(
      rawText: json['raw_text'] ?? '',
      merchantName: json['merchant_name'] ?? '',
      address: json['address'] ?? '',
      date: json['date'] ?? '',
      totalAmount: json['total_amount'] ?? 0,
      currency: json['currency'] ?? '',
      categoryKey: json['category_key'] ?? '',
      categoryName: json['category_name'] ?? '',
    );
  }
}
