import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/widgets/icon/rounded_icon.dart';
import 'package:intl/intl.dart';

class SpendingOverviewCard extends StatelessWidget {
  const SpendingOverviewCard({
    super.key,
    this.startDate,
    this.endDate,
    required this.amountSpent,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final String amountSpent;

  List<DateTime> _generateDateRange() {
    final now = DateTime.now();
    final start = startDate ?? now.subtract(const Duration(days: 6));
    final end = endDate ?? now;

    List<DateTime> days = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      days.add(DateTime(start.year, start.month, start.day + i));
    }
    return days;
  }

  List<double> _generateMockSpendingData(int count) {
    final random = [
      100, 250, 320, 500, 480, 300, 600, 400, 450, 700,
    ];
    return List.generate(count, (i) => random[i % random.length].toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final dateRange = _generateDateRange();
    final spendingData = _generateMockSpendingData(dateRange.length);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amountSpent,
                  style: const TextStyle(
                    fontSize: AppSizes.lg,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1,
                  ),
                ),
                RoundedIcon(
                  borderRadius: AppSizes.sm,
                  applyIconRadius: true,
                  padding: const EdgeInsets.all(8),
                  width: 36,
                  height: 36,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  iconPath: AppIcons.analysis,
                  size: 20,
                ),
              ],
            ),

            const Text(
              'Số tiền đã chi tiêu trong khoảng thời gian đã chọn',
              style: TextStyle(color: AppColors.text4),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 800,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 24,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < dateRange.length) {
                            final date = dateRange[index];
                            final label = DateFormat('dd/MM').format(date);
                            return Text(
                              label,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.text4,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 200,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.text4,
                          ),
                        ),
                      ),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        spendingData.length,
                        (i) => FlSpot(i.toDouble(), spendingData[i]),
                      ),
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],

                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => AppColors.primary,
                      tooltipBorderRadius: BorderRadius.circular(8.0),
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((barSpot) {
                          return LineTooltipItem(
                            "${DateFormat('dd/MM').format(dateRange[barSpot.x.toInt()])}\n${barSpot.y.toInt()}",
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
