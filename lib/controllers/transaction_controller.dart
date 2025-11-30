import 'package:get/get.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/models/dto/transaction_filter_dto.dart';
import 'package:money_care/models/dto/transaction_totals_dto.dart';
import 'package:money_care/models/response/total_by_category.dart';
import 'package:money_care/models/response/total_by_date.dart';
import 'package:money_care/models/response/totals_by_date.dart';
import 'package:money_care/models/response/transaction_by_type.dart';
import '../services/transaction_service.dart';
import '../models/response/total_by_type.dart';
import '../models/dto/transaction_create_dto.dart';

class TransactionController extends GetxController {
  final TransactionService service;
  final SavingFundController fundController = Get.find<SavingFundController>();

  var totalByType = Rxn<TotalByType>();
  var transactionByfilter = Rxn<TransactionByType>();
  RxList<TotalByCategory> totalByCate = <TotalByCategory>[].obs;

  var totalByDate = Rxn<TotalsByDate>();
  var totalByDateLstMonth = Rxn<TotalsByDate>();

  var isLoading = false.obs;
  var errorMessage = RxnString();

  final now = DateTime.now();
  late DateTime monthStartDate = DateTime(now.year, now.month, 1);
  late DateTime monthEndDate = DateTime(now.year, now.month + 1, 0);
  DateTime get weekStartDate => now.subtract(const Duration(days: 6));
  DateTime get weekEndDate => now;

  TransactionController({required this.service});

  Future<void> createTransaction(TransactionCreateDto dto) async {
    try {
      await service.createTransaction(dto);
      await refreshAllData(dto.userId!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTransaction(TransactionCreateDto dto, int id) async {
    try {
      await service.updateTransaction(dto, id);
      await refreshAllData(dto.userId!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(int id, int userId) async {
    try {
      await service.deleteTransaction(id);
      await refreshAllData(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> filterTransactions(int userId, TransactionFilterDto dto) async {
    isLoading.value = true;
    try {
      transactionByfilter.value = await service.findAllByFilter(userId, dto);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTotalByType(int userId) async {
    isLoading.value = true;
    try {
      final dto = _createTotalsDto(monthStartDate, monthEndDate);
      totalByType.value = await service.getTotalByType(userId, dto);
      errorMessage.value = null;
    } catch (e) {
      totalByType.value = null;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTotalByCate(int userId) async {
    isLoading.value = true;
    try {
      final dto = _createTotalsDto(monthStartDate, monthEndDate);
      final list = await service.getTotalByCate(userId, dto);
      totalByCate.assignAll(list);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTotalByDate(int userId, TransactionTotalsDto dto) async {
    isLoading.value = true;
    try {
      totalByDate.value = await service.getTotalByDate(userId, dto);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTotalByDateLstMonth(int userId) async {
    isLoading.value = true;
    try {
      final dto = _createTotalsDto(lastMonth7DaysStart, lastMonthToday);
      totalByDateLstMonth.value = await service.getTotalByDate(userId, dto);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshAllData(int userId) async {
    final dtoWeek = _createTotalsDto(weekStartDate, weekEndDate);
    final filterDto = TransactionFilterDto(
      fundId:
          fundController.currentFundId > 0
              ? fundController.currentFundId
              : null,
      startDate: weekStartDate.toIso8601String(),
      endDate: weekEndDate.toIso8601String(),
    );

    await getTotalByType(userId);
    await getTotalByCate(userId);
    await getTotalByDate(userId, dtoWeek);
    await getTotalByDateLstMonth(userId);
    await filterTransactions(userId, filterDto);
  }

  TransactionTotalsDto _createTotalsDto(DateTime start, DateTime end) {
    return TransactionTotalsDto(
      fundId:
          fundController.currentFundId > 0
              ? fundController.currentFundId
              : null,
      startDate: start.toIso8601String(),
      endDate: end.toIso8601String(),
    );
  }

  DateTime get lastMonthToday {
    int month = now.month - 1;
    int year = month == 0 ? now.year - 1 : now.year;
    month = month == 0 ? 12 : month;
    return DateTime(year, month, now.day);
  }

  DateTime get lastMonth7DaysStart =>
      lastMonthToday.subtract(const Duration(days: 6));

  double calculateDailyAverage(List<TotalByDate> list, DateTime endDate) {
    final Map<String, double> map = {
      for (var d in list)
        "${d.date.year}-${d.date.month}-${d.date.day}": d.total,
    };

    if (list.isEmpty) return 0;

    final start = endDate.subtract(const Duration(days: 6));
    double sum = 0;

    for (int i = 0; i < 7; i++) {
      final d = start.add(Duration(days: i));
      final key = "${d.year}-${d.month}-${d.day}";
      sum += map[key] ?? 0.0;
    }

    return sum / 7;
  }

  double calculatePercentageChange(double current, double previous) {
    if (previous == 0) return 0;
    return ((current - previous) / previous) * 100;
  }

  double calculateMonthTotal(List<TotalByDate> list) {
    return list.fold(0, (prev, element) => prev + element.total);
  }

  double get dailyAverage =>
      calculateDailyAverage(totalByDate.value?.expense ?? [], now);

  double get lastWeekDailyAverage => calculateDailyAverage(
    totalByDateLstMonth.value?.expense ?? [],
    lastMonthToday,
  );

  double get dailyAverageChange =>
      calculatePercentageChange(dailyAverage, lastWeekDailyAverage);

  double get dailyIncomeAverage =>
      calculateDailyAverage(totalByDate.value?.income ?? [], now);

  double get lastWeekDailyIncomeAverage => calculateDailyAverage(
    totalByDateLstMonth.value?.income ?? [],
    lastMonthToday,
  );

  double get dailyIncomeChange =>
      calculatePercentageChange(dailyIncomeAverage, lastWeekDailyIncomeAverage);
}
