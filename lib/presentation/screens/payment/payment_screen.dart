import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/payment_controller.dart';
import 'package:money_care/models/dto/payment_dto.dart';
import 'package:money_care/presentation/screens/payment/payment_configs.dart';
import 'package:pay/pay.dart';

class PlanPaywallPage extends StatefulWidget {
  const PlanPaywallPage({super.key});

  @override
  State<PlanPaywallPage> createState() => _PlanPaywallPageState();
}

class _PlanPaywallPageState extends State<PlanPaywallPage> {
  final paymentController = Get.find<PaymentController>();

  bool _isPlanUnlocked = false;

  List<PaymentItem> get _items => const [
        PaymentItem(
          label: 'Mở khóa tính năng VIP',
          amount: '50000',
          status: PaymentItemStatus.final_price,
        ),
      ];

  Future<void> _handleResult({
    required String platform,
    required Map<String, dynamic> result,
  }) async {
    final dto = PaymentRequest(
      platform: platform,
      amount: 50000,
      currency: 'VND', userId: 1,
    );

    final success = await paymentController.confirm(dto);

    if (!mounted) return;

    if (success) {
      setState(() => _isPlanUnlocked = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanh toán thành công! Premium đã mở khóa.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanh toán thất bại')),
      );
    }
  }

  Widget _buildGooglePay() {
    return GooglePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: _items,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.only(top: 15),
      onPaymentResult: (result) async {
        await _handleResult(
          platform: 'google_pay',
          result: Map<String, dynamic>.from(result as Map),
        );
      },
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildApplePay() {
    return ApplePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: _items,
      type: ApplePayButtonType.buy,
      style: ApplePayButtonStyle.black,
      width: 250,
      height: 50,
      margin: const EdgeInsets.only(top: 15),
      onPaymentResult: (result) async {
        await _handleResult(
          platform: 'apple_pay',
          result: Map<String, dynamic>.from(result as Map),
        );
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
            Obx(() => paymentController.isLoading.value
                ? const LinearProgressIndicator()
                : const SizedBox()),

            const SizedBox(height: 10),

            Container(
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
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            if (!_isPlanUnlocked) ...[
              if (isAndroid) _buildGooglePay(),
              if (isIOS) _buildApplePay(),
              if (!isAndroid && !isIOS)
                const Text('Thiết bị không hỗ trợ GooglePay/ApplePay'),
            ],

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
