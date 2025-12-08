import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';

class BuildBarRow extends StatelessWidget {
  const BuildBarRow({super.key, required this.title, required this.percent});

  final String title;
  final String percent;

  // Hàm convert '95 %' / '95%' / '95' -> 0.95
  double _getWidthFactor() {
    // Lọc lấy số, bỏ khoảng trắng và dấu %
    final cleaned = percent.replaceAll(RegExp(r'[^0-9.]'), '');
    final value = double.tryParse(cleaned) ?? 0;
    // Đổi sang 0–1 và clamp cho chắc
    return (value / 100).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final widthFactor = _getWidthFactor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Stack(
          children: [
            // Thanh nền
            Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFE5EDF7),
              ),
            ),
            // Thanh màu chính, dài theo percent
            FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(percent, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
