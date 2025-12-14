import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/navigation/nav_controller.dart';
import 'package:money_care/presentation/screens/home/home.dart';
import 'package:money_care/presentation/screens/user_center/user_center.dart';
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
      UserCenterScreen(),
    ];

    return Obx(() {
      final currentIndex = controller.selectedIndex.value;

      return Scaffold(
        body: SafeArea(
          child: IndexedStack(index: currentIndex, children: screens),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showTransactionOptions(context),
          shape: const CircleBorder(),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((
              states,
            ) {
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
      isActive ? 'assets/icons/$path-active.svg' : 'assets/icons/$path.svg',
      width: 24,
      height: 24,
    );
  }

  void _showTransactionOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Chọn loại giao dịch'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed('/income');
              },
              child: const Text('Tạo thu'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed('/expense');
              },
              child: const Text('Tạo chi'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy bỏ'),
          ),
        );
      },
    );
  }
}
