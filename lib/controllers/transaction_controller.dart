import 'package:get/get.dart';
import 'package:money_care/models/dto/transaction_totals_dto.dart';
import 'package:money_care/models/response/total_by_category.dart';
import 'package:money_care/models/response/total_by_date.dart';
import 'package:money_care/models/response/transaction_by_type.dart';
import '../services/transaction_service.dart';
import '../models/transaction_model.dart';
import '../models/response/total_by_type.dart';
import '../models/dto/transaction_create_dto.dart';

class TransactionController extends GetxController {
  final TransactionService service;

  var transactions = <TransactionModel>[].obs;
  var totalByType = Rxn<TotalByType>();
  var transactionByType = Rxn<TransactionByType>();
  RxList<TotalByCategory> totalByCate = <TotalByCategory>[].obs;
  RxList<TotalByDate> totalByDate = <TotalByDate>[].obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();
  final now = DateTime.now();
  late DateTime monthStartDate = DateTime(now.year, now.month, 1);
  late DateTime monthEndDate = DateTime(now.year, now.month + 1, 0);
  DateTime get weekStartDate => now.subtract(const Duration(days: 6));
  DateTime get weekEndDate => now;

  TransactionController({required this.service});

  Future<void> getTotalByType(int userId) async {
    isLoading.value = true;

    try {
      final dto = TransactionTotalsDto(
        startDate: monthStartDate.toIso8601String(),
        endDate: monthEndDate.toIso8601String(),
      );
      totalByType.value = await service.getTotalByType(userId, dto);
      errorMessage.value = null;
    } catch (e) {
      totalByType.value = null;
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }

  Future<void> getTransactionByType(int userId) async {
    isLoading.value = true;

    try {
      transactionByType.value = await service.findLatest4ByTypePerUser(userId);
      errorMessage.value = null;
    } catch (e) {
      transactionByType.value = null;
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }

  Future<void> getTotalByDate(int userId, TransactionTotalsDto dto) async {
    isLoading.value = true;

    try {
      totalByDate.value = await service.getTotalByDate(userId, dto);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }

  Future<void> getTotalByCate(int userId) async {
    isLoading.value = true;

    try {
      final dto = TransactionTotalsDto(
        startDate: monthStartDate.toIso8601String(),
        endDate: monthEndDate.toIso8601String(),
      );
      final list = await service.getTotalByCate(userId, dto);
      totalByCate.assignAll(list);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }

  Future<TransactionModel?> loadById(int id) async {
    isLoading.value = true;

    try {
      errorMessage.value = null;
      return await service.findById(id);
    } catch (e) {
      errorMessage.value = e.toString();
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTransaction(TransactionCreateDto dto) async {
    try {
      final newTransaction = await service.createTransaction(dto);
      transactions.insert(0, newTransaction);

      await getTotalByType(dto.userId!);
      await getTotalByCate(dto.userId!);
      await getTransactionByType(dto.userId!);

      final dateDto = TransactionTotalsDto(
        startDate: weekStartDate.toIso8601String(),
        endDate: weekEndDate.toIso8601String(),
      );
      await getTotalByDate(dto.userId!, dateDto);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTransaction(TransactionCreateDto dto, int id) async {
    try {
      final updated = await service.updateTransaction(dto, id);
      final index = transactions.indexWhere((t) => t.id == id);
      if (index != -1) transactions[index] = updated;

      await getTotalByType(dto.userId!);
      await getTotalByCate(dto.userId!);
      await getTransactionByType(dto.userId!);

      final dateDto = TransactionTotalsDto(
        startDate: weekStartDate.toIso8601String(),
        endDate: weekEndDate.toIso8601String(),
      );
      await getTotalByDate(dto.userId!, dateDto);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      final success = await service.deleteTransaction(id);
      if (success) transactions.removeWhere((t) => t.id == id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> filterTransactions(int userId) async {
    isLoading.value = true;

    try {
      final list = await service.findAllByFilter(userId);
      transactions.assignAll(list);
      errorMessage.value = null;
    } catch (e) {
      transactions.clear();
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }
}
