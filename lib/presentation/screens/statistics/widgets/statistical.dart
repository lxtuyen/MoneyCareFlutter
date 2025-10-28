import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/presentation/screens/statistics/widgets/tag_item.dart';

class StatisticalWidgets extends StatelessWidget {
  const StatisticalWidgets({super.key});

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
              color: Colors.black12,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      AppTexts.statisticsTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "01/10/2025 - 31/10/2025",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "10.000.000",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      centerSpaceRadius: 25,
                      sectionsSpace: 2,
                      sections: [
                        PieChartSectionData(
                          color: Color(0xFF0B84FF),
                          value: 40,
                          title: '',
                        ),
                        PieChartSectionData(
                          color: Colors.orange,
                          value: 25,
                          title: '',
                        ),
                        PieChartSectionData(
                          color: Colors.purple,
                          value: 20,
                          title: '',
                        ),
                        PieChartSectionData(
                          color: Colors.green,
                          value: 15,
                          title: '',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                TagItem("40% Chi tiêu", Color(0xFF0B84FF)),
                TagItem("25% Ăn uống", Colors.orange),
                TagItem("20% Giải trí", Colors.purple),
                TagItem("15% Tiết kiệm", Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
