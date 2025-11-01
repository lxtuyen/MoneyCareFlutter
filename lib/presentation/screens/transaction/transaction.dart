import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/model/category_model.dart';
import 'package:money_care/model/transaction_model.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction/transaction_item.dart';
import 'package:money_care/presentation/screens/transaction/widgets/filter_dialog.dart';
import 'package:money_care/presentation/screens/transaction/widgets/transaction/transaction_detail.dart';
import 'package:money_care/presentation/widgets/icon/rounded_icon.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selected = 'chi';
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
      appBar: AppBar(
        title: const Text('Thu - chi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF2196F3),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Tháng này',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selected = 'chi'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    selected == 'chi'
                                        ? Colors.white
                                        : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                'Tiền chi',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '10.000.000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selected = 'thu'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    selected == 'thu'
                                        ? Colors.white
                                        : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                'Tiền thu',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '12.000.000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Tìm giao dịch',
                      hintStyle: const TextStyle(color: AppColors.text4),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderSecondary,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderPrimary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                RoundedIcon(
                  applyIconRadius: true,
                  iconPath: AppIcons.filter,
                  height: 24,
                  width: 24,
                  color: AppColors.text2,
                  onPressed: () {
                    _showFilterSheet(context);
                  },
                ),
              ],
            ),
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
