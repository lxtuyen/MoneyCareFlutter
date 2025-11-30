import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class SavingsGoals extends StatelessWidget {
  final double currentSaving;
  final double targetSaving;

  const SavingsGoals({
    super.key,
    required this.currentSaving,
    required this.targetSaving,
  });

  @override
  Widget build(BuildContext context) {
    double percent = 0;

    if (targetSaving > 0) {
      percent = currentSaving / targetSaving;
    }

    percent = percent.clamp(0.0, 1.0);

    String getStatus(double percent) {
      if (percent < 0.3) return "Kém";
      if (percent < 0.6) return "Trung bình";
      if (percent < 1.0) return "Tốt";
      return "Xuất sắc";
    }

    Color getStatusColor(double percent) {
      if (percent < 0.3) return Colors.red;
      if (percent < 0.6) return Colors.orange;
      if (percent < 1.0) return Colors.blue;
      return Colors.green;
    }

    final formatter = NumberFormat.decimalPattern('vi');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.text5,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppTexts.targetTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey.shade300,
            color: AppColors.primary,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatter.format(currentSaving),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                formatter.format(targetSaving),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 13.0,
              animation: true,
              percent: percent,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tài khoản", style: TextStyle(fontSize: 14)),
                  Text(
                    formatter.format(currentSaving),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getStatus(percent),
                    style: TextStyle(
                      color: getStatusColor(percent),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: AppColors.primary,
              backgroundColor: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
