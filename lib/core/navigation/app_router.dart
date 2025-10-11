import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/navigation/navigation_menu.dart';
import 'package:money_care/presentation/screens/forgot_password/otp.dart';
import 'package:money_care/presentation/screens/forgot_password/reset_password.dart';
import 'package:money_care/presentation/screens/home/home.dart';
import 'package:money_care/presentation/screens/introduce/introduce.dart';
import 'package:money_care/presentation/screens/introduce/next_introduce.dart';
import 'package:money_care/presentation/screens/forgot_password/forgot_password.dart';
import 'package:money_care/presentation/screens/login/login.dart';
import 'package:money_care/presentation/screens/login/select_login.dart';
import 'package:money_care/presentation/screens/onboarding/begin.dart';
import 'package:money_care/presentation/screens/onboarding/begin_1.dart';
import 'package:money_care/presentation/screens/profile/profile.dart';
import 'package:money_care/presentation/screens/register/register.dart';
import 'package:money_care/presentation/screens/statistics/statistics.dart';
import 'package:money_care/presentation/screens/transaction/transaction.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/introduce',

  routes: [
    GoRoute(
      name: 'introduce',
      path: '/introduce',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const IntroduceScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // từ phải sang trái
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      name: 'nextintro',
      path: '/nextintro',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const NextIntroduceScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      name: 'selectlogin',
      path: '/selectlogin',
      builder: (context, state) => const SelectLoginScreen(),
    ),
    GoRoute(
      name: 'forgot-password',
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      name: 'otp',
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      name: 'reset-password',
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
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
      name: 'begin',
      path: '/begin',
      builder: (context, state) => const BeginScreen(),
    ),
    GoRoute(
      name: 'begin1',
      path: '/begin1',
      builder: (context, state) => const Begin1Screen(),
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
  ],
);
