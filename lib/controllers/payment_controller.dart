import 'package:get/get.dart';
import 'package:money_care/models/dto/payment_dto.dart';
import 'package:money_care/models/response/monthly_revenue.dart';
import 'package:money_care/services/payment_service.dart';

class PaymentController extends GetxController {
  final PayMentService service;

  PaymentController({required this.service});

  var isLoading = false.obs;
  var payment = false.obs;
  RxList<MonthlyRevenue> monthlyRevenue = <MonthlyRevenue>[].obs;

  Future<bool> confirm(PaymentRequest dto) async {
    try {
      isLoading.value = true;

      final isSuccess = await service.confirm(dto);
      payment.value = true;
      return isSuccess;
    } finally {
      isLoading.value = false;
    }
  }
  Future<List<MonthlyRevenue>> getMonthlyRevenue() async {
    try {
      isLoading.value = true;

      final data = await service.getMonthlyRevenue();
      monthlyRevenue.value = data;
      return data;
    } finally {
      isLoading.value = false;
    }
  }
}
