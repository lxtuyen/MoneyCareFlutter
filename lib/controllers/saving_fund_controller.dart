import 'package:get/get.dart';
import 'package:money_care/models/dto/saving_fund_dto.dart';
import 'package:money_care/models/saving_fund_model.dart';
import 'package:money_care/services/saving_fund_service.dart';

class SavingFundController extends GetxController {
  final SavingFundService service;

  SavingFundController({required this.service});

  RxList<SavingFundModel> savingFunds = <SavingFundModel>[].obs;
  Rxn<SavingFundModel> currentFund = Rxn<SavingFundModel>();
  RxBool isLoadingFunds = false.obs;
  RxBool isLoadingCurrent = false.obs;
  RxString? errorMessage = RxString('');
  var fundId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(fundId, (_) {
      if (fundId.value > 0) {
        loadFundById();
      }
    });
  }

  void updateFundId(int id) {
    fundId.value = id;
  }

  Future<void> loadFunds(int userId) async {
    try {
      isLoadingFunds.value = true;
      final list = await service.getSavingFundsByUser(userId);
      savingFunds.assignAll(list);
    } catch (e) {
      errorMessage?.value = e.toString();
    } finally {
      isLoadingFunds.value = false;
    }
  }

  Future<void> loadFundById() async {
    try {
      isLoadingCurrent.value = true;
      currentFund.value = await service.getSavingFund(fundId.value);
    } catch (e) {
      errorMessage?.value = e.toString();
    } finally {
      isLoadingCurrent.value = false;
    }
  }

  Future<void> selectSavingFund(int userId, int id) async {
    try {
      isLoadingCurrent.value = true;

      final selected = await service.selectSavingFund(userId, id);
      updateFundId(id);

      for (var f in savingFunds) {
        f.isSelected = f.id == selected.id;
      }
      savingFunds.refresh();

      currentFund.value = selected;
    } catch (e) {
      errorMessage?.value = e.toString();
    } finally {
      isLoadingCurrent.value = false;
    }
  }

  Future<void> createFund(SavingFundDto dto) async {
    try {
      final fund = await service.createSavingFund(dto);
      savingFunds.add(fund);
      savingFunds.refresh();
    } catch (e) {
      errorMessage?.value = e.toString();
    }
  }

  Future<void> updateFund(SavingFundDto dto) async {
    try {
      final updated = await service.updateSavingFund(dto);

      final index = savingFunds.indexWhere((f) => f.id == dto.id);
      if (index != -1) {
        savingFunds[index] = updated;
        savingFunds.refresh();
      }

      if (currentFund.value?.id == dto.id) {
        currentFund.value = updated;
      }
    } catch (e) {
      errorMessage?.value = e.toString();
    }
  }

  Future<void> deleteFund(int id) async {
    try {
      final ok = await service.deleteSavingFund(id);
      if (ok) {
        savingFunds.removeWhere((f) => f.id == id);
        savingFunds.refresh();

        if (currentFund.value?.id == id) {
          currentFund.value = null;
          fundId.value = 0;
        }
      }
    } catch (e) {
      errorMessage?.value = e.toString();
    }
  }

  int get currentFundId => fundId.value;

  SavingFundModel? get selectedFund => currentFund.value;
}
