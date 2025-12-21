import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/pending_transaction.dart';
import 'package:money_care/services/api_service.dart';

class PendingTransactionService {
  final ApiService api;

  PendingTransactionService({required this.api});

  Future<List<PendingTransaction>> getPendingTransactions(int userId) async {
    final res = await api.get<List<PendingTransaction>>(
      "${ApiRoutes.pendingTransactions}/$userId",
      fromJsonT: (json) {
        final list = json as List<dynamic>;
        return list
            .map((e) => PendingTransaction.fromJson(e))
            .toList();
      },
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<void> confirmTransaction(String id) async {
    final res = await api.post<void>(
      '${ApiRoutes.pendingTransactions}/$id/confirm',
    );

    if (!res.success) {
      throw Exception(res.message);
    }
  }

  Future<void> rejectTransaction(String id) async {
    final res = await api.delete<void>(
      '${ApiRoutes.pendingTransactions}/$id',
    );

    if (!res.success) {
      throw Exception(res.message);
    }
  }
}
