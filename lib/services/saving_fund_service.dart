import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/models/saving_fund_model.dart';
import 'api_service.dart';

class SavingFundService {
  final ApiService api;

  SavingFundService({required this.api});

  Future<SavingFundModel> createSavingFund(
    String name,
    List<CategoryModel> categories,
    int userId,
  ) async {
    final res = await api.post<SavingFundModel>(
      ApiRoutes.savingFund,
      body: {
        'name': name,
        'categories': categories.map((c) => c.toJsonCreate()).toList(),
        'userId': userId,
      },
      fromJsonT: (json) => SavingFundModel.fromMap(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<List<SavingFundModel>> getSavingFundsByUser(int userId) async {
    final res = await api.get<List<SavingFundModel>>(
      "${ApiRoutes.getSavingFunds}/$userId",
      fromJsonT: (json) {
        final list = json as List;
        return list.map((e) => SavingFundModel.fromMap(e)).toList();
      },
    );

    return res.data ?? [];
  }

  Future<SavingFundModel> getSavingFund(int id) async {
    final res = await api.get<SavingFundModel>(
      "${ApiRoutes.savingFund}/$id",
      fromJsonT: (json) => SavingFundModel.fromMap(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<SavingFundModel> updateSavingFund(
    int id,
    String name,
    List<CategoryModel> categories,
  ) async {
    final res = await api.put<SavingFundModel>(
      "${ApiRoutes.savingFund}/$id",
      body: {
        'name': name,
        'categories': categories.map((c) => c.toJson()).toList(),
      },
      fromJsonT: (json) => SavingFundModel.fromMap(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<bool> deleteSavingFund(int id) async {
    final res = await api.delete<void>(
      "${ApiRoutes.savingFund}/$id",
    );

    return res.success;
  }

  Future<SavingFundModel> selectSavingFund(int userId, int fundId) async {
    final res = await api.patch<SavingFundModel>(
      "${ApiRoutes.selectSavingFund}/$fundId",
      body: {'userId': userId},
      fromJsonT: (json) => SavingFundModel.fromMap(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }
}
