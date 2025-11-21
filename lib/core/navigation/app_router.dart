import 'package:get/get.dart';
import 'package:money_care/core/navigation/navigation_menu.dart';
import 'package:money_care/presentation/screens/forgot_password/otp.dart';
import 'package:money_care/presentation/screens/forgot_password/reset_password.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_expense_management.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_financial_freedom.dart';
import 'package:money_care/presentation/screens/forgot_password/forgot_password.dart';
import 'package:money_care/presentation/screens/login/login.dart';
import 'package:money_care/presentation/screens/login/login_option.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_income.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_welcome.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_saving_rule.dart';
import 'package:money_care/presentation/screens/register/register.dart';
import 'package:money_care/presentation/screens/select_saving_fund/create_saving_fund.dart';
import 'package:money_care/presentation/screens/select_saving_fund/select_saving_fund.dart';
import 'package:money_care/presentation/screens/splash/splash.dart';
import 'package:money_care/presentation/screens/transaction/Income.dart';
import 'package:money_care/presentation/screens/transaction/expense.dart';

final List<GetPage> appPages = [
  GetPage(name: '/splash', page: () => const SplashScreen()),
  GetPage(
    name: '/onboarding_expense_management',
    page: () => const OnboardingExpenseManagementScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/onboarding_financial_freedom',
    page: () => const OnboardingFinancialFreedomScreen(),
    transition: Transition.leftToRight,
  ),
  GetPage(name: '/select_method_login', page: () => const LoginOptionScreen()),
  GetPage(name: '/forgot_password', page: () => const ForgotPasswordScreen()),
  GetPage(name: '/otp', page: () => const OtpScreen()),
  GetPage(name: '/reset_password', page: () => const ResetPasswordScreen()),
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/register', page: () => const RegisterScreen()),
  GetPage(
    name: '/onboarding_welcome',
    page: () => const OnboardingWelcomeScreen(),
  ),
  GetPage(
    name: '/onboarding_saving_rule',
    page: () => const OnboardingSavingRuleScreen(),
  ),
    GetPage(
    name: '/onboarding_income',
    page: () => const OnboardingIncomeScreen(),
  ),
  GetPage(
    name: '/select_saving_fund',
    page: () => const SelectSavingFundScreen(),
  ),
  GetPage(
    name: '/create_saving_fund',
    page: () => const CreateSavingFund(),
  ),
  GetPage(
    name: '/expense',
    page: () => const ExpenseScreen(),
  ),
    GetPage(
    name: '/income',
    page: () => const IncomeScreen(),
  ),

  GetPage(name: '/main', page: () => const ScaffoldWithNavBar()),
];
