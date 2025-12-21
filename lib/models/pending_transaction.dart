class PendingTransaction {
  final String id;
  final double amount;
  final String currency;
  final String direction;
  final DateTime transactionTime;
  final String? description;
  final String? receiverName;

  PendingTransaction({
    required this.id,
    required this.amount,
    required this.currency,
    required this.direction,
    required this.transactionTime,
    this.description,
    this.receiverName,
  });

  factory PendingTransaction.fromJson(Map<String, dynamic> json) {
    return PendingTransaction(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      direction: json['direction'],
      transactionTime: DateTime.parse(json['transactionTime']),
      description: json['description'],
      receiverName: json['receiverName'],
    );
  }
}
