import 'package:get/get.dart';
import 'package:money_care/core/bindings/auth_binding.dart';
import 'package:money_care/core/navigation/navigation_menu.dart';
import 'package:money_care/presentation/screens/forgot_password/otp.dart';
import 'package:money_care/presentation/screens/forgot_password/reset_password.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_expense_management.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_financial_freedom.dart';
import 'package:money_care/presentation/screens/forgot_password/forgot_password.dart';
import 'package:money_care/presentation/screens/login/login.dart';
import 'package:money_care/presentation/screens/login/login_option.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_welcome.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_saving_rule.dart';
import 'package:money_care/presentation/screens/register/register.dart';
import 'package:money_care/presentation/screens/splash/splash.dart';

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
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/register',
    page: () => const RegisterScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/onboarding_welcome',
    page: () => const OnboardingWelcomeScreen(),
  ),
  GetPage(
    name: '/onboarding_saving_rule',
    page: () => const OnboardingSavingRuleScreen(),
  ),

  GetPage(name: '/main', page: () => const ScaffoldWithNavBar()),
];
