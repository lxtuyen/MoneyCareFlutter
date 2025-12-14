import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.item,
    required this.onTap,
    this.isShowDate = true,
    this.isShowDivider = true, this.color,
  });

  final TransactionModel item;
  final bool isShowDate;
  final bool isShowDivider;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.note ?? "",
                      style: const TextStyle(
                        fontSize: AppSizes.fontSizeSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      item.category?.name ?? 'Không có danh mục',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.text4,
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
                      _formatDate(item.transactionDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.text4,
                      ),
                    ),
                  Text(
                    AppHelperFunction.formatCurrency(item.amount.toString()),
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

  static String _formatDate(DateTime? date) {
    final now = DateTime.now();
    if (date!.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Hôm nay';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}
