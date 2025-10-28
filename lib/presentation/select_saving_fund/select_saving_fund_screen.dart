import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/widgets/icon/rounded_icon.dart';

class SelectSavingFundScreen extends StatefulWidget {
  const SelectSavingFundScreen({super.key});

  @override
  State<SelectSavingFundScreen> createState() => _SelectSavingFundScreenState();
}

class _SelectSavingFundScreenState extends State<SelectSavingFundScreen> {
  int selectedIndex = 0;

  final List<List<Map<String, dynamic>>> fundGroups = [
    [
      {"icon": AppIcons.essential, "label": "Cần thiết", "percent": "50%"},
      {"icon": AppIcons.education, "label": "Đào tạo", "percent": "10%"},
      {"icon": AppIcons.pleasure, "label": "Hưởng thụ", "percent": "10%"},
      {"icon": AppIcons.savings, "label": "Tiết kiệm", "percent": "10%"},
      {"icon": AppIcons.charity, "label": "Từ thiện", "percent": "5%"},
      {"icon": AppIcons.freedom, "label": "Tự do", "percent": "10%"},
    ],
    [
      {"icon": AppIcons.essential, "label": "Cần thiết", "percent": "55%"},
      {"icon": AppIcons.education, "label": "Đào tạo", "percent": "5%"},
      {"icon": AppIcons.pleasure, "label": "Hưởng thụ", "percent": "10%"},
      {"icon": AppIcons.savings, "label": "Tiết kiệm", "percent": "28%"},
      {"icon": AppIcons.charity, "label": "Từ thiện", "percent": "2%"},
      {"icon": AppIcons.freedom, "label": "Tự do", "percent": "5%"},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Lựa chọn quỹ tiết kiệm?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: fundGroups.length,
                    itemBuilder: (context, index) {
                      final group = fundGroups[index];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children:
                                group.map((item) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RoundedIcon(
                                        padding: const EdgeInsets.all(
                                          AppSizes.sm,
                                        ),
                                        applyIconRadius: true,
                                        width: 40,
                                        height: 40,
                                        backgroundColor:
                                            AppColors.backgroundSecondary,
                                        iconPath: item["icon"] as String,
                                        size: AppSizes.lg,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item["label"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        item["percent"],
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEEF0F5),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Tự tạo quỹ tiết kiệm'),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text(
                      "Xác nhận",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: AppColors.backgroundPrimary),
                    ),
                    child: const Text(
                      "Quay lại",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
