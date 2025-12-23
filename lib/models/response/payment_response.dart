class PaymentResponse {
  final bool isSuccess;
  final String message;

  PaymentResponse({
    required this.isSuccess,
    required this.message,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      isSuccess: json['isSuccess'],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'message': message,
    };
  }
}
