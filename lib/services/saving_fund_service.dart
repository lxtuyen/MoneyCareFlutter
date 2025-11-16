import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/api_response.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/models/saving_fund_model.dart';
import 'api_service.dart';

class SavingFundService {
  final ApiService apiService;

  SavingFundService({required this.apiService});

  Future<SavingFundModel> createSavingFund(
    String name,
    List<CategoryModel> categories,
    int userId,
  ) async {
    final body = {
      'name': name,
      'categories': categories.map((c) => c.toJsonCreate()).toList(),
      'userId': userId,
    };

    final json = await apiService.post(ApiRoutes.savingFund, body);

    final res = ApiResponse.fromMap(json, (data) {
      return SavingFundModel.fromMap(data);
    });

    if (res.data == null) throw Exception(res.message);

    return res.data!;
  }

  Future<List<SavingFundModel>> getSavingFundsByUser(int userId) async {
    final json = await apiService.get("${ApiRoutes.getSavingFunds}/$userId");
    final res = ApiResponse.fromMap(json, (data) {
      return (data as List)
          .map((item) => SavingFundModel.fromMap(item))
          .toList();
    });

    return res.data ?? [];
  }

  Future<SavingFundModel> getSavingFund(int id) async {
    final json = await apiService.get("${ApiRoutes.savingFund}/$id");

    final res = ApiResponse.fromMap(json, (data) {
      return SavingFundModel.fromMap(data);
    });

    if (res.data == null) throw Exception(res.message);
    return res.data!;
  }

  Future<SavingFundModel> updateSavingFund(
    int id,
    String name,
    List<CategoryModel> categories,
  ) async {
    final body = {
      'name': name,
      'categories': categories.map((c) => c.toJson()).toList(),
    };

    final json = await apiService.put("${ApiRoutes.savingFund}/$id", body);

    final res = ApiResponse.fromMap(json, (data) {
      return SavingFundModel.fromMap(data);
    });

    if (res.data == null) throw Exception(res.message);

    return res.data!;
  }

  Future<bool> deleteSavingFund(int id) async {
    final json = await apiService.delete("${ApiRoutes.savingFund}/$id");

    final res = ApiResponse.fromMap(json, (data) => data);

    return res.statusCode == 200;
  }

  Future<SavingFundModel> selectSavingFund(int userId, int fundId) async {
    final body = {'userId': userId};

    final json = await apiService.patch(
      "${ApiRoutes.selectSavingFund}/$fundId",
      body,
    );

    final res = ApiResponse.fromMap(json, (data) {
      return SavingFundModel.fromMap(data);
    });

    if (res.data == null) throw Exception(res.message);

    return res.data!;
  }
}
