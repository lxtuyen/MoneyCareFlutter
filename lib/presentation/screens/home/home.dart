import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/core/utils/date_picker_util.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/user_model.dart';
import 'package:money_care/presentation/screens/home/widgets/search_anchor.dart';
import 'package:money_care/presentation/screens/home/widgets/spending_summary/spending_limit_card.dart';
import 'package:money_care/presentation/screens/home/widgets/spending_summary/spending_overview_card.dart';
import 'package:money_care/presentation/screens/home/widgets/spending_summary/spending_summary.dart';
import 'package:money_care/presentation/screens/home/widgets/category/category_section.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction/transaction_section.dart';
import 'package:money_care/presentation/widgets/icon/circular_icon.dart';
import 'package:money_care/presentation/widgets/texts/section_heading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();
  late DateTime startDate = DateTime(now.year, now.month, 1);
  late DateTime endDate = DateTime(now.year, now.month + 1, 0);
  final TransactionController transactionController =
      Get.find<TransactionController>();
  late int userId;
  String fullName = '';
  late int? monthlyIncome;

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  Future<void> initUserInfo() async {
    Map<String, dynamic> userInfoJson = StorageService().getUserInfo()!;
    UserModel user = UserModel.fromJson(userInfoJson, '');
    setState(() {
      fullName = user.profile.fullName;
      userId = user.id;
      monthlyIncome = user.profile.monthlyIncome;
    });
    loadSavingFundData();
  }

  Future<void> loadSavingFundData() async {
    transactionController.getTotalByType(userId);
    transactionController.getTotalByCate(userId);
    transactionController.getTransactionByType(userId);
  }

  void _pickDateRange() async {
    final picked = await pickDateRange(context);
    if (picked.isNotEmpty) {
      setState(() {
        startDate = picked.first!;
        endDate = (picked.length > 1 ? picked.last : picked.first)!;
      });
      loadSavingFundData();
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
                  "Chào Mừng, $fullName",
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
                      backgroundColor: const Color(0XFFF5FAFE),
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
                                  margin: const EdgeInsets.only(top: 80),
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
                      backgroundColor: const Color(0XFFF5FAFE),
                      height: 36,
                      width: 36,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSizes.defaultSpace),
            Obx(() {
              final totals = transactionController.totalByType.value;

              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SpendingSummary(
                //onPressed: () => Get.toNamed(page),
                incomeTotal: totals!.incomeTotal,
                expenseTotal: totals.expenseTotal,
              );
            }),

            const SizedBox(height: AppSizes.defaultSpace),

            AppSectionHeading(
              title: "Chi theo phân loại",
              showActionButton: false,
            ),

            const SizedBox(height: AppSizes.defaultSpace),

            Obx(() {
              final categories = transactionController.totalByCate;
              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return CategorySection(categories: categories);
            }),

            const SizedBox(height: AppSizes.defaultSpace),

            AppSectionHeading(title: "Giao dịch gần đây"),
            const SizedBox(height: AppSizes.defaultSpace),
            Obx(() {
              final transactions =
                  transactionController.transactionByType.value;
              if (transactions == null) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return TransactionSection(
                incomeTransactions: transactions.incomeTransactions,
                expenseTransactions: transactions.expenseTransactions,
              );
            }),

            const SizedBox(height: AppSizes.defaultSpace),

            AppSectionHeading(title: "Tổng quan", showActionButton: false),
            const SizedBox(height: AppSizes.spaceBtwItems),
            GestureDetector(
              onTap: _pickDateRange,
              child: Row(
                children: const [
                  Icon(Icons.calendar_month_outlined, size: 18),
                  SizedBox(width: 4),
                  Text('Chọn khoảng ngày'),
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

            AppSectionHeading(title: "Hạn mức chi tiêu"),
            const SizedBox(height: AppSizes.defaultSpace),

            Obx(() {
              final categories = transactionController.totalByCate;
              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (categories.isEmpty) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: Text('Không có dữ liệu')),
                );
              }

              return Column(
                children:
                    categories.map((category) {
                      return SpendingLimitCard(
                        title: category.categoryName,
                        limit: (category.percentage) * (monthlyIncome ?? 0),
                        spent: category.total,
                        iconPath: 'icons/${category.categoryIcon}.svg',
                      );
                    }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
