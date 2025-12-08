import 'package:flutter/material.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/stat_card.dart';

class BuildUserStatsGrid extends StatelessWidget {
  const BuildUserStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StatCard(title: 'Tổng người dùng', value: '1.200'),
        StatCard(title: 'Tổng số giao dịch', value: '3.500'),
        StatCard(title: 'Tổng tài khoản VIP', value: '100'),
        StatCard(title: 'Tổng phí thu từ VIP', value: 'đ 45.000.000'),
      ],
    );
  }
}
