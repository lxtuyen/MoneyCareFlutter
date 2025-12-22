import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:money_care/data/storage_service.dart';

class PaymentApi {
  String get _baseUrl {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://127.0.0.1:3000';
  }

  Future<Map<String, dynamic>> confirmPremium({
    required String platform, // google_pay / apple_pay
    required double amount,   // demo
    required String currency, // USD
    required Map<String, dynamic> paymentData,
  }) async {
    final userInfo = StorageService().getUserInfo();
    final userId = userInfo?['id']; 

final uri = Uri.parse('$_baseUrl/premium-payments/confirm');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,        // demo
        'platform': platform,
        'amount': amount,
        'currency': currency,
        'paymentData': paymentData,
      }),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
