import 'package:get/get.dart';
import 'package:money_care/models/dto/transaction_filter_dto.dart';
import 'package:money_care/models/dto/transaction_load_dto.dart';
import '../services/transaction_service.dart';
import '../models/transaction_model.dart';
import '../models/response/transaction_totals.dart';
import '../models/dto/transaction_create_dto.dart';

class TransactionController extends GetxController {
  final TransactionService service;

  var transactions = <TransactionModel>[].obs;
  var totals = Rxn<TransactionTotals>();
  var isLoading = false.obs;
  var errorMessage = RxnString();

  TransactionController({required this.service});

  Future<void> loadTransactions(int userId) async {
    isLoading.value = true;

    try {
      final list = await service.findAllByUser(userId);
      transactions.assignAll(list);
      errorMessage.value = null;
    } catch (e) {
      transactions.clear();
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }

  Future<void> getTotals(TransactionLoadDto dto) async {
    isLoading.value = true;

    try {
      totals.value = await service.getTotals(dto);
      errorMessage.value = null;
    } catch (e) {
      totals.value = null;
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
      totals.value = null;
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTransaction(TransactionCreateDto dto, int id) async {
    try {
      final updated = await service.updateTransaction(dto, id);
      final index = transactions.indexWhere((t) => t.id == id);
      if (index != -1) transactions[index] = updated;
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

  Future<void> filterTransactions(TransactionFilterDto filter) async {
    isLoading.value = true;

    try {
      final list = await service.findAllByFilter(filter);
      transactions.assignAll(list);
      errorMessage.value = null;
    } catch (e) {
      transactions.clear();
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }
}
