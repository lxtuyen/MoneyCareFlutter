import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/api_responese.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  StorageService get _storage => StorageService();

  Map<String, String> _headers() {
    final token = _storage.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, dynamic>? body,
    T Function(dynamic)? fromJsonT,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$path'),
      headers: _headers(),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response, fromJsonT);
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    T Function(dynamic)? fromJsonT,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$path'),
      headers: _headers(),
    );

    return _handleResponse(response, fromJsonT);
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    Map<String, dynamic>? body,
    T Function(dynamic)? fromJsonT,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$path'),
      headers: _headers(),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response, fromJsonT);
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    T Function(dynamic)? fromJsonT,
  }) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$path'),
      headers: _headers(),
    );

    return _handleResponse(response, fromJsonT);
  }

  Future<ApiResponse<T>> patch<T>(
    String path, {
    Map<String, dynamic>? body,
    T Function(dynamic)? fromJsonT,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$path'),
      headers: _headers(),
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response, fromJsonT);
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(dynamic)? fromJsonT,
  ) {
    final body = jsonDecode(response.body);
    return ApiResponse<T>.fromJson(body, fromJsonT);
  }
}
