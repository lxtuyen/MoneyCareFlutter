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

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  late bool _isSidebarExpanded;

  @override
  void initState() {
    super.initState();
    _isSidebarExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    final NavController controller = Get.put(NavController());
    final isWeb = MediaQuery.of(context).size.width > 800;

    final List<Widget> screens = const [
      HomeScreen(),
      TransactionScreen(),
      StatisticsScreen(),
      UserCenterScreen(),
    ];

    final List<Map<String, dynamic>> navItems = [
      {'icon': 'home', 'label': 'Trang chủ'},
      {'icon': 'transaction', 'label': 'Thu - chi'},
      {'icon': 'chart', 'label': 'Thống kê'},
      {'icon': 'user', 'label': 'Cá nhân'},
    ];

    return Obx(() {
      final currentIndex = controller.selectedIndex.value;

      if (isWeb) {
        return Scaffold(
          body: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: _isSidebarExpanded ? 250 : 80,
                color: AppColors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_isSidebarExpanded)
                            Expanded(
                              child: Text(
                                'Money Care',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isSidebarExpanded = !_isSidebarExpanded;
                              });
                            },
                            icon: Icon(
                              _isSidebarExpanded
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                              color: AppColors.primary,
                            ),
                            tooltip: _isSidebarExpanded
                                ? 'Thu gọn sidebar'
                                : 'Mở rộng sidebar',
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView.builder(
                        itemCount: navItems.length,
                        itemBuilder: (context, index) {
                          final isActive = currentIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.primary.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Tooltip(
                                message: _isSidebarExpanded
                                    ? ''
                                    : navItems[index]['label'],
                                child: ListTile(
                                  onTap: () => controller.changeTab(index),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: _isSidebarExpanded ? 16 : 8,
                                  ),
                                  leading: SvgPicture.asset(
                                    isActive
                                        ? 'assets/icons/${navItems[index]['icon']}-active.svg'
                                        : 'assets/icons/${navItems[index]['icon']}.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  title: _isSidebarExpanded
                                      ? Text(
                                          navItems[index]['label'],
                                          style: TextStyle(
                                            color: isActive
                                                ? AppColors.primary
                                                : AppColors.text4,
                                            fontWeight: isActive
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: _isSidebarExpanded
                          ? FloatingActionButton.extended(
                              onPressed: () => _showTransactionOptions(context),
                              backgroundColor: AppColors.primary,
                              icon: const Icon(Icons.add, color: Colors.white,),
                              label: const Text('Giao dịch', style: TextStyle(color: Colors.white),),
                            )
                          : FloatingActionButton(
                              onPressed: () =>
                                  _showTransactionOptions(context),
                              backgroundColor: AppColors.primary,
                              child: const Icon(Icons.add),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SafeArea(
                  child: IndexedStack(index: currentIndex, children: screens),
                ),
              ),
            ],
          ),
        );
      } else {
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle:
                  MaterialStateProperty.resolveWith<TextStyle>((states) {
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
              destinations: navItems
                  .asMap()
                  .entries
                  .map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> item = entry.value;
                    return NavigationDestination(
                      icon: buildNavIcon(item['icon'], currentIndex == index),
                      label: item['label'],
                    );
                  })
                  .toList(),
            ),
          ),
        );
      }
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