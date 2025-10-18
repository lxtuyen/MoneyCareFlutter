import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/constants/colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();

    int currentIndex = _getCurrentIndex(currentLocation);

    return Scaffold(
      body: SafeArea(child: child),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: thêm logic mở trang thêm giao dịch
          context.go('/add-transaction');
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
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
          onDestinationSelected: (index) => _onTabTapped(context, index),
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
  }

  Widget buildNavIcon(String path, bool isActive) {
    return SvgPicture.asset(
      isActive ? 'icons/$path-active.svg' : 'icons/$path.svg',
      width: 24,
      height: 24,
    );
  }

  // Xác định tab hiện tại dựa trên location của GoRouter
  int _getCurrentIndex(String location) {
    if (location.startsWith('/transaction')) return 1;
    if (location.startsWith('/statistics')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; // Mặc định là Home
  }

  // Điều hướng đến tab mới khi chọn trên BottomNavigationBar
  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.push('/');
        break;
      case 1:
            _showTransactionOptions(context);

        // context.push('/transaction');
        break;
      case 2:
        context.push('/statistics');
        break;
      case 3:
        context.push('/profile');
        break;
    }
  }
}
void _showTransactionOptions(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text('Chọn loại giao dịch'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            context.push('/expensense');
          },
          child: const Text('💰 Tiền thu'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            context.pushNamed('addTransaction', queryParameters: {'type': 'expense'});
          },
          child: const Text('💸 Tiền chi'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () => Navigator.pop(context),
        child: const Text('Hủy bỏ'),
      ),
    ),
  );
}
