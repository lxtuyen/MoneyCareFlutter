import 'package:flutter/material.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/bar_row.dart';

class TopRevenueCard extends StatelessWidget {
  const TopRevenueCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top hạng mục chi tiêu',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          BuildBarRow(title: 'Ăn uống', percent: '95 %'),
          const SizedBox(height: 6),
          BuildBarRow(title: 'Di chuyển', percent: '20 %'),
          const SizedBox(height: 6),
          BuildBarRow(title: 'Giải trí', percent: '15 %'),
        ],
      ),
    );
  }
}
