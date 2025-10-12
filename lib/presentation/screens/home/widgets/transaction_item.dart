import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.iconColor,
    required this.amount,
  });

  final String title;
  final String subtitle;
  final String date;
  final Color iconColor;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
            ),
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
                  Text(
                    subtitle,
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
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: AppColors.text5),
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
        const Divider(color: AppColors.borderSecondary, height: AppSizes.dividerHeight),
      ],
    );
  }
}
