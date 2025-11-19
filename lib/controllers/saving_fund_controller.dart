import 'package:get/get.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/models/saving_fund_model.dart';
import 'package:money_care/services/saving_fund_service.dart';

class SavingFundController extends GetxController {
  final SavingFundService service;

  SavingFundController({required this.service});

  RxList<SavingFundModel> savingFunds = <SavingFundModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> loadFunds(int userId) async {
    try {
      isLoading.value = true;
      final list = await service.getSavingFundsByUser(userId);
      savingFunds.assignAll(list);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectSavingFund(int userId, int id) async {
    try {
      isLoading.value = true;

      final selected = await service.selectSavingFund(userId, id);

      savingFunds.value = savingFunds.map((f) {
        f.isSelected = f.id == selected.id;
        return f;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createFund(
    String name,
    List<CategoryModel> categories,
    int userId
  ) async {
    final fund =
        await service.createSavingFund(name, categories, userId);

    savingFunds.add(fund);
  }

  Future<void> updateFund(
    int id,
    String name,
    List<CategoryModel> categories,
  ) async {
    final updated =
        await service.updateSavingFund(id, name, categories);

    final index = savingFunds.indexWhere((f) => f.id == id);
    if (index != -1) {
      savingFunds[index] = updated;
      savingFunds.refresh();
    }
  }

  Future<void> deleteFund(int id) async {
    final ok = await service.deleteSavingFund(id);
    if (ok) {
      savingFunds.removeWhere((f) => f.id == id);
    }
  }
}
