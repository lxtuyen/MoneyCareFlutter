import 'package:flutter/material.dart';

class StatisticsHeader extends StatelessWidget {
  final String selected;
  final Function(String) onSelected;
  final String title;
  final String monthText;
  final String spendText;
  final String incomeText;

  const StatisticsHeader({
    super.key,
    required this.selected,
    required this.onSelected,
    this.title = "Thống kê",
    this.monthText = "Tháng này",
    this.spendText = "10.000.000",
    this.incomeText = "12.000.000",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    monthText,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildSelectCard(
                    label: "Tiền chi",
                    value: spendText,
                    isActive: selected == 'chi',
                    onTap: () => onSelected('chi'),
                  ),
                  const SizedBox(width: 12),
                  _buildSelectCard(
                    label: "Tiền thu",
                    value: incomeText,
                    isActive: selected == 'thu',
                    onTap: () => onSelected('thu'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectCard({
    required String label,
    required String value,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(
                color: isActive ? Colors.white : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
