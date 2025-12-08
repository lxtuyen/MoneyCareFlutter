import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/header_menu_button_db.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/overview_card.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/top_category_card.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/top_revenue_card.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/user_stats_grid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isWeekSelected = true;

  @override
  Widget build(BuildContext context) {
    final sectionTitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.text1,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ===== NỘI DUNG CHÍNH: HEADER + SCROLL =====
            Column(
              children: [
                // ===== HEADER =====
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ---- MENU BUTTONS (Dashboard / Người dùng) ----
                      Row(
                        children: [
                          HeaderMenuButtonDashBoard(
                            label: 'Dashboard',
                            isActive: true,
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          HeaderMenuButtonDashBoard(
                            label: 'Người dùng',
                            isActive: false,
                            onTap: () {
                              context.go('/users');
                            },
                          ),
                        ],
                      ),

                      // ---- AVATAR ADMIN ----
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Admin',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ===== NỀN MÀU XANH NHẸ + NỘI DUNG CUỘN =====
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFE4F3F9),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ).copyWith(
                        bottom:
                            120, 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ===== TỔNG KẾT + CHART =====
                          Text('Tổng kết', style: sectionTitleStyle),
                          const SizedBox(height: 8),
                          BuildOverviewCard(
                            isWeekSelected: _isWeekSelected,
                            onWeekTap: () {
                              setState(() {
                                _isWeekSelected = true;
                              });
                            },
                            onMonthTap: () {
                              setState(() {
                                _isWeekSelected = false;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          // ===== THỐNG KÊ NGƯỜI DÙNG =====
                          Text('Thống kê người dùng', style: sectionTitleStyle),
                          const SizedBox(height: 8),
                          BuildUserStatsGrid(),

                          const SizedBox(height: 16),

                          // ===== TOP HẠNG MỤC CHI =====
                          Text(
                            'Top hạng mục chi từ tất cả các người dùng',
                            style: sectionTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          TopCategoryCard(),

                          const SizedBox(height: 16),

                          // ===== TOP HẠNG MỤC THU =====
                          Text(
                            'Top hạng mục thu từ tất cả các người dùng',
                            style: sectionTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          TopRevenueCard(),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
