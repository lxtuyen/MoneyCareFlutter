import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: const Text("Bạn có chắc chắn muốn xóa không?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: const Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}