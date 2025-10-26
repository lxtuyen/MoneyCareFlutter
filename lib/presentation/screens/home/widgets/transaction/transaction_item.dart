import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/model/transcation_model.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.item,
    required this.onTap,
    this.isShowDate = true,
    this.isShowDivider = true,
    this.isExpense = true,
  });

  final TransactionModel item;
  final bool isShowDate;
  final bool isShowDivider;
  final bool isExpense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isExpense)
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.color, // ✅ lấy màu từ Model
                    shape: BoxShape.circle,
                  ),
                ),
              if (isExpense)
                const SizedBox(width: AppSizes.spaceBtwItems),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title, // ✅ lấy từ Model
                      style: const TextStyle(
                        fontSize: AppSizes.fontSizeSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    if (isExpense)
                      Text(
                        item.subtitle, // ✅ lấy subtitle từ Model
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.text5,
                        ),
                      ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isShowDate)
                    Text(
                      _formatDate(item.date), // ✅ đổi DateTime => text
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.text5,
                      ),
                    ),
                  Text(
                    item.amount,
                    style: const TextStyle(
                      fontSize: AppSizes.fontSizeMd,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          if (isShowDivider)
            const Divider(
              color: AppColors.borderSecondary,
              height: AppSizes.dividerHeight,
            ),
        ],
      ),
    );
  }

  /// ✅ format DateTime để hiển thị giống UI cũ ('Hôm nay')
  static String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Hôm nay';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}
