import 'package:flutter/material.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/toggle_chip.dart';

class BuildOverviewCard extends StatelessWidget {
  final bool isWeekSelected;
  final VoidCallback onWeekTap;
  final VoidCallback onMonthTap;
  const BuildOverviewCard({
    super.key,
    required this.isWeekSelected,
    required this.onWeekTap,
    required this.onMonthTap,
  });

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
          // Title + toggle Tuần / Tháng
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overview',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFE9F2FB),
                ),
                child: Row(
                  children: [
                    BuildToggleChip(
                      label: 'Tuần',
                      isSelected: isWeekSelected,
                      onTap: onWeekTap,
                    ),
                    const SizedBox(width: 4),
                    BuildToggleChip(
                      label: 'Tháng',
                      isSelected: !isWeekSelected,
                      onTap: onMonthTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF7FAFF),
              ),
              child: const Center(
                child: Text(
                  'Biểu đồ (demo)',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
