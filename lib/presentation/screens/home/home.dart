import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/controllers/filter_controller.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/controllers/user_controller.dart';
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
  final SavingFundController fundController = Get.find<SavingFundController>();
  final UserController userController = Get.find<UserController>();
  final SavingFundController savingFundController =
      Get.find<SavingFundController>();
  final AuthController authController = Get.find<AuthController>();

  late int userId;

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  Future<void> initUserInfo() async {
    Map<String, dynamic> userInfoJson = StorageService().getUserInfo()!;
    UserModel user = UserModel.fromJson(userInfoJson, '');
    setState(() {
      userId = user.id;
    });
    loadData();
    userController.currentProlife(user.profile);
    savingFundController.updateFundId(user.savingFund!.id);
  }

  Future<void> loadData() async {
    transactionController.getTotalByType(userId);
    transactionController.getTotalByCate(userId);
    transactionController.filterTransactions(
      userId,
      TransactionFilterDto(
        fundId:
            fundController.currentFundId > 0
                ? fundController.currentFundId
                : null,
        startDate: filterController.startDate.toString(),
        endDate: filterController.endDate.toString(),
      ),
    );
    transactionController.getTotalByDate(
      userId,
      TransactionTotalsDto(
        fundId:
            fundController.currentFundId > 0
                ? fundController.currentFundId
                : null,
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
          fundId:
              fundController.fundId.value > 0
                  ? fundController.fundId.value
                  : null,
          startDate: startDate.toIso8601String(),
          endDate: endDate.toIso8601String(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  final profile = userController.userProfile.value;

                  if (userController.isLoading.value) {
                    return const SizedBox(
                      height: 120,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (profile == null) {
                    return const Text(
                      "Chào Mừng!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.text4,
                      ),
                    );
                  }

                  final fullName = profile.fullName;

                  return Text(
                    "Chào Mừng, $fullName",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.text4,
                    ),
                  );
                }),

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
                                            .transactionByfilter
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
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircularIcon(
                          onTap: () => Get.toNamed('/pending_transaction'),
                          iconPath: AppIcons.notification,
                          backgroundColor: const Color(0XFFF5FAFE),
                          height: 36,
                          width: 36,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
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
                      onTap: () {
                        Get.toNamed('/expense');
                      },
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
              final totalsData = transactionController.totalByDate.value;

              if (transactionController.isLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (totalsData == null || totalsData.expense.isEmpty) {
                return const SizedBox(
                  height: 120,
                  child: Center(child: Text('Không có dữ liệu')),
                );
              }

              final totals = totalsData.expense;
              double totalSpent = totals.fold(0, (sum, t) => sum + t.total);

              return SpendingOverviewCard(
                startDate: startDate,
                endDate: endDate,
                totals: totals,
                amountSpent: totalSpent,
              );
            }),

            const SizedBox(height: AppSizes.defaultSpace),

            AppSectionHeading(title: "Hạn mức chi tiêu"),
            const SizedBox(height: AppSizes.defaultSpace),

            Obx(() {
              final categories = transactionController.totalByCate;
              final monthlyIncome =
                  userController.userProfile.value!.monthlyIncome;
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
                        limit:
                            ((category.percentage) * (monthlyIncome ?? 0)) /
                            100,
                        spent: category.total,
                        iconPath: 'assets/icons/${category.categoryIcon}.svg',
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
