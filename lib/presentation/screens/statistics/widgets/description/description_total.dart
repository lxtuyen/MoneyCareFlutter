import 'package:flutter/material.dart';
import 'package:money_care/presentation/screens/statistics/widgets/description/description_item.dart';

class DescriptionTotal extends StatelessWidget {
  const DescriptionTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Trung bình chi theo ngày",
        "value": "500.000",
        "percent": "-2%",
      },
      {
        "title": "Số dư tháng này",
        "value": "2.000.000",
        "percent": "+11%",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DescriptionItem(
                  title: item['title'] as String,
                  value: item['value'] as String,
                  percent: item['percent'] as String,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
