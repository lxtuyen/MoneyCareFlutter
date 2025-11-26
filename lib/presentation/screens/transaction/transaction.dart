import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_care/controllers/filter_controller.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/dto/transaction_filter_dto.dart';
import 'package:money_care/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:money_care/models/user_model.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction/transaction_item.dart';
import 'package:money_care/presentation/screens/statistics/widgets/statistics_header.dart';
import 'package:money_care/presentation/screens/transaction/widgets/filter_dialog.dart';
import 'package:money_care/presentation/screens/transaction/widgets/search_filter.dart';
import 'package:money_care/presentation/screens/transaction/widgets/transaction/transaction_detail.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selected = 'chi';
  TextEditingController searchController = TextEditingController();
  String searchKeyword = '';
  late int userId;

  final TransactionController transactionController =
      Get.find<TransactionController>();
  final SavingFundController savingFundController =
      Get.find<SavingFundController>();
  final FilterController filterController = Get.find<FilterController>();

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  Future<void> initUserInfo() async {
    Map<String, dynamic> userInfoJson = StorageService().getUserInfo()!;
    UserModel user = UserModel.fromJson(userInfoJson, '');
    savingFundController.loadFundById(user.savingFund!.id);
    setState(() {
      userId = user.id;
    });
    loadSavingFundData();
  }

  Future<void> loadSavingFundData() async {
    transactionController.filterTransactions(
      userId,
      TransactionFilterDto(
        startDate: filterController.startDate.toString(),
        endDate: filterController.endDate.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 195,
            decoration: const BoxDecoration(
              color: Color(0xFF0B84FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Obx(() {
              final data = transactionController.totalByType.value;

              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (data == null) {
                return StatisticsHeader(
                  selected: selected,
                  onSelected: (value) => setState(() => selected = value),
                  title: "Thu - Chi",
                  spendText: "0",
                  incomeText: "0",
                );
              }

              return StatisticsHeader(
                selected: selected,
                onSelected: (value) => setState(() => selected = value),
                title: "Thu - Chi",
                spendText: data.expenseTotal.toString(),
                incomeText: data.incomeTotal.toString(),
              );
            }),
          ),

          SearchWithFilter(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchKeyword = value;
              });
            },
            onFilterTap: () => _showFilterSheet(context),
          ),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  selected == 'chi' ? _buildExpenseList() : _buildIncomeList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList() {
    return Obx(() {
      if (transactionController.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final data = transactionController.transactionByfilter.value;

      if (data == null || data.expenseTransactions.isEmpty) {
        return _buildEmptyView();
      }
      final filtered =
          data.expenseTransactions.where((t) {
            final note = t.note?.toLowerCase() ?? '';
            final keyword = searchKeyword.toLowerCase();
            return note.contains(keyword);
          }).toList();

      if (filtered.isEmpty) {
        return _buildEmptyView();
      }

      return ListView(
        key: const ValueKey('chi'),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children:
            filtered.map((item) {
              return TransactionItem(
                color: AppHelperFunction.getRandomColor(),
                item: item,
                isShowDate: true,
                onTap: () => _showTransactionDetail(context, item),
              );
            }).toList(),
      );
    });
  }

  Widget _buildIncomeList() {
    return Obx(() {
      if (transactionController.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final data = transactionController.transactionByfilter.value;

      if (data == null || data.incomeTransactions.isEmpty) {
        return _buildEmptyView();
      }

      final filtered =
          data.incomeTransactions.where((t) {
            final note = t.note?.toLowerCase() ?? '';
            final keyword = searchKeyword.toLowerCase();
            return note.contains(keyword);
          }).toList();

      if (filtered.isEmpty) return _buildEmptyView();

      return ListView(
        key: const ValueKey('thu'),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children:
            filtered.map((item) {
              return TransactionItem(
                color: AppHelperFunction.getRandomColor(),
                item: item,
                isShowDate: true,
                onTap: () => _showTransactionDetail(context, item),
              );
            }).toList(),
      );
    });
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppIcons.emptyFolder, width: 150, height: 150),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const Text(
            'Không có giao dịch nào gần đây',
            style: TextStyle(fontSize: 16, color: AppColors.text5),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetail(BuildContext context, TransactionModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return TransactionDetail(item: item, isExpense: selected == 'chi', userId: userId);
      },
    );
  }

  void _showCategoryFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Obx(() {
            final data = savingFundController.currentFund.value;

            if (savingFundController.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (data != null) {
              return FilterDialog(
                title: "Lọc theo phân loại",
                categories: data.categories,
                onApply: (result) {
                  _applyFilter();
                },
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }

  void _showTimeFilterDialog(context) {
    showDialog(
      context: context,
      builder:
          (_) => FilterDialog(
            title: 'Lọc theo thời gian',
            items: const ['Hôm nay', 'Tuần này', 'Tháng này'],
            onApply: (result) {
              _applyFilter();
            },
          ),
    );
  }

  void _applyFilter() {
    transactionController.filterTransactions(
      userId,
      TransactionFilterDto(
        categoryId: filterController.categoryId.toInt(),
        startDate: filterController.startDate.toString(),
        endDate: filterController.endDate.toString(),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Bộ lọc giao dịch',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: AppSizes.dividerHeight),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: const Text('Lọc theo phân loại'),
              onTap: () {
                Get.back();
                _showCategoryFilterDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time_outlined),
              title: const Text('Lọc theo thời gian'),
              onTap: () {
                Get.back();
                _showTimeFilterDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
