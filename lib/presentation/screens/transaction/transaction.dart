import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/model/category_model.dart';
import 'package:money_care/model/transaction_model.dart';
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
    final List<TransactionModel> transactions = [
    TransactionModel(
      title: 'Tiền siêu thị',
      note: 'Chi tiêu hằng ngày',
      amount: '250.000',
      date: DateTime.now(),
      color: Colors.purple,
      category: const CategoryModel(
        name: 'Cần thiết',
        percent: '55%',
        icon: Icons.shopping_bag,
      ),
    ),
  ];

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
            child: StatisticsHeader(
              selected: selected,
              onSelected: (value) => setState(() => selected = value),
              title: "Thu - Chi",
              spendText: "5.500.000",
              incomeText: "9.900.000",
            ),
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
    return ListView(
      key: const ValueKey('chi'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Text(
          'Hôm nay',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.text1),
        ),
        const SizedBox(height: 8),

        ...transactions.map((item) {
          return TransactionItem(
            item: item,
            isShowDate: false,
            onTap: () => _showTransactionDetail(context, item),
          );
        }),
      ],
    );
  }

  final List<TransactionModel> incomes = [
    TransactionModel(
      title: 'Nhặt được',
      note: "Tiền lẻ",
      amount: '250.000',
      date: DateTime.now(),
      color: Colors.orange,
      isExpense: false,
    ),
  ];

  Widget _buildIncomeList() {
    return ListView(
      key: const ValueKey('thu'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Text(
          'Hôm nay',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.text1),
        ),
        const SizedBox(height: 8),

        ...incomes.map((item) {
          return TransactionItem(
            item: item,
            isShowDate: true,
            onTap: () => _showTransactionDetail(context, item),
          );
        }),
      ],
    );
  }

  void _showTransactionDetail(BuildContext context, TransactionModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return TransactionDetail(
          item: item,
          isExpense: selected == 'chi',
        );
      },
    );
  }

  void _showCategoryFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => FilterDialog(
            title: "Lọc theo phân loại",
            items: const ['Ăn uống', 'Mua sắm', 'Giải trí', 'Đi lại'],
            multiSelect: true,
            onApply: (selectedCategories) {
              print("Chọn: $selectedCategories");
            },
          ),
    );
  }

  void _showTimeFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => FilterDialog(
            title: "Lọc theo thời gian",
            items: const ['Hôm nay', 'Tuần này', 'Tháng này', 'Tùy chỉnh...'],
            multiSelect: false,
            onApply: (selectedTime) {
              print("Chọn: $selectedTime");
            },
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
                Navigator.pop(context);
                _showCategoryFilterDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time_outlined),
              title: const Text('Lọc theo thời gian'),
              onTap: () {
                Navigator.pop(context);
                _showTimeFilterDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
