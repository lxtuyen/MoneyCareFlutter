import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/presentation/screens/profile/widgets/menu_item.dart';
import 'package:money_care/presentation/screens/profile/widgets/savings_goals.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double currentSaving = 4500000;
    double targetSaving = 7500000;

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTexts.profileTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 22),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SavingsGoals(
                      currentSaving: currentSaving,
                      targetSaving: targetSaving,
                    ),
                    const SizedBox(height: 20),

                    BuildMenuItem(
                      icon: Icons.person_outline,
                      title: AppTexts.profile,
                      onTap: () {},
                    ),
                    BuildMenuItem(
                      icon: Icons.insert_chart_outlined,
                      title: AppTexts.reportOfTheYear,
                      onTap: () {},
                    ),
                    BuildMenuItem(
                      icon: Icons.category_outlined,
                      title: AppTexts.annualPortfolioReport,
                      onTap: () {},
                    ),
                    BuildMenuItem(
                      icon: Icons.account_balance_wallet_outlined,
                      title: AppTexts.fixedCosts,
                      onTap: () {},
                    ),
                    BuildMenuItem(
                      icon: Icons.help_outline,
                      title: AppTexts.helpTitle,
                      onTap: () {},
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
