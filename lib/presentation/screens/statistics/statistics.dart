import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/presentation/screens/statistics/widgets/description/description_total.dart';
import 'package:money_care/presentation/screens/statistics/widgets/chart/overview_chart.dart';
import 'package:money_care/presentation/screens/statistics/widgets/chart/savings_line_chart.dart';
import 'package:money_care/presentation/screens/statistics/widgets/statistical.dart';
import 'package:money_care/presentation/screens/statistics/widgets/statistics_header.dart';
import 'package:money_care/presentation/widgets/texts/section_heading.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String selected = 'chi';

  List<String> generateLast7DaysLabels() {
    final List<String> labels = [];
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM');

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      labels.add(formatter.format(date));
    }
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 195,
                decoration: const BoxDecoration(
                  color: Color(0xFF0B84FF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: StatisticsHeader(
                  selected: selected,
                  onSelected: (value) => setState(() => selected = value),
                  title: "Thống kê",
                  spendText: "5.500.000",
                  incomeText: "9.900.000",
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppSectionHeading(
                  title: "Tổng chi tiêu theo tháng",
                  showActionButton: true,
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SavingsLineChart(
                  xLabels: generateLast7DaysLabels(),
                  thisMonthSpots: [
                    FlSpot(0, 400),
                    FlSpot(1, 420),
                    FlSpot(2, 380),
                    FlSpot(3, 800),
                    FlSpot(4, 620),
                    FlSpot(5, 450),
                    FlSpot(6, 460),
                  ],
                  lastMonthSpots: [
                    FlSpot(0, 600),
                    FlSpot(1, 650),
                    FlSpot(2, 620),
                    FlSpot(3, 600),
                    FlSpot(4, 620),
                    FlSpot(5, 600),
                    FlSpot(6, 580),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AppSectionHeading(title: AppTexts.limitOverview),
              ),
              const SizedBox(height: 10),
              StatisticalWidgets(
                dateRange: "01/10/2025 - 31/10/2025",
                totalAmount: "10.000.000 đ",
                categories: [
                  CategoryModel(
                    label: "Chi tiêu",
                    color: Color(0xFF0B84FF),
                    percentage: 40,
                  ),
                  CategoryModel(
                    label: "Ăn uống",
                    color: Colors.orange,
                    percentage: 25,
                  ),
                  CategoryModel(
                    label: "Giải trí",
                    color: Colors.purple,
                    percentage: 20,
                  ),
                  CategoryModel(
                    label: "Tiết kiệm",
                    color: Colors.green,
                    percentage: 15,
                  ),
                ],
              ),

              const SizedBox(height: 25),
              OverviewChart(),
              const SizedBox(height: 25),
              DescriptionTotal(),
            ],
          ),
        ),
      ),
    );
  }
}
