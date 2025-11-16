class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final String? message;

  ApiResponse({
    required this.statusCode,
    this.data,
    this.message,
  });

  factory ApiResponse.fromMap(
    Map<String, dynamic> json,
    T Function(dynamic) convert,
  ) {
    return ApiResponse(
      statusCode: json['statusCode'],
      data: json['data'] != null ? convert(json['data']) : null,
      message: json['message'],
    );
  }
}
