import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/presentation/screens/statistics/widgets/description_total.dart';
import 'package:money_care/presentation/screens/statistics/widgets/overview_chart.dart';
import 'package:money_care/presentation/screens/statistics/widgets/statistical.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String selected = 'chi';

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            AppTexts.statisticsTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Tháng này',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              // 🔹 Tiền chi
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => selected = 'chi'),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1976D2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              selected == 'chi'
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Tiền chi',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Text(
                                          '10.000.000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // 🔹 Tiền thu
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => selected = 'thu'),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1976D2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              selected == 'thu'
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Tiền thu',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Text(
                                          '12.000.000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tổng chi tiêu theo tháng",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Xem thêm",
                        style: TextStyle(color: Color(0xFF0B84FF)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 220,
                  padding: const EdgeInsets.all(8),
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
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.orange,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.orange.withOpacity(0.15),
                          ),
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(1, 2.8),
                            FlSpot(2, 5),
                            FlSpot(3, 4.5),
                            FlSpot(4, 6.2),
                            FlSpot(5, 4.0),
                          ],
                        ),
                        LineChartBarData(
                          isCurved: true,
                          color: Color(0xFF0B84FF),
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Color(0xFF0B84FF).withOpacity(0.15),
                          ),
                          spots: const [
                            FlSpot(0, 2),
                            FlSpot(1, 3.5),
                            FlSpot(2, 3),
                            FlSpot(3, 5),
                            FlSpot(4, 4.2),
                            FlSpot(5, 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppTexts.limitOverview,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              StatisticalWidgets(),
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
