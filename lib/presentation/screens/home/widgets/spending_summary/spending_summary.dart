import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';

class SpendingSummary extends StatelessWidget {
  const SpendingSummary({
    super.key,
    required this.balance,
    required this.spending,
    this.onPressed,
  });

  final String balance;
  final String spending;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF7FF),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // bên trái
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Số tiền bạn chi trong tháng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text2,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onPressed,
                child: Row(
                  children: const [
                    Text(
                      'Xem chi tiết',
                      style: TextStyle(color: AppColors.primary, fontSize: 14),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: AppSizes.md,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                child: SvgPicture.asset(
                  AppIcons.chart2,
                  width: 150,
                  height: 70,
                ),
              ),
            ],
          ),
          // bên phải
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(AppSizes.borderRadiusLg),
            dashPattern: const [6, 3],
            color: AppColors.text4,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    spending,
                    style: const TextStyle(
                      color: AppColors.secondaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Số dư: $balance',
                    style: const TextStyle(
                      color: AppColors.text3,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
