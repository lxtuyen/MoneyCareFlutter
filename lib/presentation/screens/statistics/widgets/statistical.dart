import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/presentation/screens/statistics/widgets/tag_item.dart';

class StatisticalWidgets extends StatelessWidget {
  final String dateRange;
  final String totalAmount;
  final List<CategoryModel> categories;

  const StatisticalWidgets({
    super.key,
    required this.dateRange,
    required this.totalAmount,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.text5,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfo(),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      centerSpaceRadius: 25,
                      sectionsSpace: 2,
                      sections: categories.map(
                        (e) => PieChartSectionData(
                          /*color: e.color,
                          value: e.percentage,
                          title: '',*/
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),
            const Divider(),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map(
                (e) => TagItem(category: e),
              ).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppTexts.statisticsTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dateRange,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          totalAmount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
