import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/pending_transaction_controller.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/pending_transaction.dart';
import 'package:money_care/models/transaction_model.dart';
import 'package:money_care/models/user_model.dart';
import 'package:money_care/presentation/screens/transaction/widgets/transaction/transaction_form.dart';

class PendingTransactionsScreen extends StatefulWidget {
  const PendingTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<PendingTransactionsScreen> createState() =>
      _PendingTransactionsScreenState();
}

class _PendingTransactionsScreenState extends State<PendingTransactionsScreen> {
  late final PendingTransactionController controller;
  Timer? _timer;
  late int userId;

  static const Duration _pollingInterval = Duration(minutes: 1);

  @override
  void initState() {
    super.initState();
    controller = Get.find<PendingTransactionController>();
    _initUserAndFetch();
  }

  Future<void> _initUserAndFetch() async {
    final storage = StorageService();
    final userInfoJson = storage.getUserInfo();

    if (userInfoJson == null) {
      controller.errorMessage.value = 'Không tìm thấy thông tin người dùng';
      return;
    }

    final user = UserModel.fromJson(userInfoJson, '');
    userId = user.id;

    await controller.fetchPendingTransactions(userId);

    _startPolling();
  }

  void _startPolling() {
    _timer?.cancel();

    _timer = Timer.periodic(_pollingInterval, (_) {
      controller.fetchPendingTransactions(userId);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _confirmTransaction(
    BuildContext context,
    PendingTransaction pendingTransaction,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Xác nhận giao dịch'),
            content: Text(
              'Bạn có chắc chắn muốn xác nhận giao dịch '
              '${AppHelperFunction.formatAmount(pendingTransaction.amount, pendingTransaction.currency)}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  final transaction = TransactionModel(
                    amount: pendingTransaction.amount.toInt(),
                    type:
                        pendingTransaction.direction == 'OUT'
                            ? 'expense'
                            : 'income',
                    transactionDate: pendingTransaction.transactionTime,
                    note:
                        "${pendingTransaction.description} đến ${pendingTransaction.receiverName}",
                  );
                  await controller.confirm(pendingTransaction.id);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => TransactionForm(
                            title:
                                pendingTransaction.direction == 'OUT'
                                    ? 'Chỉnh sửa chi'
                                    : 'Chỉnh sửa thu',
                            item: transaction,
                            showCategory: pendingTransaction.direction == 'OUT',
                          ),
                    ),
                  );
                },
                child: const Text('Xác nhận'),
              ),
            ],
          ),
    );
  }

  void _deleteTransaction(
    BuildContext context,
    PendingTransaction transaction,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Xóa giao dịch'),
            content: const Text('Bạn có chắc chắn muốn xóa giao dịch này?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  Navigator.pop(context);
                  await controller.reject(transaction.id);
                },
                child: const Text('Xóa'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao dịch chờ xác nhận'),
        actions: [
          Obx(
            () =>
                controller.hasTransactions
                    ? Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Center(
                        child: Text(
                          '${controller.transactionCount}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    : const SizedBox(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.pendingTransactions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty &&
            controller.pendingTransactions.isEmpty) {
          return _buildError();
        }

        if (controller.pendingTransactions.isEmpty) {
          return _buildEmpty();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.pendingTransactions.length,
          itemBuilder: (context, index) {
            final transaction = controller.pendingTransactions[index];
            return _buildTransactionCard(transaction);
          },
        );
      }),
    );
  }

  Widget _buildTransactionCard(PendingTransaction transaction) {
    final isOut = transaction.direction == 'OUT';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isOut ? Colors.red.shade50 : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isOut ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isOut ? Colors.red : Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isOut ? 'Chuyển tiền' : 'Nhận tiền',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${transaction.description} đến ${transaction.receiverName}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppHelperFunction.formatDateTime(
                          transaction.transactionTime,
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isOut ? '-' : '+'}${AppHelperFunction.formatAmount(transaction.amount, transaction.currency)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isOut ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => _deleteTransaction(context, transaction),
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () => _confirmTransaction(context, transaction),
                  icon: const Icon(Icons.check_circle_outline),
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            controller.errorMessage.value,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Không có giao dịch nào',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
