import 'package:get/get.dart';
import 'package:money_care/models/notification_model.dart';
import 'package:money_care/services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService service;

  NotificationController({required this.service});

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  Future<List<NotificationModel>> getNotificationsByUser(int userId) async {
    try {
      isLoading.value = true;

      final data =
          await service.getNotificationsByUser(userId);

      notifications.value = data;

      return data;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      isLoading.value = true;

      await service.markAsRead(id);
    } finally {
      isLoading.value = false;
    }
  }
}
