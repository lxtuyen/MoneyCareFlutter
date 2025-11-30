import 'package:flutter/material.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/presentation/screens/statistics/widgets/description/description_item.dart';

class DescriptionTotal extends StatelessWidget {
  const DescriptionTotal({
    super.key,
    required this.dailyAverage,
    required this.dailyAverageChange,
    required this.monthlyBalance,
    required this.monthlyBalanceChange,
  });
  final String dailyAverage;
  final String dailyAverageChange;
  final String monthlyBalance;
  final String monthlyBalanceChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DescriptionItem(
            title: 'Trung bình chi theo ngày',
            value: AppHelperFunction.formatCurrency(dailyAverage),
            percent: dailyAverageChange,
          ),
          const SizedBox(height: 8),

          DescriptionItem(
            title: 'Số dư tháng này',
            value: AppHelperFunction.formatCurrency(monthlyBalance),
            percent: monthlyBalanceChange,
          ),
        ],
      ),
    );
  }
}
