
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_care/services/payment_api.dart';
import 'payment_configs.dart';
// ...existing code...;
import 'payment_configs.dart';
import 'package:pay/pay.dart';

class PlanPaywallPage extends StatefulWidget {
  const PlanPaywallPage({super.key});

  @override
  State<PlanPaywallPage> createState() => _PlanPaywallPageState();
}

class _PlanPaywallPageState extends State<PlanPaywallPage> {
  final _api = PaymentApi();
  bool _busy = false;
  bool _isPlanUnlocked = false;

  // ví dụ items
  List<PaymentItem> get _items => const [
        PaymentItem(
          label: 'Mở khóa tính năng Premium',
          amount: '50.000',
          status: PaymentItemStatus.final_price,
        ),
      ];

  Future<void> _handleResult({
  required String platform,
  required Map<String, dynamic> result,
}) async {
  if (_busy) return;

  setState(() => _busy = true);
  try {
    final resp = await _api.confirmPremium(
      platform: platform,
      amount: 50.000,
      currency: 'VND',
      paymentData: result,
    );

    if (!mounted) return;

    if (resp['success'] == true) {
      setState(() => _isPlanUnlocked = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanh toán thành công! Premium đã mở khóa.')),
      );
    } else {
      throw Exception(resp['message'] ?? 'Payment failed');
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thanh toán thất bại: $e')),
    );
  } finally {
    if (mounted) setState(() => _busy = false);
  }
}

  Widget _buildGooglePay() {
    return GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: _items,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: (result) async {
        // result là dynamic => ép sang Map
        final map = Map<String, dynamic>.from(result as Map);
        await _handleResult(platform: 'google_pay', result: map);
      },
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildApplePay() {
    return ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: _items,
      style: ApplePayButtonStyle.black,
      type: ApplePayButtonType.buy,
      width: 250,
      height: 50,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: (result) async {
        final map = Map<String, dynamic>.from(result as Map);
        await _handleResult(platform: 'apple_pay', result: map);
      },
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = !kIsWeb && Platform.isIOS;
    final isAndroid = !kIsWeb && Platform.isAndroid;

    return Scaffold(
      appBar: AppBar(title: const Text('Mở khóa Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    _isPlanUnlocked ? Icons.verified : Icons.lock,
                    color: _isPlanUnlocked ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _isPlanUnlocked
                          ? 'Premium đã được mở khóa'
                          : 'Premium đang bị khóa – thanh toán để mở',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            if (_busy) const LinearProgressIndicator(),

            const SizedBox(height: 10),

            if (!_isPlanUnlocked) ...[
              if (isAndroid) _buildGooglePay(),
              if (isIOS) _buildApplePay(),
              if (!isAndroid && !isIOS)
                const Text('Thiết bị này không hỗ trợ GooglePay/ApplePay.'),
            ],

            const Spacer(),

          
          ],
        ),
      ),
    );
  }
}
