import 'package:get/get.dart';
import 'package:money_care/models/dto/payment_dto.dart';
import 'package:money_care/services/payment_service.dart';

class PaymentController extends GetxController {
  final PayMentService service;

  PaymentController({required this.service});

  var isLoading = false.obs;

  Future<bool> confirm(PaymentRequest dto) async {
    try {
      isLoading.value = true;

      final isSuccess = await service.confirm(dto);

      return isSuccess;
    } finally {
      isLoading.value = false;
    }
  }
}
