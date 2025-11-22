import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/models/transaction_model.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction/transaction_item.dart';

class TransactionSection extends StatefulWidget {
  const TransactionSection({
    super.key,
    required this.incomeTransactions,
    required this.expenseTransactions,
  });

  final List<TransactionModel> incomeTransactions;
  final List<TransactionModel> expenseTransactions;

  @override
  State<TransactionSection> createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    final currentList =
        isExpense ? widget.expenseTransactions : widget.incomeTransactions;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            ),
            child: Row(
              children: [
                _buildTab("Chi", isExpense),
                _buildTab("Thu", !isExpense),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.defaultSpace),

          if (currentList.isEmpty)
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppIcons.emptyFolder,
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const Text(
                    'Không có giao dịch nào gần đây',
                    style: TextStyle(fontSize: 16, color: AppColors.text5),
                  ),
                ],
              ),
            )
          else
            ...currentList.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TransactionItem(item: item, onTap: () {}),
              ),
            ),
        ],
      ),
    );
  }

  Expanded _buildTab(String label, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isExpense = (label == "Chi")),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
