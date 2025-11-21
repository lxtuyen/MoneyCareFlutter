import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/notification_model.dart';
import 'api_service.dart';

class NotificationService {
  final ApiService api;

  NotificationService({required this.api});

  Future<List<NotificationModel>> getNotificationsByUser(int userId) async {
    final res = await api.get<List<NotificationModel>>(
      "${ApiRoutes.getNotificationsByUser}/$userId",
      fromJsonT: (json) {
        final list = json as List;
        return list.map((e) => NotificationModel.fromJson(e)).toList();
      },
    );

    return res.data ?? [];
  }

  Future<NotificationModel> markAsRead(int id) async {
    final res = await api.patch<NotificationModel>(
      "${ApiRoutes.notification}/$id/read",
      fromJsonT: (json) => NotificationModel.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }
}
