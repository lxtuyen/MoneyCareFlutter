import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/dto/transaction_create_dto.dart';
import 'package:money_care/models/dto/transaction_filter_dto.dart';
import 'package:money_care/models/dto/transaction_load_dto.dart';
import 'package:money_care/models/response/transaction_totals.dart';
import 'package:money_care/models/transaction_model.dart';
import 'api_service.dart';

class TransactionService {
  final ApiService api;

  TransactionService({required this.api});

  Future<List<TransactionModel>> findAllByUser(int userId) async {
    final res = await api.get<List<TransactionModel>>(
      "${ApiRoutes.getTransactionsByUser}/$userId",
      fromJsonT: (json) {
        final list = json as List;
        return list.map((e) => TransactionModel.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data ?? [];
  }

  Future<List<TransactionModel>> findAllByFilter(
    TransactionFilterDto dto,
  ) async {
    final res = await api.get<List<TransactionModel>>(
      "${ApiRoutes.getTransactionsByUser}/${dto.userId}",
      queryParameters: dto.toQueryParams(),
      fromJsonT: (json) {
        final list = (json as List<dynamic>);
        return list.map((e) => TransactionModel.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) throw Exception(res.message);
    return res.data!;
  }

  Future<TransactionModel> findById(int id) async {
    final res = await api.get<TransactionModel>(
      "${ApiRoutes.transaction}/$id",
      fromJsonT: (json) => TransactionModel.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<TransactionTotals> getTotals(TransactionLoadDto dto) async {
    final res = await api.get<TransactionTotals>(
      "${ApiRoutes.totalTransactions}/${dto.userId}&start_date=${dto.startDate}&end_date=${dto.endDate}",
      fromJsonT: (json) => TransactionTotals.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<TransactionModel> createTransaction(TransactionCreateDto dto) async {
    final res = await api.post<TransactionModel>(
      ApiRoutes.transaction,
      body: dto.toJson(),
      fromJsonT: (json) => TransactionModel.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<TransactionModel> updateTransaction(
    TransactionCreateDto dto,
    int id,
  ) async {
    final res = await api.put<TransactionModel>(
      "${ApiRoutes.getTransactionsByUser}/$id",
      body: dto.toJson(),
      fromJsonT: (json) => TransactionModel.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<bool> deleteTransaction(int id) async {
    final res = await api.delete<void>("${ApiRoutes.transaction}/$id");

    return res.success;
  }
}
