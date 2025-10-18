import 'package:go_router/go_router.dart';
import 'package:money_care/core/navigation/navigation_menu.dart';
import 'package:money_care/presentation/screens/home/home.dart';
import 'package:money_care/presentation/screens/login/login.dart';
import 'package:money_care/presentation/screens/profile/profile.dart';
import 'package:money_care/presentation/screens/register/register.dart';
import 'package:money_care/presentation/screens/statistics/statistics.dart';
import 'package:money_care/presentation/screens/transaction/expensense.dart';
import 'package:money_care/presentation/screens/transaction/transaction.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
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
  ],
);
