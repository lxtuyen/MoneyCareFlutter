import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/notification_controller.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/presentation/widgets/icon/circular_icon.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  bool isDropdownOpen = false;
  final NotificationController notificationController = Get.find<NotificationController>();
  @override
  void initState() {
    super.initState();
    notificationController.getNotificationsByUser(widget.userId);
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: CircularIcon(
            iconPath: AppIcons.notification,
            backgroundColor: const Color(0XFFF5FAFE),
            height: 36,
            width: 36,
          ),
        ),

        Positioned(
          top: 40,
          right: 0,
          child: Visibility(
            visible: isDropdownOpen,
            child: Obx(() {
              if (notificationController.isLoading.value) {
                return Container(
                  width: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 6),
                    ],
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (notificationController.notifications.isEmpty) {
                return Container(
                  width: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 6),
                    ],
                  ),
                  child: const Center(child: Text("Không có thông báo")),
                );
              }

              return Container(
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: notificationController.notifications.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final notif = notificationController.notifications[index];
                    return ListTile(
                      title: Text(notif.title),
                      subtitle: Text(notif.message),
                      trailing:
                          notif.isRead
                              ? null
                              : const Icon(
                                Icons.circle,
                                size: 10,
                                color: Colors.blue,
                              ),
                      onTap: () {
                        notificationController.markAsRead(notif.id);
                        setState(() {
                          notif.isRead = true;
                        });
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
