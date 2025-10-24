import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.title,
    this.subtitle,
    this.date,
    this.color,
    required this.amount,
    required this.isShowDate,
    required this.onTap,
    this.isShowDivider = true,
    this.isExpense = true,
  });

  final String title;
  final String? subtitle;
  final String? date;
  final Color? color;
  final String amount;
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
                    color: color,
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
                      title,
                      style: const TextStyle(
                        fontSize: AppSizes.fontSizeSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    if (isExpense)
                      Text(
                        subtitle ?? "",
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
                      date ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.text5,
                      ),
                    ),
                  Text(
                    amount,
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
}
