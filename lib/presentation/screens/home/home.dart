import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/filter_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/core/utils/date_picker_util.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/dto/transaction_filter_dto.dart';
import 'package:money_care/models/dto/transaction_totals_dto.dart';
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
  late DateTime startDate = now.subtract(const Duration(days: 6));
  late DateTime endDate = now;
  final TransactionController transactionController =
      Get.find<TransactionController>();
  final FilterController filterController = Get.find<FilterController>();
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
    transactionController.filterTransactions(
      userId,
      TransactionFilterDto(
        startDate: filterController.startDate.toString(),
        endDate: filterController.endDate.toString(),
      ),
    );
    transactionController.getTotalByDate(
      userId,
      TransactionTotalsDto(
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String(),
      ),
    );
  }

  void _pickDateRange() async {
    final picked = await pickDateRange(context);
    if (picked.isNotEmpty) {
      setState(() {
        startDate = picked.first!;
        endDate = (picked.length > 1 ? picked.last : picked.first)!;
      });
      transactionController.getTotalByDate(
        userId,
        TransactionTotalsDto(
          startDate: startDate.toIso8601String(),
          endDate: endDate.toIso8601String(),
        ),
      );
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
                                  child: Obx(() {
                                    final transactions =
                                        transactionController
                                            .transactionByType
                                            .value!
                                            .expenseTransactions;

                                    if (transactionController.isLoading.value) {
                                      return const SizedBox(
                                        height: 120,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    return SearchAnchorCustom(
                                      listData: transactions,
                                    );
                                  }),
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

              if (totals == null) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: Text('Không có dữ liệu')),
                );
              }

              return SpendingSummary(
                incomeTotal: totals.incomeTotal,
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

              if (categories.isEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundPrimary,
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardRadiusLg,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: AppColors.text5,
                            size: 28,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: AppSizes.defaultSpace),
                    Expanded(
                      child: Text(
                        "Tạo hoặc lựa chọn quỹ tiết kiệm để chúng tôi giúp bạn quản lý tài chính hiệu quả",
                        style: TextStyle(
                          color: AppColors.text4,
                          fontSize: AppSizes.fontSizeSm,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return CategorySection(categories: categories);
            }),

            const SizedBox(height: AppSizes.defaultSpace),

            AppSectionHeading(title: "Giao dịch gần đây"),
            const SizedBox(height: AppSizes.defaultSpace),
            Obx(() {
              final transactions =
                  transactionController.transactionByfilter.value;
              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (transactions == null) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: Text('Không có dữ liệu')),
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
            Obx(() {
              final totals = transactionController.totalByDate;

              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              double totalSpent = totals.fold(0, (sum, t) => sum + t.total);
              return SpendingOverviewCard(
                startDate: startDate,
                endDate: endDate,
                totals: totals,
                amountSpent: totalSpent.toString(),
              );
            }),

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
