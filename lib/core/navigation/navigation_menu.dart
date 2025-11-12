import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/navigation/nav_controller.dart';
import 'package:money_care/presentation/screens/home/home.dart';
import 'package:money_care/presentation/screens/profile/profile.dart';
import 'package:money_care/presentation/screens/statistics/statistics.dart';
import 'package:money_care/presentation/screens/transaction/transaction.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController controller = Get.put(NavController());

    final List<Widget> screens = const [
      HomeScreen(),
      TransactionScreen(),
      StatisticsScreen(),
      ProfileScreen(),
    ];

    return Obx(() {
      final currentIndex = controller.selectedIndex.value;

      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed('/add-transaction'),
          shape: const CircleBorder(),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                );
              }
              return const TextStyle(
                color: AppColors.text4,
                fontWeight: FontWeight.w400,
              );
            }),
          ),
          child: NavigationBar(
            height: 88,
            elevation: 0,
            selectedIndex: currentIndex,
            onDestinationSelected: controller.changeTab,
            indicatorColor: Colors.transparent,
            backgroundColor: AppColors.white,
            destinations: [
              NavigationDestination(
                icon: buildNavIcon('home', currentIndex == 0),
                label: "Trang chủ",
              ),
              NavigationDestination(
                icon: buildNavIcon('transaction', currentIndex == 1),
                label: "Thu - chi",
              ),
              NavigationDestination(
                icon: buildNavIcon('chart', currentIndex == 2),
                label: "Thống kê",
              ),
              NavigationDestination(
                icon: buildNavIcon('user', currentIndex == 3),
                label: "Cá nhân",
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildNavIcon(String path, bool isActive) {
    return SvgPicture.asset(
      isActive ? 'icons/$path-active.svg' : 'icons/$path.svg',
      width: 24,
      height: 24,
    );
  }
}
