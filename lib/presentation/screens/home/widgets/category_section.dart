import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/screens/home/widgets/category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, this.onAddCategory});

  final VoidCallback? onAddCategory;

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Cần thiết",
        "amount": "1.000.000",
        "percent": "55%",
        "color": const Color(0xFF6A4DFF),
      },
    ];

    if (categories.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onAddCategory,
            child: Container(
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.backgroundPrimary,
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
              ),
              child: const Center(
                child: Icon(Icons.add, color: AppColors.text5, size: 28),
              ),
            ),
          ),

          const SizedBox(width: AppSizes.defaultSpace),
          Expanded(
            child: Text(
              "Tạo hoặc lựa chọn quỹ tiết kiệm để chúng tôi giúp bạn quản lý tài chính hiệu quả",
              style: TextStyle(
                color: AppColors.text4,
                fontSize: AppSizes.fontSizeSm,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Nút thêm (+)
            GestureDetector(
              onTap: onAddCategory,
              child: Container(
                width: 50,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.backgroundPrimary,
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: AppColors.text5, size: 28),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ...categories.map(
              (item) => CategoryCard(
                title: item['title'] as String,
                amount: item['amount'] as String,
                percent: item['percent'] as String,
                color: item['color'] as Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
