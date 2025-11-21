import 'package:flutter/material.dart';
import 'package:money_care/presentation/screens/statistics/widgets/chart_card.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Ăn uống ",
        "amount": "1.500.000",
        "percent": "63%",
        "limit": "5.000.000",
        "color": const Color(0xFF6A4DFF),
      },
      {
        "title": "Du lịch ",
        "amount": "1.500.000",
        "percent": "63%",
        "limit": "5.000.000",
        "color": const Color.fromARGB(255, 77, 205, 255),
      },
    ];

    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 12),
            ...categories.map(
              (item) => ChartCard(
                title: item['title'] as String,
                amount: item['amount'] as String,
                percent: item['percent'] as String,
                limit: item['limit'] as String,
                color: item['color'] as Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
