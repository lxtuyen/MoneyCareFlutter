import 'package:flutter/material.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/models/response/total_by_category.dart';
import 'package:money_care/presentation/screens/home/widgets/category/category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.categories,
  });

  final List<TotalByCategory> categories;

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...categories.map((item) {
              return CategoryCard(
                title: item.categoryName,
                amount: item.total.toString(),
                percent: item.percentage.toString(),
                color: AppHelperFunction.getRandomColor(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
