import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/dto/transaction_create_dto.dart';
import 'package:money_care/models/dto/transaction_totals_dto.dart';
import 'package:money_care/models/response/total_by_category.dart';
import 'package:money_care/models/response/total_by_date.dart';
import 'package:money_care/models/response/total_by_type.dart';
import 'package:money_care/models/response/transaction_by_type.dart';
import 'package:money_care/models/transaction_model.dart';
import 'api_service.dart';

class TransactionService {
  final ApiService api;

  TransactionService({required this.api});

  Future<List<TransactionModel>> findAllByFilter(
    int userId 
  ) async {
    final res = await api.get<List<TransactionModel>>(
      "${ApiRoutes.getTransactionsByUser}/$userId",
      fromJsonT: (json) {
        final list = (json as List<dynamic>);
        return list.map((e) => TransactionModel.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) throw Exception(res.message);
    return res.data!;
  }

  Future<TransactionByType> findLatest4ByTypePerUser(int userId) async {
    final res = await api.get<TransactionByType>(
      "${ApiRoutes.getTransactionsByType}/$userId",
      fromJsonT: (json) => TransactionByType.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

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

  Future<TotalByType> getTotalByType(
    int userId,
    TransactionTotalsDto dto,
  ) async {
    final res = await api.get<TotalByType>(
      "${ApiRoutes.transaction}/$userId/total-by-type",
      queryParameters: dto.toJson(),
      fromJsonT: (json) => TotalByType.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<List<TotalByCategory>> getTotalByCate(
    int userId,
    TransactionTotalsDto dto,
  ) async {
    final res = await api.get<List<TotalByCategory>>(
      "${ApiRoutes.transaction}/$userId/total-by-category",
      queryParameters: dto.toJson(),
      fromJsonT: (json) {
        final list = json as List<dynamic>;
        return list.map((e) => TotalByCategory.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) throw Exception(res.message);
    return res.data ?? [];
  }

    Future<List<TotalByDate>> getTotalByDate(
    int userId,
    TransactionTotalsDto dto,
  ) async {
    final res = await api.get<List<TotalByDate>>(
      "${ApiRoutes.transaction}/$userId/total-by-day",
      queryParameters: dto.toJson(),
      fromJsonT: (json) {
        final list = json as List<dynamic>;
        return list.map((e) => TotalByDate.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) throw Exception(res.message);
    return res.data ?? [];
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
      "${ApiRoutes.transaction}/$id",
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
