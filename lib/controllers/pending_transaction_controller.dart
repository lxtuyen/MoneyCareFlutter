import 'package:get/get.dart';
import 'package:money_care/models/pending_transaction.dart';
import 'package:money_care/services/pending_transaction_service.dart';

class PendingTransactionController extends GetxController {
  final PendingTransactionService service;

  PendingTransactionController({required this.service});

  final pendingTransactions = <PendingTransaction>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> fetchPendingTransactions(int userId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await service.getPendingTransactions(userId);
      pendingTransactions.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Lỗi',
        'Không thể tải giao dịch: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirm(String id) async {
    try {
      isLoading.value = true;

      await service.confirmTransaction(id);
      pendingTransactions.removeWhere((e) => e.id == id);
    } catch (e) {
      Get.snackbar('Lỗi', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reject(String id) async {
    try {
      isLoading.value = true;

      await service.rejectTransaction(id);
      pendingTransactions.removeWhere((e) => e.id == id);

      Get.snackbar(
        'Đã xoá',
        'Biên lai đã bị loại bỏ',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Lỗi', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  bool get hasTransactions => pendingTransactions.isNotEmpty;
  int get transactionCount => pendingTransactions.length;
}
