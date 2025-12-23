import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/dto/payment_dto.dart';
import 'package:money_care/models/response/monthly_revenue.dart';
import 'api_service.dart';

class PayMentService {
  final ApiService api;

  PayMentService({required this.api});

  Future<bool> confirm(PaymentRequest dto) async {
    final res = await api.post<bool>(
      ApiRoutes.paymentconfirm,
      body: dto.toJson(),
    );

    if (!res.success) {
      throw Exception(res.message);
    }

    return res.success;
  }

  Future<List<MonthlyRevenue>> getMonthlyRevenue() async {
    final res = await api.get<List<MonthlyRevenue>>(
      ApiRoutes.getMonthlyRevenue,
      fromJsonT: (json) {
        final list = json as List;
        return list.map((e) => MonthlyRevenue.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }
}
