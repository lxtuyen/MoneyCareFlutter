import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/widgets/icon/rounded_icon.dart';

class SpendingLimitCard extends StatelessWidget {
  final String title;
  final String limitText;
  final String spentText;
  final String iconPath;
  final bool isOverLimit;

  const SpendingLimitCard({
    super.key,
    required this.title,
    required this.limitText,
    required this.spentText,
    required this.iconPath, required this.isOverLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppSizes.fontSizeMd,
            fontWeight: FontWeight.w600,
            color: AppColors.text4,
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon tròn
              RoundedIcon(
                padding: const EdgeInsets.all(AppSizes.sm),
                applyIconRadius: true,
                width: 40,
                height: 40,
                backgroundColor: AppColors.backgroundSecondary,
                iconPath: iconPath,
                size: AppSizes.lg,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),

              // Thông tin text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hạn mức:",
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeSm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text3,
                          ),
                        ),

                        Text(
                          limitText,
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeSm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Đã Tiêu:",
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeSm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text3,
                          ),
                        ),
                        isOverLimit ? Text(
                          spentText,
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeSm,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ) :
                        Text(
                          spentText,
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeSm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.defaultSpace),
      ],
    );
  }
}
