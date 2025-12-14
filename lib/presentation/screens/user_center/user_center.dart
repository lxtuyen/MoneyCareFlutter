import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/controllers/user_controller.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/user_model.dart';
import 'package:money_care/presentation/screens/user_center/widgets/menu_item.dart';
import 'package:money_care/presentation/screens/user_center/widgets/savings_goals.dart';

class UserCenterScreen extends StatefulWidget {
  const UserCenterScreen({super.key});

  @override
  State<UserCenterScreen> createState() => _UserCenterScreenState();
}

class _UserCenterScreenState extends State<UserCenterScreen> {
  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();

  final TransactionController transactionController =
      Get.find<TransactionController>();

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    Map<String, dynamic> userInfoJson = StorageService().getUserInfo()!;
    UserModel user = UserModel.fromJson(userInfoJson, '');
    transactionController.getTotalByType(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: const Center(
                  child: Text(
                    AppTexts.profileTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final data = transactionController.totalByType.value;
                      final monthlyIncome = userController.userProfile.value!.monthlyIncome;

                      if (transactionController.isLoading.value ||
                          monthlyIncome == null) {
                        return const SizedBox(
                          height: 120,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (data == null) {
                        return SavingsGoals(
                          currentSaving: 0,
                          targetSaving: 0,
                        );
                      }

                      return SavingsGoals(
                        currentSaving: (data.incomeTotal - data.expenseTotal).toDouble(),
                        targetSaving: monthlyIncome.toDouble(),
                      );
                    }),

                    const SizedBox(height: 20),

                    BuildMenuItem(
                      icon: Icons.person_outline,
                      title: AppTexts.profile,
                      onTap: () => Get.toNamed('/profile'),
                    ),
                    BuildMenuItem(
                      icon: Icons.insert_chart_outlined,
                      title: 'Kết nối ngân hàng',
                      onTap: () => Get.toNamed('/mail_connect'),
                    ),
                    BuildMenuItem(
                      icon: Icons.category_outlined,
                      title: AppTexts.savingFunds,
                      onTap: () => Get.toNamed('/select_saving_fund'),
                    ),
                    BuildMenuItem(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Đăng ký VIP',
                      onTap: () {},
                    ),
                    BuildMenuItem(
                      icon: Icons.exit_to_app,
                      title: AppTexts.logout,
                      onTap: () {
                        authController.logout();
                        Get.offAllNamed('/select_method_login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
