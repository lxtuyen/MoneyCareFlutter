import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/navigation/navigation_menu.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/presentation/screens/forgot_password/otp.dart';
import 'package:money_care/presentation/screens/forgot_password/reset_password.dart';
import 'package:money_care/presentation/screens/home/home.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_expense_management.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_financial_freedom.dart';
import 'package:money_care/presentation/screens/forgot_password/forgot_password.dart';
import 'package:money_care/presentation/screens/login/login.dart';
import 'package:money_care/presentation/screens/login/login_option.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_welcome.dart';
import 'package:money_care/presentation/screens/onboarding/onboarding_saving_rule.dart';
import 'package:money_care/presentation/screens/profile/profile.dart';
import 'package:money_care/presentation/screens/register/register.dart';
import 'package:money_care/presentation/screens/splash/splash.dart';
import 'package:money_care/presentation/screens/statistics/statistics.dart';
import 'package:money_care/presentation/screens/transaction/Income.dart';
import 'package:money_care/presentation/screens/transaction/expensense.dart';
import 'package:money_care/presentation/screens/transaction/transaction.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',

  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'onboarding_expense_management',
      path: '/onboarding_expense_management',
      pageBuilder:
          (context, state) => AppHelperFunction.slidePage(
            child: const OnboardingExpenseManagementScreen(),
            state: state,
            begin: const Offset(1.0, 0.0),
          ),
    ),
    GoRoute(
      name: 'onboarding_financial_freedom',
      path: '/onboarding_financial_freedom',
      pageBuilder:
          (context, state) => AppHelperFunction.slidePage(
            child: const OnboardingFinancialFreedomScreen(),
            state: state,
            begin: const Offset(-1.0, 0.0),
          ),
    ),
    GoRoute(
      name: 'select_method_login',
      path: '/select_method_login',
      builder: (context, state) => const LoginOptionScreen(),
    ),
    GoRoute(
      name: 'forgot_password',
      path: '/forgot_password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      name: 'otp',
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      name: 'reset_password',
      path: '/reset_password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'onboarding_welcome',
      path: '/onboarding_welcome',
      builder: (context, state) => const OnboardingWelcomeScreen(),
    ),
    GoRoute(
      name: 'onboarding_saving_rule',
      path: '/onboarding_saving_rule',
      builder: (context, state) => const OnboardingSavingRuleScreen(),
    ),

    ShellRoute(
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: ScaffoldWithNavBar(child: child));
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: 'transaction',
          path: '/transaction',
          builder: (context, state) => const TransactionScreen(),
        ),

        GoRoute(
          name: 'statistics',
          path: '/statistics',
          builder: (context, state) => const StatisticsScreen(),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'expensense',
      path: '/expensense',
      builder: (context, state) => const ExpensenseHomescreen(),
    ),
     GoRoute(
      name: 'income',
      path: '/income',
      builder: (context, state) => const IncomeScreen(),
    ),
  ],
);
