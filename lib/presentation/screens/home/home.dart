import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/core/utils/date_picker_util.dart';
import 'package:money_care/presentation/screens/home/widgets/search_anchor.dart';
import 'package:money_care/presentation/screens/home/widgets/spending_limit_card.dart';
import 'package:money_care/presentation/screens/home/widgets/spending_overview_card.dart';
import 'package:money_care/presentation/screens/home/widgets/spending_summary.dart';
import 'package:money_care/presentation/screens/home/widgets/category_section.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction_section.dart';
import 'package:money_care/presentation/widgets/icon/circular_icon.dart';
import 'package:money_care/presentation/widgets/texts/section_heading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? startDate;
  DateTime? endDate;

  void _pickDateRange() async {
    final picked = await pickDateRange(context);
    if (picked.isNotEmpty) {
      setState(() {
        startDate = picked.first;
        endDate = picked.length > 1 ? picked.last : picked.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chào Mừng, Tuyển",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.text4,
                  ),
                ),

                Row(
                  children: [
                    CircularIcon(
                      iconPath: AppIcons.search,
                      backgroundColor: Color(0XFFF5FAFE),
                      height: 36,
                      width: 36,
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: '',
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, anim1, anim2) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 80,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: SearchAnchorCustom(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    CircularIcon(
                      iconPath: AppIcons.notification,
                      backgroundColor: Color(0XFFF5FAFE),
                      height: 36,
                      width: 36,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSizes.defaultSpace),
            SpendingSummary(balance: '1.000.000', spending: '250.000'),

            const SizedBox(height: AppSizes.defaultSpace),
            AppSectionHeading(
              title: "Chi theo phân loại",
              showActionButton: false,
            ),

            const SizedBox(height: AppSizes.defaultSpace),
            CategorySection(),

            const SizedBox(height: AppSizes.defaultSpace),
            AppSectionHeading(title: "Giao dịch gần đây"),

            const SizedBox(height: AppSizes.defaultSpace),
            TransactionSection(),

            const SizedBox(height: AppSizes.defaultSpace),
            AppSectionHeading(title: "Tổng quan", showActionButton: false),
            const SizedBox(height: AppSizes.spaceBtwItems),
            GestureDetector(
              onTap: _pickDateRange,
              child: Row(
                children: [
                  Icon(Icons.calendar_month_outlined, size: 18),
                  SizedBox(width: 4),
                  Text('Chọn Khoảng ngày'),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.defaultSpace),

            SpendingOverviewCard(
              startDate: startDate,
              endDate: endDate,
              amountSpent: '2,000,000',
            ),

            const SizedBox(height: AppSizes.defaultSpace),
            AppSectionHeading(title: "Hạn mực chi tiêu"),
            const SizedBox(height: AppSizes.defaultSpace),

            SpendingLimitCard(
              title: "Cần thiết",
              limitText: "5,000,000",
              spentText: "3,200,000",
              iconPath: AppIcons.essential,
              isOverLimit: false,
            ),
            SpendingLimitCard(
              title: "ào tạo",
              limitText: "2,000,000",
              spentText: "1,200,000",
              iconPath: AppIcons.education,
              isOverLimit: false,
            ),
            SpendingLimitCard(
              title: "Hưởng thụ",
              limitText: "1,000,000",
              spentText: "800,000",
              iconPath: AppIcons.pleasure,
              isOverLimit: false,
            ),
            SpendingLimitCard(
              title: "Tiết kiệm",
              limitText: "3,000,000",
              spentText: "1,000,000",
              iconPath: AppIcons.savings,
              isOverLimit: false,
            ),
            SpendingLimitCard(
              title: "Từ thiện",
              limitText: "500,000",
              spentText: "300,000",
              iconPath: AppIcons.charity,
              isOverLimit: false,
            ),
            SpendingLimitCard(
              title: "Tự do",
              limitText: "2,500,000",
              spentText: "5,700,000",
              iconPath: AppIcons.freedom,
              isOverLimit: true,
            ),
          ],
        ),
      ),
    );
  }
}
