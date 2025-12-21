class ApiResponse<T> {
  final bool success;
  final String message;
  final int statusCode;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    final rawMessage = json['message'];

    String message;
    if (rawMessage is String) {
      message = rawMessage;
    } else if (rawMessage is List) {
      message = rawMessage.join('\n');
    } else {
      message = rawMessage?.toString() ?? '';
    }

    return ApiResponse<T>(
      success: json['success'] ?? (json['statusCode'] == 200),
      message: message,
      statusCode: json['statusCode'] ?? 0,
      data:
          fromJsonT != null && json['data'] != null
              ? fromJsonT(json['data'])
              : null,
    );
  }
}
