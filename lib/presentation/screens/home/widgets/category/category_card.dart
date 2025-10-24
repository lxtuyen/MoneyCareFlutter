import 'package:flutter/material.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/widgets/container/rounded_container.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.percent,
    required this.color,
  });

  final String title;
  final String amount;
  final String percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppSizes.fontSizeSm,
                fontWeight: FontWeight.w500,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.fontSizeMd,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RoundedContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  backgroundColor: Colors.white.withOpacity(0.15),
                  child: Text(
                    percent,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.fontSizeSm,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
